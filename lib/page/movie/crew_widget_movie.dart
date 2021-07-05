import 'package:flutter/material.dart';
import 'package:flutter_movie_db/model/credits.dart';
import 'package:flutter_movie_db/page/movie/detail_image_widget.dart';
import 'package:flutter_movie_db/service/movie_service.dart';
import 'package:flutter_movie_db/utils/constants.dart';

class CrewWidgetMovie extends StatelessWidget {
  final int movieId;

  CrewWidgetMovie(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieDB.getInstance().getMovieCredits(movieId),
      builder: (BuildContext context, AsyncSnapshot<Credits> snapshot) {
        if (!snapshot.hasData) {
          // return LoadingIndicatorWidget();
          return Container();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var list = snapshot.data.cast;

        Function(int) callback = (index) {
          var crew = list[index];
          var heroTag = crew.id.toString();
          var crewImageUrl = "$IMAGE_URL_500${crew.profile_path}";
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (BuildContext context) {
          //   return CrewDetailPage(crew.id, crew.name, crewImageUrl, heroTag);
          // }));
        };

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return DetailImageWidget(
                  "$IMAGE_URL_500${list[index].profile_path}",
                  list[index].name,
                  index,
                  heroTag: list[index].id.toString(),
                  callback: callback);
            });
      },
    );
  }
}
