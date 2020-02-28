import 'package:flutter/material.dart';

// TMDB genre ids
const Map<int, String> kGenresEN = {
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
const Map<int, String> kGenresES = {
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
const String kPosterPathOriginal = 'https://image.tmdb.org/t/p/original';
const String kPosterPath500 = 'https://image.tmdb.org/t/p/w500';

//   Colors:
//      Defining colors for the theme,
//      following the material design
//      standards.
// Primary color --> DeepOrange
const Color kPrimaryColor = Color(0xFFFF5722);
// Dark primary color --> Darker version of DeepOrange
const Color kDarkPrimaryColor = Color(0xFFE64A19);
// Light primary color --> Lighter version of DeepOrange
const Color kLightPrimaryColor = Color(0xFFFFCCBC);
// Accent color --> Orange
const Color kAccentColor = Color(0xFFFF9800);
// Text&Icons color --> White
const Color kTextAndIconsColor = Color(0xFFFFFFFF);
// Primary text color --> Lighter black
const Color kPrimaryTextColor = Color(0xFF212121);
// Secondary text color --> Gray
const Color kSecondaryTextColor = Color(0xFF757575);
// Divider color --> Lighter gray
const Color kDividerColor = Color(0xFFBDBDBD);

// Theme data
final ThemeData kThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  primaryColorDark: kDarkPrimaryColor,
  primaryColorLight: kLightPrimaryColor,
  accentColor: kAccentColor,
  dividerColor: kDividerColor,
);
