

import 'package:ereport_mobile_app/src/core/styles/color.dart';
import 'package:ereport_mobile_app/src/core/styles/text_style.dart';
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
    required this.backgroundColor,
    required this.isEnabled,
    required this.initialValue,
    required this.maxLines,
    required this.hasUnderline,
    required this.margin,
    required this.onTap,
    required this.suffixIcon,
    required this.readOnly,
    this.textfieldController,
    this.style
  }) : super(key: key);


  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String) onSubmited;
  late bool isPassword;
  final Icon? icon;
  final Color backgroundColor;
  final bool isEnabled;
  final String? initialValue;
  final int maxLines;
  final bool hasUnderline;
  final TextEditingController? textfieldController;
  final VoidCallback onTap;
  final Icon? suffixIcon;
  final double margin;
  final bool readOnly;
  final TextStyle? style;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.margin), //default value = 8
      child: TextFormField(
        readOnly: widget.readOnly,
        showCursor: true,
        initialValue: widget.initialValue,
        enabled: widget.isEnabled,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        minLines: 1,
        maxLines: widget.maxLines,
        style: (widget.style != null) ? widget.style : TextStyle(color: Colors.black),
        decoration:  InputDecoration(
            // hintText: widget.hintText,
            enabledBorder: widget.hasUnderline ? const UnderlineInputBorder(
              borderSide: BorderSide(color: onPrimaryContainer),
            ) : null,
            focusedBorder: widget.hasUnderline ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ) : null,
            focusedErrorBorder: widget.hasUnderline ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ) : null,
            errorBorder:  widget.hasUnderline ? const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ) : null,
            labelText: widget.hintText,
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
            ) : widget.suffixIcon
        ),
        obscureText: (widget.isPassword ? true : false) ? hideText : false,
        onChanged: widget.onSubmited,
        controller: widget.textfieldController,
        onTap: widget.onTap,
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
    return this.length>=6;
  }

  bool get isValidWeight{
    return (double.parse(this) > 40.0) && (double.parse(this) < 160.0);
  }

  bool get isValidHeight{
    return (double.parse(this) > 130.0) && (double.parse(this) < 230.0);

  }

  bool get isValidCalorie{
    final value = double.tryParse(this);
    return (value != null);
  }

  bool get isValidDuration{
    final value = int.tryParse(this);
    return (value != null || this.length == 0);
  }

  bool get isNotNull{
    return this.length!=0;
  }

  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

}