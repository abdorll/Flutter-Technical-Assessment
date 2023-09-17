// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kooha/utils/color.dart';
import 'package:kooha/widget/spacing.dart';
import 'package:kooha/widget/texts.dart';

class Inputfield extends StatefulWidget {
  Inputfield({
    required this.fieldName,
    required this.onChanged,
    this.isPassword = false,
    this.showVisibility = true,
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.borderColor,
    this.useLabel = false,
    this.validator,
    this.title = "",
    this.suffixIcon,
    this.cachedText,
    this.borderWidth,
    this.inputType = TextInputType.emailAddress,
    Key? key,
  }) : super(key: key);
  Color? fillColor, hintColor, textColor;
  String fieldName, title;
  TextInputType inputType;
  bool isPassword, showVisibility, useLabel;
  Color? borderColor;
  double? borderWidth;
  String? cachedText;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  void Function(String?) onChanged;

  @override
  State<Inputfield> createState() => _InputfieldState();
}

class _InputfieldState extends State<Inputfield> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    setState(() {
      textEditingController.text = widget.cachedText ?? '';
    });

    super.initState();
  }

  bool obscureText = true;
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        textEditingController = textEditingController;
      });
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextOf(widget.title, 14, AppColors.white, FontWeight.w500),
        const YMargin(5),
        TextFormField(
          // autofocus: true,
          onChanged: widget.onChanged,
          cursorWidth: 1.5,
          validator: widget.validator,
          cursorColor: AppColors.secondaryColor,
          keyboardType: widget.inputType,
          controller: textEditingController,
          //keyboardAppearance: ,
          obscureText: widget.isPassword == true ? obscureText : false,
          style: GoogleFonts.mulish(
              color: widget.textColor ?? AppColors.white,
              decoration: TextDecoration.none,
              decorationColor: Colors.transparent),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? AppColors.fadedBlack,
            contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 18),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintText: widget.fieldName,
            hintStyle: GoogleFonts.mulish(
                color: widget.hintColor ?? AppColors.deepGrey,
                fontWeight: FontWeight.w500,
                fontSize: 14),
            suffixIcon:
                (widget.isPassword == true && widget.showVisibility == true)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: TextOf(
                                  obscureText == true ? "Show" : "Hide",
                                  14,
                                  AppColors.secondaryColor,
                                  FontWeight.w500)),
                        ],
                      )
                    : widget.suffixIcon ?? const SizedBox.shrink(),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: 70, maxWidth: 65),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.borderWidth ?? 1,
                    color: widget.borderColor ?? AppColors.primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.borderWidth ?? 1,
                    color: widget.borderColor ?? AppColors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.borderWidth ?? 1,
                    color: widget.borderColor ?? AppColors.secondaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.borderWidth ?? 1,
                    color: widget.borderColor ?? AppColors.white)),
          ),
        ),
      ],
    );
  }
}
