import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:insta_archiver_mobile/domain/repositories/i_repository.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final IRepository repository;
  StreamSubscription? _intentSub;

  HomeCubit(this.repository) : super(HomeInitial()) {
    _initShareListener();
  }

  void _initShareListener() {
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen((files) {
      if (files.isNotEmpty && files.first.type == SharedMediaType.text) {
        sendUrl(files.first.path);
      }
    });

    ReceiveSharingIntent.instance.getInitialMedia().then((files) {
      if (files.isNotEmpty && files.first.type == SharedMediaType.text) {
        sendUrl(files.first.path);
      }
    });
  }

  Future<void> sendUrl(String url) async {
    emit(HomeLoading());
    try {
      await repository.sendTask(url);
      emit(HomeSuccess('Task queued successfully!'));

      await Future.delayed(const Duration(seconds: 2));
      emit(HomeInitial());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _intentSub?.cancel();
    return super.close();
  }
}
