import 'package:dio/dio.dart';

class HomeService {
  final dio = Dio();
  final urlRandomData = 'https://coffee.alexflipnote.dev/random.json';

  Future<List<String>> getListImageHomePage() async {
    try {
      List<String> returnValue = [];
      for (var i = 0; i < 10; i++) {
        Response imageUrl =
            await dio.get('https://coffee.alexflipnote.dev/random.json');

        Map<String, dynamic> data = imageUrl.data;

        if (data['file'] == null || data['file'] == '') {
          throw 'An error occurred during the request';
        } else {
          returnValue.add(imageUrl.data['file']);
        }
      }
      return returnValue;
    } catch (e) {
      rethrow;
    }
  }
}
