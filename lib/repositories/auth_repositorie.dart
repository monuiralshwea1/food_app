import 'package:foodly_ui/model/profile.dart';

import '../core/storge/storage_service.dart';
import '../model/user_model.dart';
import '../../core/network/dio_client.dart';


class AuthRepository {
  final DioClient _dioClient;
  final StorageService _storageService;

  AuthRepository(this._dioClient, this._storageService);

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    final response = await _dioClient.post('/customers/register', data: {
      'name':name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address
    });

    final user = UserModel.fromJson(response.data['user']);
    await _storageService.saveToken(user.apiToken.toString());
    return user;
  }

  Future<UserModel> login({
    required String phone,
    required String password,
  }) async {
    final response = await _dioClient.post('/customers/login', data: {
      'phone': phone,
      'password': password,
    });

    final user = UserModel.fromJson(response.data['user']);
    await _storageService.saveToken(user.apiToken);
    return user;
  }

  Future<void> logout() async {
    await _storageService.deleteToken();
  }


  Future<Profile> profile() async {
    try {
      final response = await _dioClient.get('/customers/profile');
      if (response.data['status'] == true) {
        return Profile.fromJson(response.data['user']);    response.data['user'];
      }
      throw Exception(response.data['msg'] ?? 'Failed to load meal items');
    } catch (e) {
      throw Exception('Failed to load meal items: $e');
    }
  }



}