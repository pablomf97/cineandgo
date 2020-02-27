class Cinema {
  // Attributes
  String _id;
  String _city;
  String _name;
  double _latitude;
  double _longitude;

  // Constructor
  Cinema(
    this._id,
    this._city,
    this._name,
    this._latitude,
    this._longitude,
  );

  // Getters
  String getId() => _id;
  String getCity() => _city;
  String getName() => _name;
  double getLatitude() => _latitude;
  double getLongitude() => _longitude;

  // Setters -- Will uncomment if necessary
  //  void setId(String value) => _id = value;
  //  void setCity(String value) => _city = value;
  //  void setName(String value) => _name = value;
  //  void setLatitude(double value) => _latitude = value;
  //  void setLongitude(double value) => _longitude = value;
}
