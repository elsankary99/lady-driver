import 'package:dio/dio.dart';
import 'package:lady_driver/constant/end_points.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

  Future<String> sendOtp(String phone) async {
    final response = await dio.post(EndPoints.sendOtp, data: {'phone': phone});
    final data = response.data as Map<String, dynamic>;
    final message = data['message'] as String;
    return message;
  }
}
