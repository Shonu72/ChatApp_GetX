import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final int? code;
  final String? message;

  const ServerException({
    this.code = 404,
    this.message = 'Could not process your request at the moment.',
  });

  @override
  String toString() {
    print(message);
    return super.toString();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [code, message];
}
