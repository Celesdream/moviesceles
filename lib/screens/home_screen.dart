import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget 
{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    //ve al arbol de widgets ve a la instancia de movies provider y esa instancia ponla aqui
    //el lioste indica que se redibuje si hay algun cambio en las propiedades 
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    print(moviesProvider.onDisplayMovies);


    return Scaffold
    (
        appBar: AppBar
        (
          title: Text("Peliculas en cartelera"),
          elevation: 0,
          actions: 
          [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView
        (
          child: Column
          (
            children: 
            [
              //tarjetas principales
              CardSwiper(movies:moviesProvider.onDisplayMovies),

              //slider de peliculs
              MovieSlider(movies:moviesProvider.popularMovies, title:'populares!'),

            ],
          ),
        )
    );
  }
}
