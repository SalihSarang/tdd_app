import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import '../../test_helper/student_add_screen_helper.dart';

void main() {
  late MockStudentBloc mockBloc;

  setUpAll(() {
    registerStudentAddScreenFallbacks();
  });

  setUp(() {
    mockBloc = MockStudentBloc();
  });

  testWidgets('renders all fields and button', (tester) async {
    stubBloc(mockBloc, [StudentInitial()]);

    await tester.pumpWidget(makeStudentAddTestableWidget(mockBloc));

    expect(find.byKey(const Key('nameField')), findsOneWidget);
    expect(find.byKey(const Key('batchField')), findsOneWidget);
    expect(find.byKey(const Key('weekField')), findsOneWidget);
    expect(find.byKey(const Key('saveBTN')), findsOneWidget);
  });

  testWidgets('shows CircularProgressIndicator when state is loading', (
    tester,
  ) async {
    stubBloc(mockBloc, [StudentLoading()]);

    await tester.pumpWidget(makeStudentAddTestableWidget(mockBloc));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
