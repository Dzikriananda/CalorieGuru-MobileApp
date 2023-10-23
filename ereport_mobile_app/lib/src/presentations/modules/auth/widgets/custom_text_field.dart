

import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    required this.isPassword,
    required this.onSubmited,
    required this.icon,
    required this.backgroundColor
  }) : super(key: key);

  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String) onSubmited;
  late bool isPassword;
  final Icon icon;
  final Color backgroundColor;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        decoration:  InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: widget.backgroundColor,
            prefixIcon: widget.icon,
            suffixIcon: widget.isPassword? IconButton(
                icon: Icon(Icons.remove_red_eye_sharp),
                onPressed: (){
                  setState(() {
                    hideText = !hideText;
                  });
                },
            ) : null
        ),
        obscureText: (widget.isPassword? true : false)? hideText: false,
        onChanged: widget.onSubmited,
      ),
    );
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    return this.length>6;
  }

  bool get isValidWeight{
    return (double.parse(this) > 40.0) && (double.parse(this) < 160.0);
  }

  bool get isValidHeight{
    return (double.parse(this) > 130.0) && (double.parse(this) < 230.0);

  }

  bool get isNotNull{
    return this.length!=0;
  }

}