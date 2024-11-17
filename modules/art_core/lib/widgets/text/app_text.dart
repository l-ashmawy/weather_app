import '../../theme/themes.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final double? height;
  final Color? color;

  final FontWeight? fontWeight;
  final int? maxLines;

  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  final TextOverflow? textOverflow;

  const AppText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.height,
      this.color,
      this.fontWeight,
      this.maxLines,
      this.textAlign,
      this.textDecoration,
      this.fontFamily,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color ?? AppColors.secondaryColor,
          fontWeight: fontWeight ?? FontWeight.w700,
          height: height ?? 1.8,
          fontFamily: fontFamily ?? "Cairo",
          decorationColor: color,
          decoration: textDecoration),
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
