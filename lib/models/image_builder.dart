import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/nav/navigators.dart';
import 'package:chat/widgets/image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String imageUrl;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  const ImageBuilder({
    Key? key,
    this.width,
    this.height,
    this.fit,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.v("imageUrl: $imageUrl");
    return (kIsWeb)
        ? GestureDetector(
          onTap: () {
                context.push(
                    screen: ImageViewer(
                  isUrl: true,
                  isAsset: false,
                  imageUrl: imageUrl,
                ));
              },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                imageUrl,
                width: width,
                height: height,
                fit: fit,
              ),
          ),
        )
        : GestureDetector(
          onTap: () {
                context.push(
                    screen: ImageViewer(
                  isUrl: true,
                  isAsset: false,
                  imageUrl: imageUrl,
                ));
              },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: width,
                height: height,
                fit: fit,
                placeholder: placeholder,
                errorWidget: errorWidget,
              ),
          ),
        );
  }
}
