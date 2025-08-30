import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import '../../test_helper/details_screen_helper.dart';

void main() {
  late MockStudentBloc mockStudentBloc;

  setUp(() {
    mockStudentBloc = MockStudentBloc();
  });

  tearDown(() {
    mockStudentBloc.close();
  });

  group('DetailScreen Widget Tests', () {
    testWidgets(
      'shows CircularProgressIndicator when state is StudentLoading',
      (tester) async {
        stubStudentBlocState(mockStudentBloc, StudentLoading());

        await tester.pumpWidget(pumpDetailScreen(mockStudentBloc));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('shows student details when state is StudentDetails', (
      tester,
    ) async {
      final student = getFakeStudent();
      stubStudentBlocState(mockStudentBloc, StudentDetails(student));

      await tester.pumpWidget(pumpDetailScreen(mockStudentBloc));

      expect(find.byKey(const Key('nameText')), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.byKey(const Key('batchText')), findsOneWidget);
      expect(find.text('Batch No: B1'), findsOneWidget);
      expect(find.byKey(const Key('weekText')), findsOneWidget);
      expect(find.text('Week No: 2'), findsOneWidget);
    });

    testWidgets('shows error message when state is StudentError', (
      tester,
    ) async {
      stubStudentBlocState(
        mockStudentBloc,
        StudentError('Something went wrong'),
      );

      await tester.pumpWidget(pumpDetailScreen(mockStudentBloc));

      expect(find.byKey(const Key('errorText')), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('renders empty SizedBox when state is StudentInitial', (
      tester,
    ) async {
      stubStudentBlocState(mockStudentBloc, StudentInitial());

      await tester.pumpWidget(pumpDetailScreen(mockStudentBloc));

      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
