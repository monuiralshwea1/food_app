import 'package:foodly_ui/model/Offer.dart';

import '../../core/network/dio_client.dart';
import '../model/meal.dart';
import '../model/meal_item.dart';

class OfferRepository {
  final DioClient _dioClient;

  OfferRepository(this._dioClient);

  Future<List<Offer>> getOffers() async {
    try {
      final response = await _dioClient.get('/offers/offers');
      if (response.data['status'] == true) {
        final List<dynamic> offersJson = await response.data['all_offers'];
        return offersJson.map((json) => Offer.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception(response.data['msg'] ?? 'Failed to load meal items');
    } catch (e) {
      throw Exception('Failed to load meal items: $e');
    }
  }



  }