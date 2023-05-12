import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:socialverse/export.dart';
import 'package:http/http.dart' as http;
import 'network_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch Subverses:', () {
    final repository = NetworkRepository();

    test(
      'returns all subverses if the http call completes successfully',
      () async {
        final client = MockClient();
        when(client.get(Uri.parse(
                '${AppConstants.apiEndPoint}${AppConstants.categories}?page=1')))
            .thenAnswer((_) async => http.Response('', 200));
      },
    );

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get(Uri.parse(
              '${AppConstants.apiEndPoint}${AppConstants.categories}?page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(repository.fetchSubverses(client: client), throwsException);
    });
  });
  // group(
  //   'Socialverse API Call: ',
  //   () {
  //     test('Login user account', () async {
  //       final repository = NetworkRepository();
  //       Map data = {
  //         'mixed': 'socialtest',
  //         'password': 'testcrash1',
  //       };
  //       login({context}) async {
  //         var response = await repository.login(data, context);
  //         expect(response['status'], 'success');
  //       }
  //     });
  //   },
  // );
}
