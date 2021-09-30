import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviapitask/bloc/Movie/movie_event.dart';
import 'package:moviapitask/bloc/Movie/movie_state.dart';
import 'package:moviapitask/data/Model/movieapi.dart';
import 'package:moviapitask/data/repository/movie_repository.dart';

class DetailBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository repository;

  DetailBloc({
    required this.repository,
  }) : super(MovieInitialState());

  @override
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield MovieLoadingState();
      try {
        MovieApi movieApi = await repository.getMoviedetail(event.name);

        yield MovieLoadedState(movieapi: movieApi);
      } catch (e) {
        yield MovieErrorState(message: e.toString());
      }
    }
  }
}
