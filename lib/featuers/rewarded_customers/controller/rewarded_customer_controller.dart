import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../../reward/model/get_rewarded_customers_model.dart';

class RewardedCustomerController extends GetxController{


  Rxn<GetRewardedCustomersModel> getRewardedCustomersModel=Rxn();
  @override
  void onInit() {

    getRewardedCustomersAll();
    super.onInit();
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




}