import 'package:flutter/foundation.dart';
import 'dart:convert';

@immutable
class LocationModel {
  final int id;
  final int customerId;
  final String latitude;
  final String longitude;
  final String? location;
  final String? additionalDetails;
  final bool isAvailable;
  final String createdAt;
  final String updatedAt;

  const LocationModel({
    required this.id,
    required this.customerId,
    required this.latitude,
    required this.longitude,
    this.location,
    this.additionalDetails,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });



  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      customerId: json['customer_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      additionalDetails: json['additional_details'],
      isAvailable: json['is_available'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'latitude': latitude,
      'longitude': longitude,
      'additional_details': additionalDetails,
      'is_available': isAvailable
    };
  }
}