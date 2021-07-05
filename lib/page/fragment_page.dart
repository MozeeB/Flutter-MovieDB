import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/movie.dart';
import 'package:flutter_movie_db/model/paginated_movies.dart';
import 'package:flutter_movie_db/page/movie/detail_image_widget.dart';
import 'package:flutter_movie_db/page/movie/movie_detail.dart';
import 'package:flutter_movie_db/page/now_playing/now_playing_list_widget_home.dart';
import 'package:flutter_movie_db/page/popular/popular_list_widget_home.dart';
import 'package:flutter_movie_db/page/top_rated/top_rated_list_widget_home.dart';
import 'package:flutter_movie_db/page/upcoming/upcoming_list_widget_home.dart';
import 'package:flutter_movie_db/service/movie_service.dart';
import 'package:flutter_movie_db/utils/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          NowPlayingWidget(),
          SizedBox(height: 5.0,),
          TopRatedWidget(),
          SizedBox(height: 5.0,),
          PopulardWidget(),
          SizedBox(height: 5.0,),
          UpcomingMovieWidget(),
        ],
      ),
    );
  }
}




class NowPlaying extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().nowPlayingMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
        }

        var data = snapshot.data;

        return Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),

              ),
              itemCount: data.length,
              itemBuilder: (BuildContext ctx, index) {
                var movie = data[index];

                var posterUrl = "$IMAGE_URL_500${movie.posterPath}";
                var detailUrl = "$IMAGE_URL_500${movie.backdropPath}";
                var heroTag = "${movie.id.toString()}${movie.title}";

                return DetailImageWidget(
                  posterUrl,
                  movie.title,
                  index,
                  callback: (index) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MovieDetailPage(
                              movie.id, movie.title, detailUrl, heroTag);
                        }
                        )
                    );
                  },
                  heroTag: heroTag,
                );
              }),
        );
      },
    );
  }
}

//Create Stars Fragment. This will contains a gridview with our stars
class TopRated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().topRatedMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
        }

        var data = snapshot.data;

        return Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),

              ),
              itemCount: data.length,
              itemBuilder: (BuildContext ctx, index) {
                var movie = data[index];

                var posterUrl = "$IMAGE_URL_500${movie.posterPath}";
                var detailUrl = "$IMAGE_URL_500${movie.backdropPath}";
                var heroTag = "${movie.id.toString()}${movie.title}";

                return DetailImageWidget(
                  posterUrl,
                  movie.title,
                  index,
                  callback: (index) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MovieDetailPage(
                              movie.id, movie.title, detailUrl, heroTag);
                        }
                        )
                    );
                  },
                  heroTag: heroTag,
                );
              }),
        );
      },
    );
  }
}

//Create Galaxies Fragment. This will contains a gridview with our galaxies
class Upcoming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().upcomingMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
        }

        var data = snapshot.data;

        return Container(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.3),

              ),
              itemCount: data.length,
              itemBuilder: (BuildContext ctx, index) {
                var movie = data[index];

                var posterUrl = "$IMAGE_URL_500${movie.posterPath}";
                var detailUrl = "$IMAGE_URL_500${movie.backdropPath}";
                var heroTag = "${movie.id.toString()}${movie.title}";

                return DetailImageWidget(
                  posterUrl,
                  movie.title,
                  index,
                  callback: (index) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MovieDetailPage(
                              movie.id, movie.title, detailUrl, heroTag);
                        }
                        )
                    );
                  },
                  heroTag: heroTag,
                );
              }),
        );
      },
    );
  }
}

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("About"),
      ),
    );
  }
}
