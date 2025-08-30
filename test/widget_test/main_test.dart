import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/home_screen.dart';
import 'test_helper/main_test_helper.dart';

void main() {
  late MockStudentRepository mockRepository;
  late StudentBloc studentBloc;
  setUp(() {
    mockRepository = MockStudentRepository();
    studentBloc = StudentBloc(mockRepository);
  });
  testWidgets('App loads HomeScreen with BlocProvider', (tester) async {
    await tester.pumpWidget(pumpScreen(studentBloc, HomeScreen()));
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
