part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  GetTriviaForConcreteNumber(this.numberString);

  final String numberString;
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
