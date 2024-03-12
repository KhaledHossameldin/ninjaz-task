import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

extension NumbersExtension on num {
  Size get _screenSize =>
      MediaQueryData.fromView(PlatformDispatcher.instance.views.first).size;

  double get width => _screenSize.width * toDouble() / 360;

  double get height => _screenSize.height * toDouble() / 800;

  SizedBox get emptyWidth => SizedBox(width: width);

  SizedBox get emptyHeight => SizedBox(height: height);

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());
}

extension StringExtension on String {
  CachedNetworkImage cachedNetworkImage({BoxFit fit = BoxFit.cover}) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: this,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  CachedNetworkImageProvider get cachedProvider =>
      CachedNetworkImageProvider(this);
}
