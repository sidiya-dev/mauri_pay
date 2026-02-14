import 'package:mauri_pay/core/error/exceptions.dart';
import 'package:mauri_pay/feautres/main/data/datasources/main_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainRemoteDatasourceImpl implements MainRemoteDatasource {
  final SupabaseClient supabase;

  MainRemoteDatasourceImpl({required this.supabase});

  @override
  Future<int> getBalance(String userId) async {
    try {
      final result = await supabase
          .from('account')
          .select('balance')
          .eq('user_id', userId)
          .maybeSingle();

      if (result == null) throw const ServerException('Account not found');

      // balance is numeric in DB, convert to int
      final balance = (result['balance'] as num).toInt();
      return balance;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
