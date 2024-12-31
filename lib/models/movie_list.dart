// ignore_for_file: constant_identifier_names

import 'package:movie_app/models/movie.dart';

const API_BASE_URL = 'https://api.themoviedb.org/3';
const IMAGE_BASE_URL = 'https://media.themoviedb.org/t/p/w300_and_h450_bestv2';

class MovieList {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieList({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      page: json['page'],
      results:
          json['results'].map<Movie>((movie) => Movie.fromJson(movie)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
