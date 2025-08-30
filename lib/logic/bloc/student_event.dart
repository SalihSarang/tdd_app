part of 'student_bloc.dart';

class StudentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddStudent extends StudentEvent {
  StudentModel student;
  AddStudent(this.student);
}

class FetchAllStudent extends StudentEvent {}

class FetchStudentDetails extends StudentEvent {
  String id;
  FetchStudentDetails(this.id);
}

class DeleteStudent extends StudentEvent {
  String id;
  DeleteStudent(this.id);
}
