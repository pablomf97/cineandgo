class User {
  // Attributes
  String _id;
  String _fullName;
  String _email;
  String _phoneNumber;
  String _userType;

  // Constructor
  User(
    this._id,
    this._fullName,
    this._email,
    this._phoneNumber,
    this._userType,
  );

  // Getters
  String getId() => _id;
  String getFullName() => _fullName;
  String getEmail() => _email;
  String getPhoneNumber() => _phoneNumber;
  String getUserType() => _userType;

  // Setters -- Will uncomment if necessary
  //  void setId(String value) => _id = value;
  //  void setFullName(String value) => _fullName = value;
  //  void setEmail(String value) => _email = value;
  //  void setPhoneNumber(String value) => _phoneNumber = value;
  //  void setUserType(String value) => _userType = value;
}
