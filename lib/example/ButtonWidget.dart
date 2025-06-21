import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton with icon - A simple text label button with an icon
            TextButton.icon(
              onPressed: () => print('TextButton with icon clicked'),
              icon: const Icon(Icons.home_filled),
              label: const Text('Home'),
            ),
            const SizedBox(height: 20),

            // ElevatedButton - A filled button with shadow for primary actions
            ElevatedButton(
              onPressed: () => print('ElevatedButton clicked'),
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),

            // OutlinedButton - A button with an outline and transparent background
            OutlinedButton(
              onPressed: () => print('OutlinedButton clicked'),
              child: const Text('Cancel'),
            ),
            const SizedBox(height: 20),

            // IconButton - A clickable icon without text
            IconButton(
              onPressed: () => print('IconButton clicked'),
              icon: const Icon(Icons.settings),
            ),
            const SizedBox(height: 20),

            // FloatingActionButton - A circular button that floats above content
            FloatingActionButton(
              onPressed: () => print('FloatingActionButton clicked'),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),

            // SegmentedButton - A group of related options where one can be selected
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('Option 1')),
                ButtonSegment(value: 2, label: Text('Option 2')),
              ],
              selected: const {1},
              onSelectionChanged: (Set<int> newSelection) {
                print('Selected option: $newSelection');
              },
            ),

            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            FloatingActionButton(onPressed: () {}),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('Option 1')),
                ButtonSegment(value: 2, label: Text('Option 2')),
              ],
              selected: const {1},
              onSelectionChanged: (Set<int> newSelection) {
                print('$newSelection');
              },
            ),
          ],
        ),
      ),
    );
  }
}
