import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(title: Text(imageUrl!),),
        backgroundColor: Colors.black87,
        body:  isUrl == true ? Center(
            child: Hero(
              tag: 'sdfsfs',
              child: CachedNetworkImage(
                imageUrl: this.imageUrl!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
            ),
          ) : Center(
            child: Hero(
              tag: 'sdfdfsf',
              child: Image.file(
                          File(imageUrl!),
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
      
    );
  }
}
