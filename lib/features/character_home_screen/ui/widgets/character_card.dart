import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    this.image,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  final String? image;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;

  // 👈 دالة ذكية لتحديد لون مؤشر الحالة
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // 👈 دالة لتحديد أيقونة النوع الاجتماعي
  IconData _getGenderIcon(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      default:
        return Icons.person_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // حواف ناعمة ومودرن
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4), // ظل خفيف لتحت بيدي عمق
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الجزء العلوي: الصورة واخدة العرض كله ومقصوصة بشكل نظيف
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child:
                        (image == null ||
                                image!.trim().isEmpty ||
                                !image!.startsWith('http'))
                            ? Container(
                              color: Colors.grey[100],
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey[400],
                                size: 40,
                              ),
                            )
                            : CachedNetworkImage(
                              imageUrl: image ?? "",
                              fit: BoxFit.cover,
                              // بتملى المربع بشكل شيك جداً
                              fadeInDuration: const Duration(milliseconds: 300),
                              placeholder:
                                  (context, url) => Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.grey[200],
                                  ),

                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey[100],
                                    child: Icon(
                                      Icons.broken_image_outlined,
                                      color: Colors.grey[400],
                                      size: 40,
                                    ),
                                  ),
                            ),
                  ),
                  // type with semi-transparent background for better readability
                  if (type != null && type!.isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          type!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // 2. الجزء السفلي: تفاصيل الشخصية متظبطة بـ Spacing نظيف
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // name
                Text(
                  name ?? 'Unknown',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),

                // status and species in one line with a colored dot indicator for status
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${status ?? 'Unknown'} - ${species ?? 'Unknown'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // gender with icon
                Row(
                  children: [
                    Icon(
                      _getGenderIcon(gender),
                      size: 16,
                      color: Colors.deepPurple[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      gender ?? 'Unknown',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// class CharacterCard extends StatelessWidget {
//   const CharacterCard({
//     super.key,
//     this.image,
//     this.name,
//     this.status,
//     this.species,
//     this.type,
//     this.gender,
//   });
//
//   final String? image;
//   final String? name;
//   final String? status;
//   final String? species;
//   final String? type;
//   final String? gender;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shadowColor: Colors.grey.withAlpha(50),
//       elevation: 3,
//       color: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Center(
//                 child: CachedNetworkImage(
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.contain,
//                   fadeInDuration: const Duration(milliseconds: 300), // 👈 بونص: بيخلي الصورة تظهر بنعومة وميحملش كله كبسة واحدة
//                   imageUrl: image ?? "",
//                   placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2),),
//                   errorWidget:
//                       (context, url, error) => Container(
//                     decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8),),
//                         child: Icon(Icons.broken_image_outlined, color: Colors.grey[400],),
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               name ?? '',
//               maxLines: 2,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               status ?? '',
//               maxLines: 3,
//               style: TextStyle(
//                 color: Colors.black45,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//
//             Text(
//               species ??'',
//               style: const TextStyle(
//                 color: Colors.deepPurple,
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               type ?? '',
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               gender ?? '',
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
