import 'package:data_list/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';


class InitialBindings extends Bindings{
  @override
  void dependencies() {
    // configEasyLoading();
    // Get.lazyPut<LocalStorage>(() => LocalStorageImpl());
    // Get.put<EmployeeStore>(EmployeeStore(Get.find<LocalStorage>()),
    //     permanent: true);
    Get.put<HttpClient>(HttpClientImpl(Dio()), permanent: true);
  }
}
