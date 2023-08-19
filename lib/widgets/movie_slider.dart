import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';


class MovieSlider extends StatefulWidget 
{
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({super.key, required this.movies, this.title,required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    //lo que primera vez carga el widget

    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500)
      {
        //laMAR provider

        //print('obtener siguiente pagina');
        widget.onNextPage();

      }
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);
     });
    super.initState();
  }


  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      width: double.infinity,
      height: 260,
      child: Column
      (
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  
        [
           Padding
          (
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.title!,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          ),

          const SizedBox(height: 10,),

          Expanded
          (
            child: ListView.builder
            (
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_,int index) => _MoviePoster(widget.movies[index],'${widget.title}-{index}-${widget.movies[index].id}')
              

            ),

          ),
        ]
      ),

    );
  }
}

class _MoviePoster extends StatelessWidget 
{
  final Movie movie;
  final String heroId;
  const _MoviePoster(this.movie,this.heroId);

  @override
  Widget build(BuildContext context) 
  {
     movie.heroId = heroId;
    return Container
    (
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column
      (
        children:  
        [
          GestureDetector
          (
            onTap: ()=> Navigator.pushNamed(context,'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect
              (
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage
                (
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                            
                ),
            
              ),
            ),

          ),

          const SizedBox(height: 5,),

           Text
          (
            movie.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
                      
        ],

      ),
      
    );
    
  }

}