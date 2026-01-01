import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(Locale("en"));

  void changeLocale(String languageCode) {
    emit(Locale(languageCode));
  }
}
