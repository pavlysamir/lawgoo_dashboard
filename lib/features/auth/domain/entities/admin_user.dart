import 'package:equatable/equatable.dart';

class AdminUser extends Equatable {
  final String id;
  final String email;

  const AdminUser({required this.id, required this.email});

  @override
  List<Object?> get props => [id, email];
}
