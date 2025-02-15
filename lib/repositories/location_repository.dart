import '../model/location_model.dart';
import '../../core/network/dio_client.dart';

class LocationRepository {
  final DioClient _dioClient;

  LocationRepository(this._dioClient);

  Future<List<LocationModel>> getLocations() async {
    try {
      final response = await _dioClient.get('/customers/getLocations');

      if (response.data['status'] == true) {
        final List<dynamic> locationsJson = response.data['locations'];
        return locationsJson
            .map((json) => LocationModel.fromJson(json))
            .toList();
      }

      throw Exception(response.data['msg'] ?? 'Failed to load locations');
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }

  Future<void> addLocation({
    required String latitude,
    required String longitude,
    String? additionalDetails,
  }) async {
    try {
      final response = await _dioClient.post(
        '/customers/addLocation',
        data: {
          'latitude': latitude,
          'longitude': longitude,
          'additional_details': additionalDetails,
        },
      );

      if (response.data['status'] == false) {
        throw Exception(response.data['msg']);
      }
    } catch (e) {
      throw Exception('Failed to add location: $e');
    }
  }
}