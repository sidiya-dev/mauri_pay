import 'package:flutter/material.dart';

class OptionCardWidget extends StatefulWidget {
  final IconData icon;
  final String text;

  final VoidCallback onTap;
  const OptionCardWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  @override
  State<OptionCardWidget> createState() => _OptionCardWidgetState();
}

class _OptionCardWidgetState extends State<OptionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        width: 170,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: BoxBorder.all(
            color: const Color.fromARGB(58, 130, 130, 145),
            strokeAlign: BorderSide.strokeAlignCenter,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(widget.icon, size: 40, fontWeight: FontWeight.bold),
              Text(widget.text, style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
        ),
      ),
    );
  }
}
