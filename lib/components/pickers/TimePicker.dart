import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Timepicker extends StatefulWidget {
  final String label;
  final void Function(TimeOfDay) onTimePicked;
  const Timepicker({
    required this.label,
    required this.onTimePicked,
    super.key,
  });

  @override
  State<Timepicker> createState() => _TimepickerState();
}

class _TimepickerState extends State<Timepicker> {
  TimeOfDay? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        suffixIcon: Icon(Icons.access_time, color: Colors.blue),
      ),
      controller: TextEditingController(
        text: _selectedTime != null ? _selectedTime!.format(context) : '',
      ),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) {
          setState(() {
            _selectedTime = picked;
          });
          widget.onTimePicked(picked);
        }
      },
    );
  }
}
