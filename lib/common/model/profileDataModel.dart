import 'dart:convert';

class ProfileDataModel {
  String? name;
  String? profilePicUrl;
  String? mobileNumber;
  String? email;
  String? vehicleBrandName;
  String? vehicleModel;
  String? vehicleType;
  String? vehicleRegistrationNumber;
  String? drivingLicenseNumber;
  String? userType;
  DateTime? registeredDateTime;
  String? activeRideRequestID;
  String? driverStatus;
  String? cloudMessagingToken;

  ProfileDataModel({
    this.name,
    this.profilePicUrl,
    this.mobileNumber,
    this.email,
    this.vehicleBrandName,
    this.vehicleModel,
    this.vehicleType,
    this.vehicleRegistrationNumber,
    this.drivingLicenseNumber,
    this.userType,
    this.registeredDateTime,
    this.activeRideRequestID,
    this.driverStatus,
    this.cloudMessagingToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePicUrl': profilePicUrl,
      'mobileNumber': mobileNumber,
      'email': email,
      'vehicleBrandName': vehicleBrandName,
      'vehicleModel': vehicleModel,
      'vehicleType': vehicleType,
      'vehicleRegistrationNumber': vehicleRegistrationNumber,
      'drivingLicenseNumber': drivingLicenseNumber,
      'userType': userType,
      'registeredDateTime': registeredDateTime,
      'activeRideRequestID': activeRideRequestID,
      'driverStatus': driverStatus,
      'cloudMessagingToken': cloudMessagingToken,
    };
  }

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    return ProfileDataModel(
      name: map['name'],
      profilePicUrl: map['profilePicUrl'],
      mobileNumber: map['mobileNumber'],
      email: map['email'],
      vehicleBrandName: map['vehicleBrandName'],
      vehicleModel: map['vehicleModel'],
      vehicleType: map['vehicleType'],
      vehicleRegistrationNumber: map['vehicleRegistrationNumber'],
      drivingLicenseNumber: map['drivingLicenseNumber'],
      userType: map['userType'],
      registeredDateTime: map['registeredDateTime'],
      activeRideRequestID: map['activeRideRequestID'],
      driverStatus: map['driverStatus'],
      cloudMessagingToken: map['cloudMessagingToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileDataModel.fromJson(String source) => ProfileDataModel.fromMap(json.decode(source));

}
