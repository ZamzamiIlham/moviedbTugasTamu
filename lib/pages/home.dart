import 'package:flutter/material.dart';
import 'package:moviedb/data/api.dart';
import 'package:moviedb/pages/detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> _popularMoviesFuture;

  @override
  void initState() {
    super.initState();
    _popularMoviesFuture = apiMovieDb.apiPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: _popularMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                  },
                  child: Container(
                    child: Card(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.star, size: 12),
                                        SizedBox(width: 5),
                                        Text('Rating: ${movie.rating}'),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      movie.description,
                                      maxLines: 2, // Batasi maksimal 2 baris
                                      overflow: TextOverflow
                                          .ellipsis, // Tampilkan ellipsis jika terpotong
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch movies'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
