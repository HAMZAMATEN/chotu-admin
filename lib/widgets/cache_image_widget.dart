import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImageWidget extends StatefulWidget {
  final String imageUrl;

  const CacheImageWidget({super.key, required this.imageUrl});

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager:
          CacheManager(Config(widget.imageUrl, stalePeriod: Duration(days: 5))),
      key: Key(widget.imageUrl),
      imageUrl: widget.imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
      );
  }
}
