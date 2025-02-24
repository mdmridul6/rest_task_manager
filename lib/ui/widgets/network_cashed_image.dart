import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCashedImage extends StatelessWidget {
  const NetworkCashedImage({super.key, required this.url, this.width, this.height, this.boxFit});

  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
