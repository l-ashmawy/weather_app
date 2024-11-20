import 'package:art_core/art_core.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyNetworkImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? boxFit;
  final bool? isCircle;
  final Color? imageColor;
  final Map<String, String>? headers;

  // final bool? useBaseUrl;

  const MyNetworkImage(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.boxFit,
    this.isCircle = false,
    this.headers,
    this.radius = 4,
    this.imageColor,

    // this.useBaseUrl = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyNetworkImageWidget(
      url,
      height: height,
      width: width,
      isCircle: isCircle,
      // useBaseUrl: useBaseUrl,
      boxFit: boxFit,
      headers: headers,
      radius: radius,
    );
  }
}

class MyNetworkImageWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double? radius;

  final bool? isCircle;
  final BoxFit? boxFit;
  final Color? imageColor;
  final Map<String, String>? headers;

  // final bool? useBaseUrl;

  const MyNetworkImageWidget(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.boxFit,
    this.isCircle = false,
    this.headers,
    this.radius = 8,
    this.imageColor,
    // this.useBaseUrl = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      httpHeaders: headers,
      imageBuilder: (context, imageProvider) => Container(
        width: width ?? 100.0,
        height: height ?? 100.0,
        decoration: BoxDecoration(
            shape: isCircle! ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle! ? null : BorderRadius.circular(radius!),
            image: DecorationImage(image: imageProvider, fit: boxFit ?? BoxFit.fill),
            color: imageColor),
      ),
      placeholder: (context, url) => SizedBox(
        height: height ?? 70,
        width: width ?? 70,
        child: const Center(
          child: AppLoader(),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height ?? 70,
        width: width ?? 70,
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
