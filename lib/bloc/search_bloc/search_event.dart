import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchMovie extends SearchMovieEvent {
  final String query;

  SearchMovie({required this.query});

  @override
  List<Object?> get props => [query];
}

class ClearSearchMovie extends SearchMovieEvent {}
