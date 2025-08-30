import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  String name;
  String batch;
  String week;
  String id;

  StudentModel({
    required this.name,
    required this.batch,
    required this.week,
    required this.id,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['studentName'] ?? '',
      batch: json['batch'] ?? '',
      week: json['week'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'studentName': name, 'batch': batch, 'week': week, 'id': id};
  }

  @override
  List<Object> get props => [id];
}
