import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_driver/env.dart';
import 'package:lady_driver/services/auth_service.dart';

final themeProvider = StateProvider<bool>((ref) {
  return true;
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: kBaseUrl));
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(dioProvider));
});
