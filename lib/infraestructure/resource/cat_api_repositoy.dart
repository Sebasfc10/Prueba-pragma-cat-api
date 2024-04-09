import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cat_api_prueba_pragma_jeant/domain/models/cat_model.dart';

class CatApiRepository {
  final url = 'https://api.thecatapi.com/v1/breeds';
  final apiKey = 'bda53789-d59e-46cd-9bc4-2936630fde39';

  Future<List<CatModel>> fetchCatBreeds() async {
    final response = await http.get(
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
    final response = await http.get(
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
    final response = await http.get(
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
