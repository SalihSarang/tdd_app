import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/screens/home_screen.dart';
import '../../test_helper/home_screen_helper.dart';

void main() {
  late MockStudentBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeStudentState());
    registerFallbackValue(FakeStudentEvent());
  });

  setUp(() {
    mockBloc = MockStudentBloc();
  });

  group('Home Screen Testing', () {
    testWidgets('Shows loading indicator when state is StudentLoading', (
      tester,
    ) async {
      when(() => mockBloc.state).thenReturn(StudentLoading());
      when(
        () => mockBloc.stream,
      ).thenAnswer((_) => Stream.value(StudentLoading()));

      await tester.pumpWidget(pumpScreen(mockBloc, const HomeScreen()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
