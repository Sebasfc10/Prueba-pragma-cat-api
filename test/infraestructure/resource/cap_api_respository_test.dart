import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cat_api_prueba_pragma_jeant/infraestructure/resource/cat_api_repositoy.dart';
import 'package:cat_api_prueba_pragma_jeant/domain/models/cat_model.dart';
import 'dart:convert';

// Define un MockClient
class MockClient extends Mock implements http.Client {}

void main() {
  group('CatApiRepository', () {
    late CatApiRepository catApiRepository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      catApiRepository = CatApiRepository(mockClient); // Asegúrate de pasar el MockClient al repositorio
    });

    test('fetchCatBreeds devuelve una lista de gatos con imágenes', () async {
      final catJson = {
        'id': '1',
        'name': 'Cat 1',
        'reference_image_id': 'img123'
      };

      final imageJson = {
        'id': 'img123',
        'url': 'https://example.com/cat123.jpg'
      };

      // Configura el MockClient para devolver una respuesta simulada
     when(mockClient.get(
  Uri.parse('https://api.thecatapi.com/v1/breeds'),
  headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
)).thenAnswer(
  (_) async => http.Response(json.encode([catJson]), 200),
);

when(mockClient.get(
  Uri.parse('https://api.thecatapi.com/v1/images/'), // URL ajustada
  headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
)).thenAnswer(
  (_) async => http.Response(json.encode(imageJson), 200),
);


      // Prueba el método fetchCatBreeds
      final cats = await catApiRepository.fetchCatBreeds();

      expect(cats, isNotEmpty);
      expect(cats.first.imageUrl, 'https://example.com/cat123.jpg');
    });

    test('fetchCatBreeds lanza una excepción en caso de error', () async {
      // Configura el MockClient para devolver una respuesta de error
      when(mockClient.get(
        Uri.parse('https://api.thecatapi.com/v1/breeds'),
        headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'}, // Reemplaza con la clave API correcta
      )).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      // Verifica que se lanza una excepción
      expect(() async => await catApiRepository.fetchCatBreeds(), throwsException);
    });
  });
  
}
