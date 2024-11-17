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

  final int? maxLength;

  final VoidCallback? onTap;

  final String? initialText;

  final double contentPaddingVertical;

  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final bool? filled;
  final bool? enableBorder;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    Key? key,
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
    this.contentPaddingVertical = 15,
    this.fillColor,
    this.filled,
    this.labelColor,
    this.enableBorder = true,
    this.textColor,
    this.isRequired = true,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = true;

  // Define formatters for various input types
  List<TextInputFormatter> _getInputFormatters() {
    List<TextInputFormatter> formatters = [];

    if (widget.textInputType == TextInputType.number ||
        widget.textInputType == TextInputType.phone) {
      // Allow only digits
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    } else if (widget.textInputType == TextInputType.emailAddress) {
      // Custom formatter to allow only valid email characters
      formatters
          .add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')));
    } else if (widget.isPassword) {
      // Allow special characters in password
      formatters.add(FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z0-9@#%^&*()_+\-=\[\]{};:"$|,.<>/?~`!\\]')));
    }

    if (widget.textInputType != TextInputType.emailAddress &&
        !widget.isPassword) {
      formatters.add(FilteringTextInputFormatter.deny(RegExp(
          r'\b(SELECT|INSERT|UPDATE|DELETE|DROP|TRUNCATE|ALTER|EXEC|UNION|OR|AND)\b',
          caseSensitive: false)));
    }

    // Prevent HTML characters (except in password field)
    if (!widget.isPassword) {
      formatters.add(FilteringTextInputFormatter.deny(RegExp(r'[<>\\/]')));
    }

    // Add custom formatters if provided
    if (widget.inputFormatters != null) {
      formatters.addAll(widget.inputFormatters!);
    }

    return formatters;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: false,
      onTap: widget.onTap ?? () {},
      // inputFormatters: widget.inputFormatters,
      inputFormatters: _getInputFormatters(),
      initialValue: widget.initialText,
      enabled: true,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
      },
      onChanged: widget.onChanged,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword == true ? obscureText : false,
      maxLength: widget.maxLength,
      style: TextStyle(
        color: widget.textColor ?? AppColors.secondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.border?.copyWith(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.secondaryColor)),
        disabledBorder: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.disabledBorder?.copyWith(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.secondaryColor)),
        enabledBorder: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.enabledBorder?.copyWith(
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.grey)),
        focusedBorder: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.secondaryColor)),
        focusedErrorBorder: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        errorBorder: widget.enableBorder == false
            ? OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16))
            : Theme.of(context).inputDecorationTheme.errorBorder,
        contentPadding: EdgeInsets.symmetric(
            vertical: widget.contentPaddingVertical, horizontal: 8),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.hintColor ?? AppColors.secondaryColor,
          fontWeight: FontWeight.w100,
          fontSize: 14,
        ),
        labelText: widget.isRequired ? "${widget.label} *" : widget.label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: widget.labelColor ?? AppColors.secondaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        errorText: widget.errorText == null ||
                widget.errorText!.isEmpty ||
                widget.errorText == ''
            ? null
            : widget.errorText,
        errorMaxLines: 3,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
