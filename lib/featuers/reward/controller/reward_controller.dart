import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiwash_partner/widgets/components/loader.dart';

import '../../../network_manager/repository.dart';
import '../model/get_offers_by_id_model.dart';
import '../model/get_rewarded_customers_model.dart';
import '../model/offer_response_model.dart';

class RewardController extends GetxController{
  RxBool isWashSelected=true.obs;
  final RxBool isVisible = false.obs;
  RxInt isSelected=1.obs;
  Rxn<GetOffersByIdModel> getOffersByIdModel = Rxn();
  Rxn<GetRewardedCustomersModel> getRewardedCustomersModel=Rxn();
  @override
  void onInit() {

 getAllOffers();
 getRewardedCustomersAll();
    super.onInit();
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


  Future<GetRewardedCustomersModel?> getRewardedCustomersAll()async{

    try{
//showLoader();
      getRewardedCustomersModel.value=await Repository().GetRewardedCustomersRepo();
//hideLoader();
      return getRewardedCustomersModel.value;
    }catch (e){
      print("Error fetching Terms And Condition: $e");
      return null;
    }

  }



Future<GetRewardedCustomersModel?> getRewardedCustomersById(int offerId)async{

  try{

    getRewardedCustomersModel.value=await Repository().GetRewardedCustomersByIdRepo(offerId);
    return getRewardedCustomersModel.value;
  }catch (e){
    print("Error fetching Terms And Condition: $e");
    return null;
  }

  }


  RxBool isAscending = true.obs;
  RxString sortByText = "Sort by Expiry".obs;

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
    isAscending.value ? "Ascending order" : "Descending order";

    offerResponseModel.update((val) {
      val?.data?.offers = offers;
    });
  }

  String timeUntilExpiry(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return "No Expiry";
    }

    try {
      DateTime expiry = DateTime.parse(expiryDate);
      DateTime now = DateTime.now();
      Duration difference = expiry.difference(now);

      if (difference.isNegative) {
        return "Expired";
      } else if (difference.inDays > 365) {
        return "${(difference.inDays / 365).floor()} years";
      } else if (difference.inDays > 30) {
        return "${(difference.inDays / 30).floor()} months";
      } else if (difference.inDays > 0) {
        return "${difference.inDays} days";
      } else if (difference.inHours > 0) {
        return "${difference.inHours} hours";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} minutes";
      } else {
        return "${difference.inSeconds} seconds";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

}



