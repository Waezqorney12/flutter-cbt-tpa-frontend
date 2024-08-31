import 'package:dio/dio.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/utils/log.dart';

void errorHandling(dynamic e){
  if(e is DioException){
    Log.loggerFatal('Dio Exception: $e');
  }else{
    Log.loggerFatal('Server Exception: $e');
  }
  throw ServerException(message: '${e.runtimeType} Exception: $e');
}