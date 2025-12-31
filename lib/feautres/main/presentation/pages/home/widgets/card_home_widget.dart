import 'package:flutter/material.dart';
import 'package:mauri_pay/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:mauri_pay/feautres/main/presentation/pages/transfer_page.dart';

class CardhomeWidget extends StatefulWidget {
  final IconData icon;
  final String text;

  final VoidCallback onTap;
  const CardhomeWidget({super.key, required this.icon, required this.text,required this.onTap});

  @override
  State<CardhomeWidget> createState() => _CardhomeWidgetState();
}

class _CardhomeWidgetState extends State<CardhomeWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0,horizontal: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 0.0),
      width: 170,
      height: 100,
      decoration:
       BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        // i can rememeber the syntaxe of :  boxShadow: ,
        border: BoxBorder.all(
          color: const Color.fromARGB(58, 130, 130, 145),
          strokeAlign:BorderSide.strokeAlignCenter,
          style: BorderStyle.solid ),
      ),
      child:Center(  
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Icon(
                  widget.icon,
                  size: 30,fontWeight: FontWeight.bold,
                 ),
                 GestureDetector(
                  onTap:widget.onTap,
                  child: Text(widget.text),
                )
              ],
            )
        ),
      ) ;

  }
}