import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:number_trivia/core/error/exception.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      _getTriviaFromUrl('http://numbersapi.com/random');

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final triviaUrl = Uri.parse(url);
    final response = await dio.get(
      triviaUrl as String,
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(
        json.decode(response.data) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
