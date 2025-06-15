
import 'package:dio/dio.dart';

/// A utility class to handle file-related operations such as uploading
/// and downloading using Dio.
///
/// Example:
/// ```dart
/// final utils = FileUtils(dio);
/// await utils.uploadFile('/path/to/file', 'https://example.com/upload');
/// await utils.downloadFile('https://example.com/file.pdf', '/local/file.pdf');
/// ```
class FileUtils {
  final Dio _dio;

  /// Creates an instance of [FileUtils] with the given [Dio] client.
  FileUtils(this._dio);

  /// Uploads a file to the specified [uploadUrl].
  ///
  /// [path] is the local file path.
  /// [fieldName] is the form field name for the file, defaults to `'file'`.
  ///
  /// Returns a [Response] from the server.
  Future<Response> uploadFile(
      String path,
      String uploadUrl, {
        String fieldName = 'file',
      }) {
    final file = MultipartFile.fromFileSync(path);
    final formData = FormData.fromMap({fieldName: file});
    return _dio.post(uploadUrl, data: formData);
  }

  /// Downloads a file from [fileUrl] and saves it to [savePath].
  ///
  /// Returns a [Response] indicating the download status.
  Future<Response> downloadFile(String fileUrl, String savePath) {
    return _dio.download(fileUrl, savePath);
  }

}
