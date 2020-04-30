import 'dart:ui';
import 'package:cineandgo/components/movies/custom_card.dart';
import 'package:cineandgo/components/rooms/room_info_card.dart';
import 'package:cineandgo/constants/constants.dart';
import 'package:cineandgo/localization/app_localizations.dart';
import 'package:cineandgo/models/room.dart';
import 'package:cineandgo/screens/others/loading_screen.dart';
import 'package:cineandgo/screens/registration_login/welcome.dart';
import 'package:cineandgo/screens/rooms/room_list.dart';
import 'package:cineandgo/services/tmdb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'movies/movie_details.dart';
import 'movies/movie_list.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Firebase stuff
  final Firestore _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  // HTTP Client
  http.Client _client = http.Client();

  // Movie&Rooms info
  List<CustomCard> movies = [];
  List<Widget> rooms = [];

  // Misc
  DateTime now = DateTime.now();

  // This method gets the user
  // that is currently logged in
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedUser = user;
      }
    } catch (oops) {}
  }

  // Used to get movie data
  void getMovieData() async {
    var movieData =
        await TMDBModel.getNowPlaying(window.locale.languageCode, 1, _client);

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

  // Used to get room data
  void getRooms() {
    _db
        .collection('rooms')
        .where(
          'date',
          isGreaterThanOrEqualTo: now.subtract(
            Duration(
              hours: now.hour,
              minutes: now.minute + 1,
              seconds: now.second,
            ),
          ),
        )
        .limit(10)
        .getDocuments()
        .then(
      (docs) {
        if (docs.documents.isNotEmpty) {
          List<RoomInfoCard> aux = [];
          for (DocumentSnapshot doc in docs.documents) {
            Room room = Room.fromJson(doc.data);
            aux.add(
              RoomInfoCard(
                room: room,
                id: doc.documentID,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              ),
            );
          }
          setState(() => rooms = aux);
        } else {
          rooms.add(
            Card(
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('nothing_to_show'),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
    getMovieData();
    getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cine&Go!'),
          centerTitle: true,
          actions: <Widget>[
            /* 
            Button to sign out.
            */
            PopupMenuButton(
              key: Key('popup_logout_button'),
              itemBuilder: (context) => [
                PopupMenuItem(
                  key: Key('logout_button'),
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    title: Text(
                      AppLocalizations.of(context).translate('sign_out'),
                    ),
                    onTap: () async {
                      try {
                        GoogleSignIn googleAuth = GoogleSignIn();

                        if (await googleAuth.isSignedIn()) {
                          GoogleSignIn().signOut();
                          _auth.signOut();
                        } else {
                          _auth.signOut();
                        }

                        Navigator.pushNamedAndRemoveUntil(
                            context, LoadingScreen.id, (route) => false);
                      } catch (error) {}
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TextButtonRow(
                text: AppLocalizations.of(context).translate('now_playing'),
                buttonTitle:
                    AppLocalizations.of(context).translate('show_more'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMovieList(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: movies,
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButtonRow(
                text: AppLocalizations.of(context).translate('rooms'),
                buttonTitle:
                    AppLocalizations.of(context).translate('show_more'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRooms(),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: PageController(
                    viewportFraction: 0.90,
                    initialPage: 1,
                    keepPage: true,
                  ),
                  scrollDirection: Axis.horizontal,
                  children: rooms,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}

class TextButtonRow extends StatelessWidget {
  TextButtonRow({
    @required this.text,
    @required this.buttonTitle,
    @required this.onPressed,
  });

  final String text;
  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 22.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          FlatButton(
            color: kPrimaryColor,
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: TextStyle(
                height: 1.0,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
