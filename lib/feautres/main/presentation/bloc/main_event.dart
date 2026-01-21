part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class GetBalanceEvent extends MainEvent {}
