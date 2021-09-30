import 'package:equatable/equatable.dart';
import 'package:moviapitask/data/Model/movieapi.dart';

abstract class MovieState extends Equatable {}

class MovieInitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieNotSearchingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadedState extends MovieState {
  final MovieApi movieapi;

  MovieLoadedState({
    required this.movieapi,
  });

  @override
  List<Object> get props => [movieapi];
}

class MovieErrorState extends MovieState {
  final String? message;

  MovieErrorState({required this.message});

  @override
  List<Object> get props => [message!];
}
