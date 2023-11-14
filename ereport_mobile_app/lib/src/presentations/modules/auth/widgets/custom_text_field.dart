

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
    required this.backgroundColor,
    required this.isEnabled,
    required this.initialValue,
    required this.maxLines,
    required this.hasUnderline,
    this.textfieldController
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
        initialValue: widget.initialValue,
        enabled: widget.isEnabled,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        minLines: 1,
        maxLines: widget.maxLines,
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
            ) : null
        ),
        obscureText: (widget.isPassword ? true : false) ? hideText : false,
        onChanged: widget.onSubmited,
        controller: widget.textfieldController,
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

  bool get isValidCalorie{
    final value = double.tryParse(this);
    return (value != null);
  }

  bool get isNotNull{
    return this.length!=0;
  }

  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

}