import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/paginated_similarmovies.dart';
import 'package:flutter_movie_db/page/movie/detail_image_widget.dart';
import 'package:flutter_movie_db/page/movie/movie_detail.dart';
import 'package:flutter_movie_db/service/movie_service.dart';
import 'package:flutter_movie_db/utils/constants.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final int movieId;

  SimilarMoviesWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieDB.getInstance().getSimilarMovies(movieId),
      builder: (BuildContext context,
          AsyncSnapshot<PaginatedSimilarMovies> snapshot) {
        if (!snapshot.hasData) {
          // return LoadingIndicatorWidget();
          return Container();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var list = snapshot.data.results;

        Function(int) callback = (index) {
          var movie = list[index];
          var heroTag = movie.id.toString();
          var movieImageUrl = "$IMAGE_URL_500${movie.backdropPath}";
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MovieDetailPage(
                movie.id, movie.title, movieImageUrl, heroTag);
          }));
        };

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var movie = list[index];

              return DetailImageWidget(
                "$IMAGE_URL_500${movie.posterPath}",
                movie.title,
                index,
                callback: callback,
                heroTag: movie.id.toString(),
              );
            });
      },
    );
  }
}
