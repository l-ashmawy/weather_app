import 'package:art_core/art_core.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? loading;
  final bool? dark;
  final Color? color;
  final double? width;
  final double? height;

  final Color? textColor;

  final bool? enableBorder;
  final double? horizontalPadding;
  final double? titleFontSize;

  final bool visible;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.dark = false,
    this.color,
    this.textColor,
    this.enableBorder = false,
    this.width,
    this.height,
    this.visible = true,
    this.horizontalPadding,
    this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return visible == false
        ? const SizedBox()
        : loading == true
            ? _loading()
            : _button();
  }

  final double _radius = 8.0;

  final double _margeHorizontal = 15.0;

  BoxDecoration _decoration() {
    if (color != null) {
      return BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: enableBorder == true ? AppColors.secondaryColor : color!));
    } else {
      return BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(_radius),
          border: Border.all(color: AppColors.secondaryColor));
    }
  }

  Widget _loading() {
    return Container(
      alignment: Alignment.center,
      width: width ?? double.maxFinite,
      height: height ?? 58,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? _margeHorizontal),
      decoration: _decoration(),
      child: const Center(
        child: AppLoader(),
      ),
    );
  }

  Widget _button() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: height ?? 58,
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? _margeHorizontal),
        decoration: _decoration(),
        child: AppText(
          text: title,
          fontSize: titleFontSize ?? 14.5,
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
