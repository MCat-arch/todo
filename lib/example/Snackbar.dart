import 'package:flutter/material.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Snackbar clicked yeayy'),
              action: SnackBarAction(
                label: 'clicked',
                onPressed: () {
                  print('SnackbarClicked');
                },
              ),
            ),
          );
        },
        child: Text('ShowSnackbar'),
      ),
    );
  }
}
