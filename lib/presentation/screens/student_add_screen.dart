import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_app/core/utils/add_student_helper.dart';
import 'package:tdd_app/core/utils/validators.dart';
import 'package:tdd_app/data/models/student_model.dart';
import 'package:tdd_app/data/repositories/student_repository.dart';
import 'package:tdd_app/logic/bloc/student_bloc.dart';
import 'package:tdd_app/presentation/widgets/custom_text_field.dart';

class StudentAddScreen extends StatelessWidget {
  StudentAddScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _batchCtrl = TextEditingController();
  final _weekCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Student')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  key: Key('nameField'),
                  controller: _nameCtrl,
                  hint: 'Name',
                  label: 'Student Name',
                  validator: (value) => validateName(value),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  key: Key('batchField'),
                  controller: _batchCtrl,
                  hint: 'Batch',
                  label: 'Student Batch',
                  validator: (value) => validateBatch(value),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  key: Key('weekField'),
                  controller: _weekCtrl,
                  hint: 'Week',
                  label: 'Student Week',
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) => validateWeek(value),
                ),
                SizedBox(height: 20),

                BlocConsumer<StudentBloc, StudentState>(
                  listener: (context, state) {
                    if (state is AddingSuccess) Navigator.pop(context);
                  },
                  builder: (context, state) {
                    if (state is StudentLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      key: Key('saveBTN'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 41, 183, 45),
                      ),
                      onPressed: () {
                        if (validateForm(_formKey)) {
                          final student = createStudent(
                            name: _nameCtrl.text,
                            batch: _batchCtrl.text,
                            week: _weekCtrl.text,
                          );

                          context.read<StudentBloc>().add(AddStudent(student));
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
