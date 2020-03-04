import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageView extends StatelessWidget {
  final String src;
  final double width;
  final double height;
  final Function onTap;
  final BoxFit fit;
  final bool heroAnimation;
  final String heroTag;

  ImageView(
    this.src, {
    this.height,
    this.width,
    this.onTap,
    this.fit = BoxFit.cover,
    this.heroAnimation = true,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    if (heroAnimation) {
      return Hero(
        tag: heroTag ?? src,
        child: _buildImage(),
      );
    }
    return _buildImage();
  }

  Widget _buildImage() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        return CachedNetworkImage(
          imageUrl: src,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          placeholder: _buildPlaceHolder,
        );
      }
    } catch (error) {}
    return Image.network(
      src,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, Widget child, ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return _buildPlaceHolder(context, src);
      },
    );
  }

  Widget _buildPlaceHolder(BuildContext context, String url) {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        child: Container(
          color: Colors.black38,
          width: width,
          height: height,
        ),
        baseColor: Colors.black38,
        highlightColor: Colors.black54,
      ),
    );
  }
}
