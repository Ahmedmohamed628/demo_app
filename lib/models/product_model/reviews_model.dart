import 'package:equatable/equatable.dart';

class ReviewsModel extends Equatable {
  const ReviewsModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  final num rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  @override
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      rating: json['rating'] ?? 0.0,
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}
