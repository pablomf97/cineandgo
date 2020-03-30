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

const Map<String, List<String>> kComunidades = {
  'A Coruña': [
    'A Coruña',
    'Carballo',
    'Cee',
    'Ferrol',
    'Narón',
    'Ribeira',
    'Santiago de Compostela'
  ],
  'Albacete': ['Albacete', 'Almansa', 'Villarobledo'],
  'Alicante': [
    'Alcoy',
    'Alicante',
    'Benidorm',
    'Cocentaina',
    'Dénia',
    'Elche',
    'Finestrat',
    'Jávea',
    'Alfas del Pi',
    'Mutxamel',
    'Ondara',
    'Orihuela',
    'Preter',
    'San Juan de Alicante',
    'San Vicente del Raspeig',
    'Santa Pola',
    'Torre de la Horadada',
    'Torrevieja',
    'Villajoyosa'
  ],
  'Almería': [
    'Aguadulce',
    'Albox',
    'Almería',
    'El Ejido',
    'Roquetas De Mar',
    'Vélez-Rubio'
  ],
  'Álava': ['Amurrio', 'Etxabarri-Ibiña', 'Llodio', 'Vitoria-Gasteiz'],
  'Asturias': [
    'Avilés',
    'Gijón',
    'Mieres',
    'Oviedo',
    'San Martín del Rey Aurelio',
    'Siero-Oviedo'
  ],
  'Ávila': ['Arenas de San Pedro', 'Ávila'],
  'Badajoz': ['Almendralejo', 'Badajoz', 'Don Benito', 'Mérida', 'Zafra'],
  'Barcelona': ['Barcelona'],
  'Bizakaia.': ['Bilbao'],
  'Burgos': ['Aranda de Duero', 'Burgos', 'Miranda de Ebro'],
  'Cáceres': [
    'Arroyo de la Luz',
    'Cáceres',
    'Coria',
    'Plasencia',
    'Valencia de Alcántara'
  ],
  'Cádiz': [
    'Algeciras',
    'Arcos de la Frontera',
    'Cádiz',
    'Chiclana',
    'Chipiona',
    'El Puerto de Santa María',
    'Jerez De La Frontera',
    'Los Barrios',
    'Rota',
    'San Fernando',
    'Sanlúcar de Barrameda'
  ],
  'Cantabria': [
    'Maliaño',
    'El Astillero',
    'Laredo',
    'Los Corrales de Buelna',
    'Reinosa',
    'Santander',
    'Santoña',
    'Solares',
    'Torrelavega'
  ],
  'Castellón': [
    'Benicarló',
    'Castellón',
    'La Vall d\'Uixó',
    'Villarreal',
    'Vinaròs'
  ],
  'Ceuta': ['Ceuta'],
  'Ciudad Real': [
    'Alcázar De San Juan',
    'Ciudad Real',
    'Daimiel',
    'Pedro Muñoz',
    'Puertollano',
    'Tomelloso',
    'Valdepeñas'
  ],
  'Córdoba': [
    'Cabra',
    'Córdoba',
    'Lucena',
    'Peñarroya-Pueblonuevo',
    'Puente Genil'
  ],
  'Cuenca': ['Cuenca', 'Mota del Cuervo'],
  'Gipuzkoa': ['Donostia-San Sebastián'],
  'Girona': ['Girona'],
  'Granada': [
    'Armilla',
    'Baza',
    'Granada',
    'Huétor Tájar',
    'La Zubia',
    'Loja',
    'Motril',
    'Pulianas'
  ],
  'Guadalajara': ['Guadalajara'],
  'Huelva': [
    'Ayamonte',
    'Huelva',
    'Isla Cristina',
    'La Palma del Condado',
    'Lepe',
    'Punta Umbría'
  ],
  'Huesca': [
    'Barbastro',
    'Boltaña',
    'Graus',
    'Huesca',
    'Monzón',
    'Sabiñánigo',
    'Sariñena',
    'Tamarite de Litera',
    'Zaidín-Saidí'
  ],
  'Islas Baleares': [
    'Ciutadella De Menorca',
    'Formentera',
    'Ibiza',
    'Mahón',
    'Manacor',
    'Palma',
    'Palma de Mallorca',
    'Sant Antoni de Portmany'
  ],
  'Jaén': ['Andújar', 'Jaén', 'La Carolina', 'Linares', 'Úbeda'],
  'La Rioja': ['Alfaro', 'Calahorra', 'Logroño'],
  'Las Palmas': [
    'Antigua',
    'Lanzarote',
    'Fuerteventura',
    'Las Palmas de Gran Canaria',
    'Puerto del Rosario',
    'San Bartolomé',
    'Santa Lucía De Tirajana',
    'Telde'
  ],
  'León': [
    'Astorga',
    'Cistierna',
    'La Bañeza',
    'León',
    'Ponferrada',
    'Santa María del Páramo',
    'Villablino'
  ],
  'Lleida': [
    'Agramunt',
    'Almacelles',
    'Alpicat',
    'Balaguer',
    'Bellpuig',
    'Lleida',
    'Mollerussa',
    'Solsona',
    'Tàrrega',
    'Tremp',
    'Vielha'
  ],
  'Lugo': ['Lugo', 'Monforte de Lemos', 'Ribadeo', 'Viveiro'],
  'Madrid': ['Madrid'],
  'Málaga': [
    'Antequera',
    'Benalmádena',
    'Coín',
    'Estepona',
    'Fuengirola',
    'Málaga',
    'Marbella',
    'Rincón De La Victoria',
    'Ronda',
    'Vélez-Málaga'
  ],
  'Melilla': ['Melilla'],
  'Murcia': [
    'Aguilas',
    'Alhama de Murcia',
    'Cartagena',
    'Lorca',
    'Los Alcázares',
    'Murcia',
    'San Javier',
    'San Pedro del Pinatar',
    'Yecla'
  ],
  'Navarra': ['Estella', 'Huarte', 'Pamplona', 'Tudela', 'Viana'],
  'Ourense': ['Leiro', 'Ourense', 'Xinzo de Limia'],
  'Palencia': ['Palencia'],
  'Pontevedra': [
    'Caldas de Reis',
    'Nigrán-Ramallosa',
    'Pontevedra',
    'Seixo-Marín',
    'Vigo',
    'Vilagarcía de Arousa'
  ],
  'Salamanca': [
    'Béjar',
    'Ciudad Rodrigo',
    'Peñaranda De Bracamonte',
    'Salamanca'
  ],
  'Santa Cruz de Tenerife': [
    'Adeje',
    'Arona',
    'Candelaria',
    'Orotava',
    'San Cristóbal De La Laguna',
    'Santa Cruz de la Palma',
    'Santa Cruz De Tenerife'
  ],
  'Segovia': ['Cuéllar', 'Segovia'],
  'Sevilla': [
    'Alcalá De Guadaira',
    'Aljarafe',
    'Bormujos',
    'Camas',
    'Dos Hermanas',
    'Écija',
    'Las Cabezas de San Juan',
    'Mairena del Aljarafe',
    'Marchena',
    'Sevilla',
    'Tomares'
  ],
  'Soria': ['Almazán', 'El Burgo de Osma', 'Soria'],
  'Tarragona': [
    'Amposta',
    'Calafell',
    'Cambrils',
    'El Vendrell',
    'Montblanc',
    'Reus',
    'Roquetes',
    'Tarragona',
    'Valls',
    'Vila-Seca'
  ],
  'Teruel': ['Alcañiz', 'Alcorisa', 'Teruel'],
  'Toledo': [
    'Olías Del Rey',
    'Quintanar de la Orden',
    'Sonseca',
    'Talavera de la Reina',
    'Toledo',
    'Torrijos',
    'Villacañas'
  ],
  'Valencia': ['Valencia'],
  'Valladolid': [
    'Arroyo de la Encomienda',
    'Medina del Campo',
    'Pedrajas de San Esteban',
    'Valladolid',
    'Zaratán'
  ],
  'Zamora': ['Benavente', 'Zamora'],
  'Zaragoza': [
    'Borja',
    'Calatayud',
    'Caspe',
    'Ejea de los Caballeros',
    'Mequinenza',
    'Tarazona',
    'Zaragoza'
  ],
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
