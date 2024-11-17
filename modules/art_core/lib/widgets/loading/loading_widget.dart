import 'package:art_core/art_core.dart';
import 'package:flutter/cupertino.dart';


class AppLoader extends StatelessWidget {
  final Color? color;

  const AppLoader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color ?? Colors.grey,
      radius: 20,
    );
  }
}
