import 'package:get/get.dart';
import '../model/Offer.dart';
import '../repositories/offer_repositorie.dart';
import '../core/network_cache_service.dart';
import 'dart:async';

class OfferController extends GetxController {
  final OfferRepository _offerRepository;
  final RxList<Offer> offers = <Offer>[].obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final NetworkCacheService _networkCacheService = Get.find<NetworkCacheService>();
  Timer? _updateTimer;
  OfferController(this._offerRepository);

  @override
  void onInit() {
    super.onInit();
    fetchOffer();
    _startAutoUpdate(); // تحديث دوري للبيانات
  }

  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void _startAutoUpdate() {
    _updateTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      fetchOffer();
    });
  }

 Future<void> fetchOffer() async {
  try {
    isLoading.value = true;
    error.value = '';

    // 1. تحميل الكاش أولاً (لعرض بيانات سريعة)
    final cachedData = _networkCacheService.loadFromCache('offers');
      
    if (cachedData != null && cachedData.isNotEmpty) {
    
      offers.assignAll(cachedData.map((e) => Offer.fromJson(e)).toList());
    }

    // 2. دائماً جلب البيانات من السيرفر وتحديث القائمة والكاش
    if (await _networkCacheService.hasInternet()) {
      
      final items = await _offerRepository.getOffers();
      offers.assignAll(items); // <-- تحديث القائمة دائماً
      _networkCacheService.saveToCache('offers', items.map((e) => e.toJson()).toList());
    }

  } catch (e) {
    error.value = e.toString();
  } finally {
    isLoading.value = false;
  }
}



}
