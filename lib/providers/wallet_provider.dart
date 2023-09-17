import 'package:kooha/model/wallet_model.dart';
import 'package:kooha/services/api_basics.dart';
import 'package:kooha/services/request_type.dart';
import 'package:kooha/utils/application_state.dart';
import 'package:kooha/utils/endpoints.dart';
import 'package:get/get.dart';

WalletModel? wallet;

class WalletProvider extends GetxController {
  var userwallet = wallet.obs;
  final ApiBasics _apiBasics = ApiBasics();

  ApplicationState appState = ApplicationState.NEUTRAL;
  WalletProvider() {
    getwallet();
  }
  void getwallet() async {
    _apiBasics
        .performRequest(
            showSuccess: false,
            requestType: RequestType.GET,
            url: Endpoints.USER_WALLET)
        .then((value) {
      appState = value.appState!;
      userwallet.value = WalletModel.fromJson(json: value.data!);
    });
  }

  @override
  void onInit() {
    getwallet();
    super.onInit();
  }
}
