import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.imageUrl});

  final String imageUrl;
  final double radiusSize = 48;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 8),
      child: Container(
        width: radiusSize,
        height: radiusSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: radiusSize,
          height: radiusSize,
          fadeInDuration: const Duration(milliseconds: 300),
          imageBuilder:
              (context, imageProvider) => Container(
                width: radiusSize,
                height: radiusSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          placeholder:
              (context, url) => Container(
                width: radiusSize,
                height: radiusSize,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

          errorWidget:
              (context, url, error) => Container(
                width: radiusSize,
                height: radiusSize,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey[400],
                  size: 24,
                ),
              ),
        ),
      ),
    );
  }
}
