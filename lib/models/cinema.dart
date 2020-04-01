import 'package:meta/meta.dart';

class Cinema {
  // Attributes
  String id;
  String address;
  String city;
  String place;
  String name;
  double latitude;
  double longitude;
  String website;

  // Constructor
  Cinema(
      {@required this.id,
      @required this.address,
      @required this.city,
      @required this.place,
      @required this.name,
      @required this.latitude,
      @required this.longitude,
      @required this.website});

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'city': city,
        'place': place,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'website': website
      };
}
