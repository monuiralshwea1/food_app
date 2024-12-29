import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthController(this._authRepository, this._storageService);

  final _isLoading = false.obs;
  final _error = ''.obs;
  final Rxn<UserModel> _user = Rxn<UserModel>();

  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  UserModel? get user => _user.value;
  bool get isAuthenticated => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final userData = await _storageService.getUser();
    if (userData != null) {
      _user.value = userData;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _authRepository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address,
      );

      if (response.status) {
        await _handleSuccessfulAuth(response.data!);
      } else {
        _error.value = response.msg;
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      if (response.status) {
        await _handleSuccessfulAuth(response.data!);
      } else {
        _error.value = response.msg;
      }
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _handleSuccessfulAuth(UserModel user) async {
    _user.value = user;
    await _storageService.saveUser(user);
    Get.offAllNamed('/home');
  }

  Future<void> logout() async {
    await _storageService.clearUser();
    _user.value = null;
    Get.offAllNamed('/login');
  }
}
