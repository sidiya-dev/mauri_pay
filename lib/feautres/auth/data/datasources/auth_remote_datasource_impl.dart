import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mauri_pay/feautres/auth/data/models/user_model.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/login_usecase.dart';
import 'package:mauri_pay/feautres/auth/domain/usecases/register_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabase;

  AuthRemoteDatasourceImpl({required this.supabase});

  @override
  Future<UserModel> register(RegisterParams params) async {
    try {
      final person = await supabase
          .from('person')
          .select('person_id, nni, first_name, last_name')
          .eq('nni', params.nni)
          .maybeSingle();

      if (person == null) throw const ServerException("NNI not found");

      final existingUser = await supabase
          .from('app_user')
          .select('user_id')
          .eq('person_id', person['person_id'])
          .maybeSingle();

      if (existingUser != null)
        throw const ServerException("NNI is already registered");

      final response = await supabase.auth.signUp(
        phone: params.phone,
        password: params.password,
      );

      final user = response.user;
      if (user == null) throw const ServerException("Registration failed");

      await supabase.from('app_user').insert({
        'user_id': user.id,
        'person_id': person['person_id'],
        'phone': params.phone,
        'role': 'client',
      });

      return UserModel(
        userId: user.id,
        nni: person['nni'],
        firstName: person['first_name'],
        lastName: person['last_name'],
        phone: user.phone ?? '',
        password: '',
        role: 'client',
      );
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        phone: params.phone,
        password: params.password,
      );

      final user = response.user;
      if (user == null) throw const ServerException("Login failed");

      final result = await supabase
          .from('app_user')
          .select(
            'user_id, role, person:person_id (nni, first_name, last_name)',
          )
          .eq('user_id', user.id)
          .maybeSingle();

      if (result == null) throw const ServerException("User not found");

      final person = result['person'];

      return UserModel(
        userId: user.id,
        nni: person['nni'],
        firstName: person['first_name'],
        lastName: person['last_name'],
        phone: user.phone ?? '',
        password: '',
        role: result['role'],
      );
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
