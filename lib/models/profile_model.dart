class ProfileModel {
  String? firstName;
  String? lastName;
  String? countryName;
  String? phoneNumber;
  String? wantToBuy;
  String? email;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.countryName,
    required this.phoneNumber,
    this.wantToBuy,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'countryName': countryName,
      'phoneNumber': phoneNumber,
      'wantToBuy': wantToBuy,
      'email': email,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      countryName: json['countryName'],
      phoneNumber: json['phoneNumber'],
      wantToBuy: json['wantToBuy'],
      email: json['email'],
    );
  }
}
