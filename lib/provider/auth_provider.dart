import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_driver/provider/auth_provider.dart';
import 'package:lady_driver/provider/provider.dart';
import 'package:lady_driver/services/auth_service.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess({required this.message});
}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService service;
  AuthNotifier(this.service) : super(AuthInitial());

  Future<void> sendOtp({required String phone}) async {
    state = AuthLoading();
    try {
      final message = await service.sendOtp(phone);
      state = AuthSuccess(message: message);
    } on Exception catch (e) {
      state = AuthFailure(error: '$e');
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthNotifier(service);
});
