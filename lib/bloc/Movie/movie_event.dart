import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {}

class FetchMovieEvent extends MovieEvent {
  final String name;
  FetchMovieEvent(this.name);
  @override
  List<Object> get props => [name];
  List<Object> get prop => [];
}
