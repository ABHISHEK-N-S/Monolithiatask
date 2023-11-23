import 'package:data_list/network/http_client.dart';
import 'package:data_list/network/network_constants.dart';
import 'package:data_list/network/url_constants.dart';

enum EndPoint {
  posts,
  comments,
  delete,
  addPost


}



extension URLExtenssion on EndPoint {
  static const String _baseUrl = AppConstants.baseURL;


  String get url {
    switch (this) {
      case EndPoint.posts:
        return '$_baseUrl${UrlConstants.posts}';
      case EndPoint.comments:
        return '$_baseUrl${UrlConstants.comments}';
      case EndPoint.delete:
        return '$_baseUrl${UrlConstants.posts}';
      case EndPoint.addPost:
        return '$_baseUrl${UrlConstants.posts}';
    }
  }

  /// this method is used to replace | with id
  String cleanUrlWith(String id) {
    return url.replaceAll("|", id);
  }
}

extension RequestMode on EndPoint {
  RequestType get requestType {
    RequestType requestType = RequestType.get;

    switch (this) {
      case EndPoint.posts:
        requestType = RequestType.get;
        break;

      case EndPoint.comments:
        requestType = RequestType.get;
        break;
      case EndPoint.delete:
        requestType = RequestType.delete;
        break;
      case EndPoint.addPost:
        requestType = RequestType.post;
        break;
    }

    return requestType;
  }
}

