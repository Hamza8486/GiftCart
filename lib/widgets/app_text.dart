import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AppText extends StatelessWidget {
  const AppText({Key? key,  this.title = "Coupon App",   this.color = Colors.black,this.size,
    this.fontWeight,this.fontFamily,
    this.textAlign, this.letterSpacing, this.maxLines, this.overFlow ,this.fontStyle


  }) : super(key: key);
  final Color color ;
  final TextOverflow ?overFlow;
  final String title;
  final double ?size;
  final FontWeight ?fontWeight;
  final FontStyle ?fontStyle;
  final String ?fontFamily;
  final TextAlign ?textAlign;
  final double?letterSpacing;
  final int?maxLines;


  @override
  Widget build(BuildContext context) {
    return Text(title,

      style: GoogleFonts.poppins(
          textStyle : TextStyle(
            color: color,
            fontSize: size,
            fontStyle:fontStyle ,

            fontWeight: fontWeight,
            letterSpacing: letterSpacing,

          )),
      overflow: overFlow,


      textAlign: textAlign,
      maxLines: maxLines,

    );
  }
}

