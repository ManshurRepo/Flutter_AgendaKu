// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:agendaku_app/data/datasources/task_remote_datasource.dart';
import 'package:agendaku_app/data/models/task_response_model.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final TaskRemoteDatasource taskRemoteDatasource;
  GetTaskBloc(
    this.taskRemoteDatasource,
  ) : super(GetTaskInitial()) {
    on<DoGetAllTaskEvent>((event, emit) async {
      emit(GetTaskLoading());
      await Future.delayed(const Duration(seconds: 10));
      try {
        final model = await taskRemoteDatasource.getTask();
        emit(GetTaskSuccess(model.data));
      } catch (e) {
        emit(GetTaskFailure(e.toString()));
      }
    });
  }
}
