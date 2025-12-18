abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String msg;

  HomeSuccess(this.msg);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
