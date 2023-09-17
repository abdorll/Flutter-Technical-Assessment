import 'package:kooha/model/transaction_data.dart';
import 'package:kooha/services/api_basics.dart';
import 'package:kooha/services/request_type.dart';
import 'package:kooha/utils/endpoints.dart';
import 'package:get/get.dart';

class TransactionListProvider extends GetxController {
  final ApiBasics _apiBasics = ApiBasics();
  var transactionList = [].obs;

  getTransactionsData() async {
    var availablePackages = _apiBasics.performRequest(
        showSuccess: false,
        requestType: RequestType.GET,
        url: Endpoints.TRANSACTIONS_LIST);
    availablePackages.then((value) {
      List<dynamic> packages = value.data["records"];
      transactionList.value = packages
          .map((json) => TransactionsData.fromJson(json: json))
          .toList();
    });
  }

  @override
  void onInit() {
    getTransactionsData();
    super.onInit();
  }
}
