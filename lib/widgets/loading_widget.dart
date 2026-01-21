import 'package:flutter/material.dart';

/// Reusable beautiful loading widget
Widget beautifulLoading({double size = 60, Color? color}) {
  return Center(
    child: SizedBox(
      width: size,
      height: size,
      child: _BouncingDots(color: color ?? Colors.blueAccent),
    ),
  );
}

/// Private bouncing dots animation
class _BouncingDots extends StatefulWidget {
  final Color color;
  const _BouncingDots({Key? key, required this.color}) : super(key: key);

  @override
  State<_BouncingDots> createState() => _BouncingDotsState();
}

class _BouncingDotsState extends State<_BouncingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();

    _animation1 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );
    _animation2 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: Curves.easeInOut),
      ),
    );
    _animation3 = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Transform.translate(
            offset: Offset(0, _animation1.value),
            child: _dot(widget.color),
          ),
          Transform.translate(
            offset: Offset(0, _animation2.value),
            child: _dot(widget.color),
          ),
          Transform.translate(
            offset: Offset(0, _animation3.value),
            child: _dot(widget.color),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
