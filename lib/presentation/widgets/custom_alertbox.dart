import 'package:flutter/material.dart';

class DeleteStudentDialog extends StatelessWidget {
  final String studentName;
  final VoidCallback onConfirm;

  const DeleteStudentDialog({
    super.key,
    required this.studentName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('deleteStudentDialog'),
      title: const Text('Delete Student', key: Key('alertDialogTitle')),
      content: Text('Are you sure you want to delete "$studentName"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();

            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
