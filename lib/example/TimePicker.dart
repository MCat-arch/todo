import 'package:flutter/material.dart';

class Timepicker extends StatelessWidget {
  const Timepicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: const Icon(Icons.access_time),
        onPressed: () async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (time != null) {
            print('Selected time: ${time.format(context)}');
          }
        },
      ),
    );
  }
}
