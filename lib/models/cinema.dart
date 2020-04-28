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
      {this.id,
      this.address,
      this.city,
      this.place,
      this.name,
      this.latitude,
      this.longitude,
      this.website});

  // ToJSON
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

  static Cinema fromJSON(Map<String, dynamic> data) => Cinema(
      id: data['id'],
      address: data['address'],
      city: data['city'],
      place: data['place'],
      name: data['name'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      website: data['website']);
}
