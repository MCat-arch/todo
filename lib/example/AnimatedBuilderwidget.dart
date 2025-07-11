import 'package:flutter/material.dart';

class Animatedbuilderwidget extends StatefulWidget {
  const Animatedbuilderwidget({super.key});

  @override
  State<Animatedbuilderwidget> createState() => _AnimatedbuilderwidgetState();
}

class _AnimatedbuilderwidgetState extends State<Animatedbuilderwidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
        child: Center(child: Text('Hello World')),
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.14,
          child: child,
        );
      },
    );
  }
}
