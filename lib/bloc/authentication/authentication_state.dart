import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}
