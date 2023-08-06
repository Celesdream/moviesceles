import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget 
{
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {

    //si llegas de forma directa saldria no movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';


    return Scaffold
    (
      body: CustomScrollView
      (
        slivers: 
        [
          _CustomAppBar(),
          SliverList
          (delegate: SliverChildListDelegate
          ([
            const _PosterAndTitle(),
            const _OverView(),
            const _OverView(),
            const _OverView(),
            const _OverView(),
            const _OverView(),
            CastingCards()
          ])
          ,)

        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget 
{
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
        titlePadding: const EdgeInsets.all(0),
        title: 
        Container
        (
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom:10),
          child: const Text('movie-title',
          style: TextStyle(fontSize: 16),),
        ),

        background: 
        const FadeInImage
        (
          placeholder: AssetImage('assets/loading.gif'),
          image:NetworkImage('https://via.placeholder.com/500x300') ,
          fit: BoxFit.cover,
        ),
      ),
    
    );
  }
}

class _PosterAndTitle extends StatelessWidget 
{
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final textTheme = Theme.of(context).textTheme;
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
            child: const FadeInImage(image: NetworkImage('https://via.placeholder.com/200x300'),
            placeholder: AssetImage('assets/no-image.jpg'),
            height: 150,), 
          ),

          SizedBox(width: 20,),
          Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: 
            [
              Text('movie-title',style:textTheme.headlineSmall, overflow: TextOverflow.ellipsis,maxLines: 2,),
              Text('movie.originalTitle',style:textTheme.titleMedium, overflow: TextOverflow.ellipsis,maxLines: 1,),

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
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget 
{
  const _OverView({super.key});
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      padding: EdgeInsetsDirectional.symmetric(horizontal: 30, vertical: 10),
      child: Text("El uso a distancia o Remote Play es una característica que permite que la PlayStation Vita conecte al PlayStation 4 y PlayStation 3 mediante una red Wi-Fi; cuando pasa esto se pueden hacer streaming de juegos de PlayStation 3 y 4 en PlayStation Vita, consiguiendo así jugar como mando principal.",
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}