import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  final Color buttonColor;
  final String labelText;
  final Color labelColor;
  final Icon leadingIcon;
  final Icon trailingIcon;
  final Function onTap;

  CustomBottomButton({
    this.buttonColor,
    this.labelText,
    this.labelColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ListTile(
        leading: leadingIcon,
        title: Text(labelText, style: TextStyle(color: labelColor)),
        trailing: trailingIcon,
        onTap: onTap,
      ),
    );
  }
}
