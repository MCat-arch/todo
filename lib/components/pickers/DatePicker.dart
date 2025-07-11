import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final IconData? icon;
  final String? buttonText;

  const DatePickerWidget({
    super.key,
    this.initialDate,
    required this.onDateSelected,
    this.icon = Icons.calendar_today,
    this.buttonText = 'Pilih Tanggal',
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'), // Format kalender Indonesia
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.blueAccent),
      tooltip: buttonText,
      onPressed: () => _selectDate(context),
    );
  }
}