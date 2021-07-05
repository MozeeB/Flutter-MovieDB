import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/paginated_search_results.dart';
import 'package:flutter_movie_db/model/search_result.dart';
import 'package:flutter_movie_db/page/movie/detail_image_widget.dart';
import 'package:flutter_movie_db/page/movie/movie_detail.dart';
import 'package:flutter_movie_db/utils/constants.dart';

class SearchMovieWidget extends StatelessWidget {
  PaginatedSearchResults results;

  SearchMovieWidget(this.results);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: results?.results?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var movie = results.results[index];

          var container = Container(
              width: 200,
              child: _buildMovieWidget(context, movie, "searchResult", index));

          return container;
        });
  }

}
_buildMovieWidget(
    BuildContext context, SearchResult movie, String heroKey, int index) {
  var posterUrl = "$IMAGE_URL_500${movie.poster_path}";
  var detailUrl = "$IMAGE_URL_500${movie.backdrop_path}";
  var heroTag = "${movie.id.toString()}$heroKey";

  return DetailImageWidget(
    posterUrl,
    movie.title,
    index,
    callback: (index) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MovieDetailPage(movie.id, movie.title, detailUrl, heroTag);
      }));
    },
    heroTag: heroTag,
  );
}