import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardItems extends StatelessWidget {
  const CardItems({
    super.key,
    this.image,
    this.title,
    this.description,
    this.rate,
    this.price,
    this.category,
  });

  final String? image;
  final String? title;
  final String? description;
  final String? rate;
  final num? price;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.withAlpha(50),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: CachedNetworkImage(
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  imageUrl: image ?? "",
                  placeholder: (context, url) => SizedBox(),
                  errorWidget:
                      (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey[400],
                        ),
                      ),
                ),
              ),
            ),
            Text(
              title ?? '',
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description ?? '',
              maxLines: 3,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${price ?? 0} EGP',
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    const SizedBox(width: 2),
                    Text(
                      rate ?? '0.0',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
