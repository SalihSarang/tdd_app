import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_app/core/constants/api_endpoints.dart';
import 'package:tdd_app/data/models/student_model.dart';

class StudentRepository {
  final http.Client client;

  StudentRepository({required this.client});

  Future<List<StudentModel>> getStudentsList() async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed To Load Student List');
    }
  }

  Future<StudentModel> getStudentDetails(String id) async {
    final urlDetails = Uri.parse('$url/$id');

    final response = await client.get(urlDetails);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return StudentModel.fromJson(data);
    } else {
      throw Exception('Failed To Load Student Details');
    }
  }

  Future<String> addStudent(StudentModel student) async {
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'studentName': student.name,
        'batch': student.batch,
        'week': student.week,
      }),
    );

    if (response.statusCode == 201) {
      return 'Student Added';
    } else {
      throw Exception('Failed To Load Student Details');
    }
  }

  Future<String> deleteStudent(String studentId) async {
    final deleteUrl = Uri.parse('$url/$studentId');

    final response = await client.delete(deleteUrl);

    if (response.statusCode == 200) {
      return "Delete Success";
    } else {
      throw Exception('Failed To Delete');
    }
  }
}
