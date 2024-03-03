import 'package:dio/dio.dart';
import 'package:giphy_demo_app/models/category_list_model.dart';
import 'package:giphy_demo_app/models/search_data_model.dart';

class ApiHelper {
  final String baseUrl;
  final String apiKey;
  final Dio _dioClient;

  ApiHelper({
    this.baseUrl = "api.giphy.com",
    this.apiKey = "7tAePzkqgs2NdJIB0l1QrdPM53w2tr54",
    Dio? dioClient,
  }) : _dioClient = dioClient ?? Dio();

  static const FETCH_CATEGORIES_ENDPOINT = "/v1/gifs/categories";

  static const SEARCH_GIFS_ENDPOINT = "/v1/gifs/search";

  static const _limit = '25';
  static const _rating = 'g';
  static const _lang = 'en';
  static const _bundle = 'messaging_non_clips';

  Future<CategoryListModel> fetchCategories() async {
    final queryParam = {
      'api_key': apiKey,
    };
    final url =
        Uri.http(baseUrl, FETCH_CATEGORIES_ENDPOINT, queryParam).toString();

    final response = await _dioClient.get<String>(url,
        options: Options(
          contentType: Headers.jsonContentType,
        ));

    final responseObject = CategoryListModel.fromJson(response.toString());
    return responseObject;
  }

  Future<SearchListModel> searchGifs({
    required String query,
    required String offset,
  }) async {
    final queryParam = {
      'api_key': apiKey,
      'q': query,
      'limit': _limit,
      'offset': offset,
      'rating': _rating,
      'lang': _lang,
      'bundle': _bundle,
    };
    final url = Uri.http(baseUrl, SEARCH_GIFS_ENDPOINT, queryParam).toString();

    final response = await _dioClient.get<String>(url,
        options: Options(
          contentType: Headers.jsonContentType,
        ));
    final responseObject = SearchListModel.fromJson(response.toString());
    return responseObject;
  }
}
