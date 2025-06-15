
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lynk_io/lynk_io.dart';

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name']);
}

Future<void> main() async {
  await dotenv.load();
  final baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  setupDependencies(baseUrl: baseUrl);

  final api = locator<ApiClient>();

  final response = await api.get<User>(
    endpoint: '/users/1',
    fromJson: User.fromJson,
  );

  if (response.isSuccess) {
    print('User Name: ${response.data?.name}');
  } else {
    print('Error: ${response.error?.message}');
  }
}
