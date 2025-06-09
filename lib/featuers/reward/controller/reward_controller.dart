import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiwash_partner/language/String_constant.dart';
import 'package:hiwash_partner/widgets/components/loader.dart';

import '../../../network_manager/repository.dart';
import '../model/get_offer_categories.dart';
import '../model/get_offers_by_id_model.dart';
import '../model/get_rewarded_customers_model.dart';
import '../model/offer_response_model.dart';

class RewardController extends GetxController {
  RxBool isWashSelected = true.obs;
  final RxBool isVisible = false.obs;
  final RxBool isVisibleAllOffer = false.obs;
  RxInt isSelected = 1.obs;
  var isLoadingCustomers = false.obs;
  Rxn<GetOffersByIdModel> getOffersByIdModel = Rxn();
  Rxn<GetOfferCategoriesModel> getOfferCategoriesModel = Rxn();
  var selectedCategoryIndex = 0.obs;

  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxList<GetRewardedCustomersData> allCustomers =
      <GetRewardedCustomersData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final ScrollController scrollController = ScrollController();
  RxBool isAscending = true.obs;
  RxString  sortByText = StringConstant.kSortByExpiry.tr.obs;

  @override
  void onInit() {
    getAllOffers();
    super.onInit();
    scrollController.addListener(onScroll);
  }

  void fetchInitialCustomers() {
    currentPage.value = 1;
    hasMore.value = true;
    allCustomers.clear();
    fetchCustomersById(
      getOffersByIdModel.value?.offerDetailList?.first.id.toString() ?? '',
    );
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300) {
      if (!isLoading.value && hasMore.value) {
        fetchCustomersById(
          getOffersByIdModel.value?.offerDetailList?.first.id.toString() ?? '',
        );
      }
    }
  }

  Future<void> fetchCustomersById(String offerId) async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    Map<String, dynamic> requestBody = {
      "offerId": offerId,
      "pageNo": currentPage.value.toString(),
      "pageSize": pageSize.toString(),
    };

    try {
      final result = await Repository().GetRewardedCustomersRepo(requestBody);

      if (result != null && result.getRewardedCustomersData != null) {
        final newList = result.getRewardedCustomersData!;
        if (newList.isNotEmpty) {
          allCustomers.addAll(newList);
          currentPage.value++;
          if (newList.length < pageSize) {
            hasMore.value = false;
          }
        } else {
          hasMore.value = false;
        }
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print("Error fetching customers: $e");
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Rxn<GetOfferResponseModel> offerResponseModel = Rxn();

  Future<GetOfferResponseModel?> getAllOffers() async {
    try {
      offerResponseModel.value = await Repository().getAllOffer();

      return offerResponseModel.value;
    } catch (error) {
      print("Error fetching Offers Get All: $error");
    }
    return null;
  }

  Future<GetOffersByIdModel?> getOffersById(int id) async {
    try {
      getOffersByIdModel.value = await Repository().getOfferById(id);

      getOffersByIdModel.value;
    } catch (error) {
      print("Error fetching Offers by Di: $error");
    }
    return null;
  }

  Future<GetOfferCategoriesModel?> getOfferCategories() async {
    try {
      getOfferCategoriesModel.value =
          await Repository().getOfferCategoriesRepo();
      return getOfferCategoriesModel.value;
    } catch (error) {
      print("Error fetching Offers Categories: $error");
    }
    return null;
  }



  void toggleSortOrder() {
    if (sortByText.value == "Sort by Expiry") {
      isAscending.value = true;
    } else {
      isAscending.value = !isAscending.value;
    }

    final offers = offerResponseModel.value?.data?.offers ?? [];
    offers.sort((a, b) {
      final aDate = DateTime.tryParse(a.expiryDate ?? "") ?? DateTime.now();
      final bDate = DateTime.tryParse(b.expiryDate ?? "") ?? DateTime.now();
      return isAscending.value
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
    });

    sortByText.value =
        isAscending.value
            ? StringConstant.kAscendingOrder.tr
            : StringConstant.kDescendingOrder.tr;

    offerResponseModel.update((val) {
      val?.data?.offers = offers;
    });
  }

  String timeUntilExpiry(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return StringConstant.kNoExpiry.tr;
    }

    try {
      DateTime expiry = DateTime.parse(expiryDate);
      DateTime now = DateTime.now();
      Duration difference = expiry.difference(now);

      if (difference.isNegative) {
        return StringConstant.kExpired.tr;
      } else if (difference.inDays > 365) {
        return "${(difference.inDays / 365).floor()} ${StringConstant.kYears.tr}";
      } else if (difference.inDays > 30) {
        return "${(difference.inDays / 30).floor()} ${StringConstant.kMonths.tr}";
      } else if (difference.inDays > 0) {
        return "${difference.inDays} ${StringConstant.kDays.tr}";
      } else if (difference.inHours > 0) {
        return "${difference.inHours} ${StringConstant.kHours.tr}";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} ${StringConstant.kMinutes.tr}";
      } else {
        return "${difference.inSeconds} ${StringConstant.kSeconds.tr}";
      }
    } catch (e) {
      return StringConstant.kInvalidDate.tr;
    }
  }
}
