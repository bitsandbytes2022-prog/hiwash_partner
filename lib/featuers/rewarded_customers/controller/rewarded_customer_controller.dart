import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../../reward/model/get_rewarded_customers_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../network_manager/repository.dart';

class RewardedCustomerController extends GetxController {
  RxInt currentPage = 1.obs;
  final int pageSize = 10;
  final RxList<GetRewardedCustomersData> allCustomers = <GetRewardedCustomersData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);
  }

  void fetchInitialCustomers() {
    currentPage.value = 1;
    hasMore.value = true;
    allCustomers.clear();
    fetchCustomers();
  }

  void onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
      if (!isLoading.value && hasMore.value) {
        fetchCustomers();
      }
    }
  }

  Future<void> fetchCustomers() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    Map<String, dynamic> requestBody = {
      "offerId": "0",
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
}

