import 'package:cineandgo/components/custom_drawer.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/screens/movie_details.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cineandgo/components/custom_card.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Firebase stuff
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  // User info
  String photoUrl;
  String name;
  String email;

  // Movie info
  List<CustomCard> movies = [];

  // This method gets the user
  // that is currently logged in
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedUser = user;
        getUserInfo();
      }
    } catch (oops) {
      print(oops);
    }
  }

  void getUserInfo() {
    setState(() {
      photoUrl = loggedUser.photoUrl;
      name = loggedUser.displayName;
      email = loggedUser.email;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMovieData();
  }

  void getMovieData() async {
    var movieData = await TMDBModel.getNowPlaying('es');
    // Localizations.localeOf(context).languageCode

    if (movieData != null) {
      List<CustomCard> aux = [];
      for (var movie in movieData['results']) {
        aux.add(
          CustomCard(
            title: movie['title'],
            posterPath: movie['poster_path'],
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return MovieDetails(
                  movieId: movie['id'].toString(),
                  title: movie['title'],
                );
              }));
            },
          ),
        );
      }
      setState(() {
        movies = aux;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(
          photoUrl: photoUrl,
          name: name,
          email: email,
          auth: _auth,
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Cine&Go!'),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).translate('now_playing'),
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: movies,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 8.0,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context).translate('rooms'),
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: movies,
              ),
            ),
          ],
        ));
  }
}
