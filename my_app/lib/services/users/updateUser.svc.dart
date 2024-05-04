import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/common/globs.dart';

class UpdateUserSvc {
  static String url = SVKey.updateUser;

  static Future<Map<String, dynamic>> postRequest(
      Map<String, dynamic> body, String userId, XFile? imageFile) async {
    try {
      Dio dio = Dio();

      FormData formData = FormData.fromMap(body);

      if (imageFile != null) {
        formData.files.add(MapEntry(
            'avatar',
            MultipartFile.fromFileSync(imageFile.path,
                filename: imageFile.path.split('/').last)));
      }

      var response = await dio.put(
        url.replaceFirst(':userId', userId),
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            // Add other headers here
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data['updatedUser'];

        Globs.udStringSet(
          data[KKey.id],
          'userId',
        );
        Globs.udStringSet(
          data[KKey.fullName],
          'fullName',
        );
        Globs.udStringSet(
          data[KKey.email],
          'email',
        );
        Globs.udStringSet(
          data[KKey.avatar],
          'avatar',
        );
        Globs.udStringSet(
          data[KKey.phone],
          'phone',
        );
        Globs.udStringSet(
          data[KKey.address],
          'address',
        );
        return data;
      } else {
        // If the server returns an unexpected response, throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioError && e.response != null) {
        print('Response data: ${e.response!.data}');
      }
      print('Error call api: $e');
      rethrow;
    }
  }
}
