import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;

  const UserModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
