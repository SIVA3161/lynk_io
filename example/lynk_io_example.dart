
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lynk_io/lynk_io.dart';

Future<void> main() async {
  await dotenv.load();
  final baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  setupDependencies(baseUrl: baseUrl);

  final api = locator<ApiClient>();

  try {
    final response = await api.get<List<ItemModel>>(
      endpoint: '/todos',
      fromJson: (json) {
        final rawList = json as List;
        return rawList.map((e) => ItemModel.fromJson(e)).toList();
      },
    );

    if (response.isSuccess && response.data != null) {
      for (final item in response.data!) {
        print('Todo: ${item.title} - Completed: ${item.completed}');
      }
    } else {
      print('API Error: ${response.error?.message ?? 'Unknown error'}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}


class ItemModel {
  final int id;
  final String title;
  final bool completed;

  ItemModel({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    id: json['id'] as int,
    title: json['title'] as String,
    completed: json['completed'] as bool,
  );
}