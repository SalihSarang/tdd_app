import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/data/repositories/student_repository.dart';
part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repo;

  StudentBloc(this.repo) : super(StudentInitial()) {
    on<FetchAllStudent>(_onFetchStudent);
    on<FetchStudentDetails>(_onFetchStudentDetails);
    on<AddStudent>(_onAddStudent);
    on<DeleteStudent>(_onDelete);
  }

  Future<void> _onFetchStudent(
    FetchAllStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final result = await repo.getStudentsList();
      emit(StudentLoaded(result));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onFetchStudentDetails(
    FetchStudentDetails event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      final result = await repo.getStudentDetails(event.id);

      emit(StudentDetails(result));
    } catch (e) {
      emit(StudentError(e.toString()));
    }
  }

  Future<void> _onAddStudent(
    AddStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      await repo.addStudent(event.student);
      emit(AddingSuccess("Adding Success"));
      add(FetchAllStudent());
    } catch (e) {
      emit(AddingError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteStudent event,
    Emitter<StudentState> emit,
  ) async {
    emit(StudentLoading());
    try {
      await repo.deleteStudent(event.id);

      emit(DeleteSuccess('Delete Stuccess'));
      add(FetchAllStudent());
    } catch (e) {
      emit(StudentError('Delete Failed'));
    }
  }
}
