import 'package:equatable/equatable.dart';

class DimensionsModel extends Equatable {
  const DimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  final num width;
  final num height;
  final num depth;

  @override
  List<Object?> get props => [width, height, depth];

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      depth: json['depth'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }
}
