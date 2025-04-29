import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../network_manager/repository.dart';
import '../model/get_rewarded_customers_model.dart';

class RewardController extends GetxController{
  RxBool isWashSelected=true.obs;
  RxInt isSelected=1.obs;
@override
  void onInit() {
  getRewardedCustomers();
    super.onInit();
  }

Rxn<GetRewardedCustomersModel> getRewardedCustomersModel=Rxn();



Future<GetRewardedCustomersModel?> getRewardedCustomers()async{
  var offerId = 1;
  try{

    getRewardedCustomersModel.value=await Repository().GetRewardedCustomersRepo(offerId);
    return getRewardedCustomersModel.value;
  }catch (e){
    print("Error fetching Terms And Condition: $e");
    return null;
  }

  }


}



/*

  Future<TermsAndConditionsResponseModel?> getTermsAndConditions() async {
    var entityType = 0;
    try {
      termsAndConditionsResponseModel.value = await Repository()
          .getTermsAndConditions(entityType);
      return termsAndConditionsResponseModel.value;
    } catch (error) {
      print("Error fetching Terms And Condition: $error");
      return null;
    }
  }*/


