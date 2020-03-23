import 'package:flutter/material.dart';

// TMDB genre ids
const kGenresEN = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Science Fiction',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western',
  10759: 'Action & Adventure',
  10762: 'Kids',
  10763: 'News',
  10764: 'Reality',
  10765: 'Sci-Fi & Fantasy',
  10766: 'Soap',
  10767: 'Talk,',
  10768: 'War & Politics',
};
const kGenresES = {
  28: 'Acción',
  12: 'Aventura',
  16: 'Animación',
  35: 'Comedia',
  80: 'Crimen',
  99: 'Documentario',
  18: 'Drama',
  10751: 'Familia',
  14: 'Fantasía',
  36: 'Historia',
  27: 'Terror',
  10402: 'Música',
  9648: 'Mysterio',
  10749: 'Romance',
  878: 'Ciencia Ficción',
  10770: 'Película de TV',
  53: 'Suspense',
  10752: 'Bélica',
  37: 'Western',
  10759: 'Acción & Aventura',
  10762: 'Niños',
  10763: 'Noticias',
  10764: 'Reality',
  10765: 'Ciencia Ficción & Fantasía',
  10766: 'Telenovela',
  10767: 'Charla',
  10768: 'Bélica & Política',
};

// TMDB poster path
const kPosterPathOriginal = 'https://image.tmdb.org/t/p/original';
const kPosterPath500 = 'https://image.tmdb.org/t/p/w500';

//   Colors:
//      Defining colors for the theme,
//      following the material design
//      standards.
// Primary color --> DeepOrange
const Color kPrimaryColor = Color(0xFFFF5722);
// Dark primary color --> Darker version of DeepOrange
const kDarkPrimaryColor = Color(0xFFE64A19);
// Light primary color --> Lighter version of DeepOrange
const kLightPrimaryColor = Color(0xFFFFCCBC);
// Accent color --> Orange
const kAccentColor = Color(0xFFFF9800);
// Text&Icons color --> White
const kTextAndIconsColor = Color(0xFFFFFFFF);
// Primary text color --> Lighter black
const kPrimaryTextColor = Color(0xFF212121);
// Secondary text color --> Gray
const kSecondaryTextColor = Color(0xFF757575);
// Divider color --> Lighter gray
const kDividerColor = Color(0xFFBDBDBD);

// TextField decoration
const kTextFieldDecoration = InputDecoration(
  hintText: 'Introduce un valor',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
