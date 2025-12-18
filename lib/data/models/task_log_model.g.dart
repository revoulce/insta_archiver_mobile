// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskLogModelAdapter extends TypeAdapter<TaskLogModel> {
  @override
  final int typeId = 0;

  @override
  TaskLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskLogModel(
      id: fields[0] as String,
      url: fields[1] as String,
      status: fields[2] as String,
      message: fields[3] as String,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TaskLogModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
