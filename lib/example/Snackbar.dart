import 'package:flutter/material.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            final snackbar = SnackBar(
              content: Text('Snackbar clicked yeayy'),
              action: SnackBarAction(
                label: 'clicked',
                onPressed: () {
                  print('SnackbarClicked');
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          child: Text('ShowSnackbar'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }
}
