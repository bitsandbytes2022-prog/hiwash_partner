import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';
import '../../../widgets/components/loader.dart';
import '../../reward/model/get_rewarded_customers_model.dart';

class RewardedCustomerController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  RxBool isCalenderSelected = false.obs;
  final RxInt currentPage = 1.obs;
  final int pageSize = 10;
  RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  int userRating = 0;
  final TextEditingController commentController = TextEditingController();


  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final RxBool isDateFilterEnabled = false.obs;
  final RxList<GetRewardedCustomersData> allCustomers = <GetRewardedCustomersData>[].obs;

  DateTime focusedDay1 = DateTime.now();
  DateTime? selectedDay1;
  CalendarFormat calendarFormat = CalendarFormat.month;

  Rx<DateTime?> rangeStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> rangeEndDate = Rx<DateTime?>(null);

  DateTime get defaultStartDate => DateTime.now().subtract(Duration(days: 10));
  DateTime get defaultEndDate => DateTime.now();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(onScroll);

    rangeStartDate.value = defaultStartDate;
    rangeEndDate.value = defaultEndDate;

    fetchInitialCustomers();
  }

  void fetchInitialCustomers() {
    currentPage.value = 1;
    hasMore.value = true;
    allCustomers.clear();

    final start = rangeStartDate.value ?? defaultStartDate;
    final end = rangeEndDate.value ?? defaultEndDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCustomers(start.toIso8601String().split("T")[0], end.toIso8601String().split("T")[0]);
    });
  }

  void onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
        !isLoading.value &&
        hasMore.value) {
      final start = rangeStartDate.value ?? defaultStartDate;
      final end = rangeEndDate.value ?? defaultEndDate;
      fetchCustomers(start.toIso8601String().split("T")[0], end.toIso8601String().split("T")[0]);
    }
  }

  Future<void> onRangeSelected(
      DateTime? start,
      DateTime? end,
      DateTime focusedDay,
      ) async {
    rangeStartDate.value = start;
    rangeEndDate.value = end;
    focusedDay1 = focusedDay;
    selectedDay1 = null;

    if (start != null && end != null) {
      currentPage.value = 1;
      hasMore.value = true;
      allCustomers.clear();
      await fetchCustomers(start.toIso8601String().split("T")[0], end.toIso8601String().split("T")[0]);
      isCalenderSelected.value = false;
    }

    update();
  }

  Future<void> fetchCustomers(String? startingDate, String? endingDate) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final requestBody = {
        "offerId": "0",
        "pageNo": currentPage.value.toString(),
        "pageSize": pageSize.toString(),
        "startDate": startingDate,
        "endDate": endingDate,
      };

      if (isDateFilterEnabled.value && selectedDate.value != null) {
        requestBody["redeemedDate"] = selectedDate.value!.toIso8601String().split("T")[0];
      }

      final result = await Repository().GetRewardedCustomersRepo(requestBody);

      if (result != null && result.getRewardedCustomersData != null) {
        final newList = result.getRewardedCustomersData!;
        if (newList.isNotEmpty) {
          allCustomers.addAll(newList);
          currentPage.value++;
          hasMore.value = newList.length == pageSize;
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

  void setSelectedDate(DateTime date) {

    selectedDate.value = date;
    isDateFilterEnabled.value = true;
    searchController.text = formatDateForTextField(date);
    fetchInitialCustomers();
  }

  void clearDateFilter() {
    rangeStartDate.value=null;
    rangeEndDate.value=null;
    selectedDate.value = null;
    isDateFilterEnabled.value = false;
    searchController.text = '';
    fetchInitialCustomers();
  }

  void refreshSelectedDateData() {
    isDateFilterEnabled.value = false;
    selectedDate.value = null;
    searchController.text = '';
    fetchInitialCustomers();
  }

  String formatDateForTextField(DateTime? date) {
    if (date == null) return "All";
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
  Rxn<ApiResponse> apiResponse = Rxn<ApiResponse>();

  Future<dynamic> getRating(
      String rating,
      String offerRedemptionId,
      String comment,
      ) async {
    try {
      isLoading.value = true;

      final response = await Repository().rating({
        "rating": rating,
        "offerRedemptionId": offerRedemptionId,
        "comment": comment,
      });

      return response;

    } catch (e) {
      print("Error in getRating: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

}




