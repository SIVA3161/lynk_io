
import 'package:dio/dio.dart';

class FileUtils {
  final Dio _dio;

  FileUtils(this._dio);

  Future<Response> uploadFile(String path, String uploadUrl, {String fieldName = 'file'}) {
    final file = MultipartFile.fromFileSync(path);
    final formData = FormData.fromMap({fieldName: file});
    return _dio.post(uploadUrl, data: formData);
  }

  Future<Response> downloadFile(String fileUrl, String savePath) {
    return _dio.download(fileUrl, savePath);
  }

}
