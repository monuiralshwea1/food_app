import 'package:get/get.dart';
import '../model/Offer.dart';
import '../repositories/offer_repositorie.dart';


class OfferController extends GetxController {
  final OfferRepository _offerRepository;
  final RxList<Offer> offers = <Offer>[].obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  OfferController(this._offerRepository);

  @override
  void onInit() {
    super.onInit();
    fetchOffer();
  }

  Future<void> fetchOffer() async {
    try {
      isLoading.value = true;
      error.value = '';
      final items = await _offerRepository.getOffers();
      offers.assignAll(items);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }



}
