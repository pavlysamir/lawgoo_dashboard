import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String text;
  final bool isCorrect;

  const Answer({
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [text, isCorrect];
}
