import 'package:flutter/material.dart';


class RoundedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color ?textColor;
  final VoidCallback? onPressed;
  final int? spaceVal;

  RoundedButtonWidget(
      {
      this.buttonText,
      this.buttonColor,
      this.textColor = Colors.white,
      this.onPressed,
      this.spaceVal});
      

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.deepOrange, Colors.orange]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GestureDetector(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Text(
                  buttonText.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      letterSpacing: 1,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
    );
  }
}
