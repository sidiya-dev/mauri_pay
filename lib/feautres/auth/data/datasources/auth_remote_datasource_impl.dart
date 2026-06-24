import 'package:dio/dio.dart';
import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/data/models/user_model.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({required this.dio});

  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      final response = await dio.post(
        '/api/v1/auth/register',
        data: {
          'phone': params.phone,
          'fullName': params.fullName,
          'password': params.password,
        },
      );
      return _mapUser(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        '/api/v1/auth/login',
        data: {'phone': params.phone, 'password': params.password},
      );
      return _mapUser(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      final response = await dio.get('/api/v1/me');
      return _mapUser(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _toException(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/api/v1/auth/logout');
    } on DioException {
      // Logging out is best-effort; clearing local state is what matters to the user.
    }
  }

  /// Maps the backend user payload ({id, phone, fullName, balance, currency})
  /// onto the app's UserModel, splitting fullName into first/last name.
  UserModel _mapUser(Map<String, dynamic> json) {
    final fullName = (json['fullName'] as String?)?.trim() ?? '';
    final parts = fullName.isEmpty ? <String>[] : fullName.split(RegExp(r'\s+'));
    final firstName = parts.isNotEmpty ? parts.first : '-';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '-';

    return UserModel(
      userId: json['id']?.toString() ?? '',
      nni: '',
      firstName: firstName,
      lastName: lastName,
      phone: json['phone']?.toString() ?? '',
      password: '',
      role: json['role']?.toString() ?? 'USER',
    );
  }

  /// Builds a ServerException carrying both the backend message and its error code
  /// (so the UI can show a translated message keyed by the code).
  ServerException _toException(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final code = data['code']?.toString();
      final m = data['message'];
      final message = m is Map ? m.values.join(', ') : (m?.toString() ?? 'Error');
      return ServerException(message, code);
    }
    return ServerException(e.message ?? 'Network error', 'NETWORK');
  }
}
