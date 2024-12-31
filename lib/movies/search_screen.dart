// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_app/movies/trailer_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a movie or a TV show',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TrailerScreen(
                          title: "The Instigators",
                          posterPath:
                              "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/pIz9csYn1yjrzQi0BuBZNJrTMi0.jpg",
                          overview: "",
                        ),
                      ),
                    );
                  },
                  child: MovieItem("The Instigators",
                      "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/pIz9csYn1yjrzQi0BuBZNJrTMi0.jpg"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TrailerScreen(
                          title: "Alien: Romulus",
                          posterPath:
                              "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg",
                              overview: "",
                        ),
                      ),
                    );
                  },
                  child: MovieItem("Alien: Romulus",
                      "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TrailerScreen(
                          title: "Watchmen: Chapter I",
                          posterPath:
                              "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/tE2vZ6HdlmKaBh0wpsvHCf7HJKo.jpg",
                              overview: "",
                        ),
                      ),
                    );
                  },
                  child: MovieItem("Watchmen: Chapter I",
                      "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/tE2vZ6HdlmKaBh0wpsvHCf7HJKo.jpg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget MovieItem(String title, String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                ),
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.play_circle_outline),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
