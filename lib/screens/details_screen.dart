import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget 
{
   DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {

    //si llegas de forma directa saldria no movie
    //lo tratas como una pelicula OJO no convierte
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.posterPath);


    return Scaffold
    (
      body: CustomScrollView
      (
        slivers: 
        [
          _CustomAppBar(movie),
          SliverList
          (delegate: SliverChildListDelegate
          ([
             _PosterAndTitle(movie),
             _OverView(movie),
            CastingCards(movie.id),
          ])
          ,)

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget 
{

  final Movie movie;
  _CustomAppBar( this.movie );


  @override
  Widget build(BuildContext context) 
  {
    return SliverAppBar
    (
      backgroundColor: Colors.amber,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar
      (
        centerTitle: true,
        titlePadding:  EdgeInsets.all(0),
        title: 
        Container
        (
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom:10),
          child:  Text(movie.title,
          style: TextStyle(fontSize: 14),),
        ),

        background: 
         FadeInImage
        (
          placeholder: AssetImage('assets/loading.gif'),
          image:NetworkImage(movie.fullBackdropPath) ,
          fit: BoxFit.cover,
        ),
      ),
    
    );
  }
}

class _PosterAndTitle extends StatelessWidget 
{
    final Movie movie;

  const _PosterAndTitle( this.movie );

  @override
  Widget build(BuildContext context) 
  {
    final textTheme = Theme.of(context).textTheme;
    final size  = MediaQuery.of(context).size;
    return Container
    (
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: 
      Row
      (
        children: 
        [
          ClipRRect
          (
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(image: NetworkImage(movie.fullPosterImg),
            placeholder: AssetImage('assets/no-image.jpg'),
            height: 150,), 
          ),

          SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width -190),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Text(movie.title, style: textTheme.headlineSmall,overflow:TextOverflow.ellipsis,maxLines:3),
          
                Text(movie.originalTitle,style:textTheme.titleMedium, overflow: TextOverflow.ellipsis,maxLines: 3,),
                
          
          
                Row
                (
                  children: 
                  [
                    Icon(Icons.star_border_outlined, size: 15,color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('movie.voteAverage',style: textTheme.bodySmall)
                  ],
                  
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget 
{
  final Movie movie;
  const _OverView( this.movie );

  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}