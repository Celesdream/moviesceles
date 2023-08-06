import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class CardSwiper extends StatelessWidget 
{
  final List<Movie> movies;
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) 
  {
    final size = MediaQuery.of(context).size;

    return SizedBox
    (
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.amber,
      child: Swiper
      (
        itemCount: movies.length,
        layout: SwiperLayout.TINDER,
        itemWidth: size.width * 0.6,
        itemHeight: size.width * 0.9,
        itemBuilder: (BuildContext context, int index) 
        {
          final movie = movies[index];
          //print(movie.fullPosterImg);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: 'movie-instance'),
            child: ClipRRect
            (
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage
              (
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
