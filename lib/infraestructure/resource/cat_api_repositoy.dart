import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cat_api_prueba_pragma_jeant/domain/models/cat_model.dart';

class CatApiRepository {
  final http.Client _client;
  final url = 'https://api.thecatapi.com/v1/breeds';
  final apiKey = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWky W2nr';

  CatApiRepository(this._client);

  Future<List<CatModel>> fetchCatBreeds() async {
    final response = await _client.get(
      Uri.parse(url),
      headers: {'x-api-key': apiKey},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      final List<CatModel> catList = [];

      for (var json in jsonList) {
        final CatModel cat = CatModel.fromJson(json);
        final referenceImageId = json['reference_image_id'];
        final imageUrl = await getImageUrl(referenceImageId);

        cat.imageUrl = imageUrl ?? '';

        catList.add(cat);
      }

      return catList;
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  Future<String?> getImageUrl(String? referenceImageId) async {
    if (referenceImageId == null) return null;

    final getImageUrl = 'https://api.thecatapi.com/v1/images/$referenceImageId';
    final response = await _client.get(
      Uri.parse(getImageUrl),
      headers: {'x-api-key': apiKey},
    );
    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      return jsonData['url'];
    } else {
      throw Exception('Failed to get image URL for cat');
    }
  }

  Future<List<CatModel>> searchCatBreeds(String query) async {
    final searchUrl = '$url/search?q=$query&attach_image=1';
    final response = await _client.get(
      Uri.parse(searchUrl),
      headers: {'x-api-key': apiKey},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<CatModel> catList = [];

      for (var json in jsonList) {
        final CatModel cat = CatModel.fromJson(json);
        final referenceImageId = json['reference_image_id'];
        final imageUrl = await getImageUrl(referenceImageId);

        cat.imageUrl = imageUrl ?? '';

        catList.add(cat);
      }

      return catList;
    } else {
      throw Exception('Failed to search cat breeds');
    }
  }
}

