import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class MovieDetails extends StatefulWidget {
  MovieDetails({@required this.movieId});

  final String movieId;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  // Page layout
  Column pageLayout = Column(
    children: <Widget>[],
  );

  @override
  void initState() {
    super.initState();
    // getMovieData();
  }

  void getMovieData() async {
    var movieDetails = await TMDBModel.getMovieDetails('es', widget.movieId);

    if (movieDetails != null) {
      pageLayout = Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cine&Go!'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'MAD MAX: FURY ROAD',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Text(
                        '기생충',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'OpenSans',
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        '9',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 140.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      Text(
                        'Muy buena',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Summary'),
                  onTap: () {
                    slideDialog.showSlideDialog(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Tanto Gi Taek como su familia están sin trabajo. Cuando su hijo mayor, Gi Woo, empieza a recibir clases particulares en casa de Park, las dos familias, que tienen mucho en común pese a pertenecer a dos mundos totalmente distintos, comienzan una interrelación de resultados imprevisibles.',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
