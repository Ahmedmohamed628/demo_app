import 'package:equatable/equatable.dart';

class MetaModel extends Equatable {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  const MetaModel({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}
