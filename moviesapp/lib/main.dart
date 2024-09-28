import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: 'Demo',
      home: MovieApp(),
    );
  }
}

class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  List<Movie> movies = [];

  Future<void> fetchMovies() async {
    final url =
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc';
    final res = await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMTNjMDNiOTQxOTA3Nzk2ZWIxYzZlYWVmYjc4NjBjYiIsIm5iZiI6MTcyNzM2MDM2MC42MjQwNTEsInN1YiI6IjY2ZjU2YWYyNWU0MGI1MTJlZmVkNTMxMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YCbOmCu7Kt_1QJZxjTGDdz4DdnuQe64aCQRxBHDYgmk',
      'accept': 'application/json'
    });
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['results'];
      setState(() {
        movies = List<Movie>.from(
          data.map((i) => Movie.fromJson(i)),
        );
      });
    } else {
      print('Failed to fetch the data ${res.statusCode} ${res.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  fetchMovies();
                },
                child: Text('Fetch movies'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Card(
                    color: Color.fromARGB(255, 35, 103, 37),
                    margin: const EdgeInsets.all(20.0),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Release Date: ${movie.releaseDate}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 209, 209, 209)),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            movie.overview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class Movie {
  final String title;
  final String releaseDate;
  final String overview;

  Movie(
      {required this.title, required this.releaseDate, required this.overview});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['original_title'] ?? 'No Title',
      releaseDate: json['release_date'] ?? 'No Release Date',
      overview: json['overview'] ?? 'No Overview',
    );
  }
}
