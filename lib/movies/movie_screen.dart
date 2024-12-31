// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:movie_app/movies/trailer_screen.dart';

class MovieScreen extends StatefulWidget {
  MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<Movie> trendingMovies = [];

  @override
  void initState() {
    loadTrendingMovie();
    super.initState();
  }

  Future<void> loadTrendingMovie() async {
    EasyLoading.show();
    final dio = Dio();
    dio.options.headers = {
      "Authorization":
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NjRkODg1NGI1MWZiYTI0MjVhNTAzMjdmMmEyMWIzMiIsIm5iZiI6MTcyMzgwODU3OS4wMzU0NDMsInN1YiI6IjY2YmFiZWVkOGNmMGY1MjBjZGE5MzVmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kuBDT2fvr3tk1t3G0p0M1hy14Suj2knUYWyBX03SbFc'
    };
    final response =
        await dio.get("$API_BASE_URL/trending/movie/day?language=en-US");
    MovieList movieList = MovieList.fromJson(response.data);
    setState(() {
      trendingMovies = movieList.results;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _IntroCard(),
            _headerMovieDisplay(),
            _bodyMovieCard(),
          ],
        ),
      ),
    );
  }

  Stack _IntroCard() {
    return Stack(
      children: [
        Image.network(
          "https://media.themoviedb.org/t/p/w300_and_h450_bestv2/sDbpr5VoxlcQvzvWFECr7bXCAwg.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: 400,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(1.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  side: const BorderSide(color: Colors.black),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Play"),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  side: const BorderSide(color: Colors.black),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Download"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _bodyMovieCard() {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: ListView.builder(
        itemCount: trendingMovies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TrailerScreen(
                        title: trendingMovies[index].title,
                        posterPath:
                            "$IMAGE_BASE_URL${trendingMovies[index].posterPath}",
                        overview: trendingMovies[index].overview,
                      )));
            },
            child: _movieCard(
              trendingMovies[index].title,
              "$IMAGE_BASE_URL${trendingMovies[index].posterPath}",
            ),
          );
        },
      ),
    );
  }

  Padding _headerMovieDisplay() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Trending movies",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _movieCard(String title, String posterPath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: posterPath,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
