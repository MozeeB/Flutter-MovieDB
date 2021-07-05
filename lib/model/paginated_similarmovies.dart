
import 'package:flutter_movie_db/model/paginated_result.dart';

import 'movie.dart';

class PaginatedSimilarMovies extends PaginatedResult{
  List<Movie> results = new List();

  PaginatedSimilarMovies.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<Movie>.from(json['results'].map((movie) => Movie.fromJson(movie)));
    }
  }
}