import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:very_good_coffee_app/features/details/details_image_model.dart';

class HomeService {
  final dio = Dio();
  var uuid = const Uuid();
  final urlRandomData = 'https://coffee.alexflipnote.dev/random.json';

  Future<List<DetailsImageModel>> getListImageHomePage() async {
    List<DetailsImageModel> returnValue = [];
    for (var i = 0; i < 10; i++) {
      Response imageUrl =
          await dio.get('https://coffee.alexflipnote.dev/random.json');

      Map<String, dynamic> data = imageUrl.data;

      if (data['file'] == null || data['file'] == '') {
        throw 'An error occurred during the request';
      } else {
        returnValue.add(
          DetailsImageModel(
            url: imageUrl.data['file'],
            uuid: uuid.v4(),
          ),
        );
      }
    }

    return returnValue;
  }
}
