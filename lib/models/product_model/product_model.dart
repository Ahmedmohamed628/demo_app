import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.thumbnail,
    required this.rating,
    // required this.discountPercentage, required this.stock, required this.tags, required this.brand, required this.sku,
    // required this.weight, required this.warrantyInformation, required this.shippingInformation,
    // required this.availabilityStatus, required this.returnPolicy, required this.minimumOrderQuantity,
    // required this.images, required this.dimensions, required this.meta, required this.reviews
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String category;
  final String thumbnail; //image
  final num rating;

  // todo: newly added for the future details
  // final num discountPercentage;
  // final num stock;
  // final List<String> tags;
  // final String brand;
  // final String sku;
  // final num weight;
  // final String warrantyInformation;
  // final String shippingInformation;
  // final String availabilityStatus;
  // final String returnPolicy;
  // final num minimumOrderQuantity;
  // final List<String> images;
  // final DimensionsModel dimensions;
  // final MetaModel meta;
  // final List<ReviewsModel> reviews;

  @override
  List<Object?> get props => [
    id, title, description, price, category, thumbnail, rating,
    // discountPercentage, stock, tags, brand, sku,
    // weight, warrantyInformation, shippingInformation, availabilityStatus,
    // returnPolicy, minimumOrderQuantity, images, dimensions, meta, reviews
  ];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      rating: json['rating'] ?? 0.0,
      // todo: newly added for the future details
      // discountPercentage: json['discountPercentage'] ?? 0.0,
      //   stock: json['stock'] ?? 0,
      //   tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      //   brand: json['brand'] ?? '',
      //   sku: json['sku'] ?? '',
      //   weight: json['weight'] ?? 0.0,
      //   warrantyInformation: json['warrantyInformation'] ?? '',
      //   shippingInformation: json['shippingInformation'] ?? '',
      //   availabilityStatus: json['availabilityStatus'] ?? '',
      //   returnPolicy: json['returnPolicy'] ?? '',
      //   minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      //   images: json['images'] != null ? List<String>.from(json['images']) : [],
      //   dimensions: DimensionsModel.fromJson(json['dimensions'] ?? {}),
      //   meta: MetaModel.fromJson(json['meta'] ?? {}),
      //   reviews: json['reviews'] != null ?
      //   (json['reviews'] as List).map((reviewJson) => ReviewsModel.fromJson(reviewJson)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'thumbnail': thumbnail,
      'rating': rating,

      // todo: newly added for the future details
      // 'discountPercentage' : discountPercentage,
      // 'stock' : stock,
      // 'tags' : tags,
      // 'brand' : brand,
      // 'sku' : sku,
      // 'weight' : weight,
      // 'warrantyInformation' : warrantyInformation,
      // 'shippingInformation' : shippingInformation,
      // 'availabilityStatus' : availabilityStatus,
      // 'returnPolicy' : returnPolicy,
      // 'minimumOrderQuantity' : minimumOrderQuantity,
      // 'images' : images,
      // 'dimensions' : dimensions.toJson(),
      // 'meta' : meta.toJson(),
      // 'reviews' : reviews.map((review) => review.toJson()).toList(),
    };
  }
}
