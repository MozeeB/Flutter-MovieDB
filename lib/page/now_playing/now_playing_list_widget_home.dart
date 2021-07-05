import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/movie.dart';
import 'package:flutter_movie_db/page/movie/detail_image_widget.dart';
import 'package:flutter_movie_db/page/movie/movie_detail.dart';
import 'package:flutter_movie_db/service/movie_service.dart';
import 'package:flutter_movie_db/utils/constants.dart';

class NowPlayingWidget extends StatelessWidget {

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

        return NowPlayingListWidget(data, "Now Playing", "now playing");
      },
    );
  }
}

class NowPlayingListWidget extends StatelessWidget {
  final List<Movie> data;
  final String title;
  final String heroKey;

  NowPlayingListWidget(this.data, this.title, this.heroKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var movie = data[index];

                  var posterUrl = "$IMAGE_URL_500${movie.posterPath}";
                  var detailUrl = "$IMAGE_URL_500${movie.backdropPath}";
                  var heroTag = "${movie.id.toString()}$heroKey";

                  return DetailImageWidget(
                    posterUrl,
                    movie.title,
                    index,
                    callback: (index) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return MovieDetailPage(
                                movie.id, movie.title, detailUrl, heroTag);
                          }));
                    },
                    heroTag: heroTag,
                  );
                }),
          ),
        ],
      ),
    );  }
}