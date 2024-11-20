import 'package:art_core/art_core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final bool? readOnly;
  final int? maxLines;
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final bool isSelectable;
  final double? borderRadius;
  final BorderRadius? borderRadiusObject;

  final bool darkOrAuth;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  final String? errorText;
  final Color? borderColor;
  final Color? labelColor;

  final bool isPassword;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FontWeight? fontWeight;
  final double? textSize;
  final int? maxLength;

  final VoidCallback? onTap;

  final String? initialText;

  final double contentPaddingVertical;

  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final bool? filled;
  final bool? enableBorder;
  final bool isRequired, visibal;
  final FontWeight? hintFontWeight;

  final double? hintFontSize;
  final double? labelHeight;

  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.labelHeight,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.hint,
    this.label,
    this.textInputType,
    this.hintColor,
    this.suffixIcon,
    this.prefixIcon,
    this.darkOrAuth = false,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.errorText,
    this.initialText,
    this.borderColor,
    this.hintStyle,
    this.isSelectable = false,
    this.controller,
    this.maxLength,
    this.contentPaddingVertical = 25,
    this.fillColor,
    this.filled,
    this.labelColor,
    this.enableBorder = true,
    this.textColor,
    this.isRequired = true,
    this.visibal = true,
    this.textInputAction = TextInputAction.next,
    this.borderRadius,
    this.fontWeight,
    this.textSize,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.hintFontSize,
    this.hintFontWeight,
    this.borderRadiusObject,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      autofocus: false,
      onTap: widget.onTap ?? () {},
      initialValue: widget.initialText,
      enabled: true,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.onChanged,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword == true ? obscureText : false,
      maxLength: widget.maxLength,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
          color: widget.textColor ?? Colors.grey,
          fontWeight: widget.fontWeight ?? FontWeight.w500,
          fontSize: widget.textSize ?? 16,
          height: 1.6,
          fontFamily: 'Montserrat'),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor ,
        // filled: widget.filled,
        border: widget.enableBorder == false
            ? OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ??
                  Colors.grey.withOpacity(0.6)),
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        ),
        disabledBorder: widget.enableBorder == false
            ? OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ??
                  Colors.grey.withOpacity(0.6)),
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        ),
        enabledBorder: widget.enableBorder == false
            ? OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ??
                  Colors.grey.withOpacity(0.6)),
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        ),
        focusedBorder: widget.enableBorder == false
            ? OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.primaryColor),
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.primaryColor),
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        ),
        focusedErrorBorder: widget.enableBorder == false
            ? OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: widget.borderRadiusObject ??
              BorderRadius.circular(widget.borderRadius ?? 4),
        )
            : Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: widget.hint,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: widget.hintColor ?? Colors.grey,
              fontWeight: widget.hintFontWeight ?? FontWeight.w400,
              fontSize: widget.hintFontSize ?? 12,
            ),
        errorText: widget.errorText == null ||
            widget.errorText!.isEmpty ||
            widget.errorText == ''
            ? null
            : widget.errorText,
        errorMaxLines: 3,
        prefixIcon: widget.prefixIcon,

      ),
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
