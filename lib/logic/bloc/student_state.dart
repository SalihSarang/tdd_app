part of 'student_bloc.dart';

class StudentState extends Equatable {
  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  List<StudentModel> students;
  StudentLoaded(this.students);
}

class StudentError extends StudentState {
  String message;
  StudentError(this.message);
}

class StudentDetails extends StudentState {
  StudentModel student;
  StudentDetails(this.student);
}

class AddingSuccess extends StudentState {
  String message;
  AddingSuccess(this.message);
}

class AddingError extends StudentState {
  String message;

  AddingError(this.message);
}

class DeleteSuccess extends StudentState {
  String message;
  DeleteSuccess(this.message);
}
