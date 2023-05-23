import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'e63643e15687fa5dc73db5cd53c1be64';
const Url = 'https://api.themoviedb.org/3';
const popularMoviesUrl = '$Url/movie/popular?api_key=$apiKey';

class apiMovieDb {
  static Future<List<Movie>> apiPopularMovies() async {
    final response = await http.get(Uri.parse(popularMoviesUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Movie> movies = (jsonData['results'] as List)
          .map((data) => Movie.fromJson(data))
          .toList();

      return movies;
    } else {
      throw Exception('error');
    }
  }
}

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final double rating;
  final List<String> cast;
  final String description;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.cast,
    required this.description,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      rating: json['vote_average'].toDouble(),
      cast: List<String>.from(json['cast'] ?? []),
      description: json['overview'],
      releaseDate: json['release_date'],
    );
  }
}
