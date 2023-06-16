import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';

class HomeScreen extends StatelessWidget 
{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cartelera"),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined))
        ],

      ),
      body: Column(
        children: [

          CardSwiper()
        ],
      )
    );
  }
}