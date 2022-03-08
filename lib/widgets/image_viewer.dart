import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({Key? key, this.isUrl, this.isAsset, this.imageUrl})
      : super(key: key);
  final bool? isAsset;
  final bool? isUrl;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(imageUrl!),
        ),
        backgroundColor: Colors.black87,
        body: isUrl == true
            ? Center(
                child: Hero(
                  tag: 'network_image',
                  child: CachedNetworkImage(
                    imageUrl: this.imageUrl!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : Center(
                child: Hero(
                  tag: 'file_image',
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: PhotoView(
                      imageProvider: FileImage(
                        File(imageUrl!),
                        //  fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
