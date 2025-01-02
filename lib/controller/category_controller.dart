import 'package:foodly_ui/model/category.dart';
import 'package:foodly_ui/repositories/category_repositorie.dart';
import 'package:get/get.dart';




class CategoryController extends GetxController {
  final CategoryRepository _categoryRepository;
  final RxList<Category> categorys = <Category>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  CategoryController(this._categoryRepository);

  @override
  void onInit() {
    super.onInit();

    fetchCategorys();

  }

  Future<void> fetchCategorys() async {
    try {

      isLoading.value = true;
      error.value = '';
      final items = await _categoryRepository.getCategorys();
      categorys.assignAll(items);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}