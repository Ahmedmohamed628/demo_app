import 'package:flutter/material.dart';

class SearchBarTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  const SearchBarTextField({
    super.key,
    this.onChanged,
    this.onFilterTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // خلفية بيضاء شيك تظهر وسط الـ grey[50] بتاع الشاشة
        borderRadius: BorderRadius.circular(16),
        // حواف دائرية مودرن
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // ظل ناعم وخفيف جداً
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          hintText: 'Search for characters...',
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
          // أيقونة البحث على الشمال
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.black45,
            size: 22,
          ),
          // زرار الفلترة الشيك على اليمين
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: IconButton(
              icon: const Icon(
                Icons.tune_rounded, // شكل أيقونة الفلاتر المودرن
                color: Colors.deepPurple,
                size: 22,
              ),
              onPressed: onFilterTap,
            ),
          ),
          // البوردر في الحالة العادية (رمادي خفيف ناعم)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          // البوردر لما المستخدم يضغط على الـ TextField ويبدأ يكتب
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
