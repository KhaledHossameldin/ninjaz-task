import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ninjaz_task/src/models/post/post/post.dart';

import 'posts_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  Future<List<Post>> fetch(http.Client client) async {
    try {
      final response = await client.get(
        Uri.https(
          dotenv.env['DOMAIN']!,
          '${dotenv.env['API_PATH']!}/post',
          {'page': '1', 'limit': '20'},
        ),
      );
      final list = json.decode(response.body)['data'] as List;
      return list.map((item) => Post.fromJson(item)).toList();
    } catch (e) {
      throw 'message';
    }
  }

  group('(Posts)', () {
    test(
      'return a list of Posts if the http call completes successfully',
      () async {
        final client = MockClient();
        when(client.get(Uri.https(
          dotenv.env['DOMAIN']!,
          '${dotenv.env['API_PATH']!}/post',
          {'page': '1', 'limit': '20'},
        ))).thenAnswer(
          (_) async => http.Response('''{"data": [{
            "id": "id",
            "image": "link",
            "likes": 0,
            "tags": ["tag"],
            "text": "text",
            "publishDate": "1900-01-01T00:00:00.000Z",
            "owner": {
                "id": "id",
                "title": "title",
                "firstName": "name",
                "lastName": "name",
                "picture": "link"
            }
          }]}''', 200),
        );
        expect(await fetch(client), isA<List<Post>>());
      },
    );

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(
        Uri.https(
          dotenv.env['DOMAIN']!,
          '${dotenv.env['API_PATH']!}/post',
          {'page': '1', 'limit': '20'},
        ),
      )).thenAnswer((_) async => http.Response('{"message": "message"}', 400));
      expect(fetch(client), throwsA(isA<String>()));
    });
  });
}
