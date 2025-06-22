# 🔗 lynk_io

A scalable and reusable API communication layer built with Dio for Flutter apps.  
Designed to simplify API calls, error handling, and dependency setup — following Clean Architecture, modular design, and SOLID principles.

---

## 🚀 Features

* Generic GET, POST, PUT, PATCH, DELETE support for single objects and lists
* Clean separation of concerns using SOLID principles
* Global error handling with structured exceptions
* Built-in pluggable logger
* Plug-and-play dependency injection via `get_it`
* `.env` based API URL configuration (cross-platform)
* Optional **auth interceptor** via `getToken()` callback
* Multipart file upload / download utilities
* Easily extensible and testable structure

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  lynk_io: ^0.0.7 # latest
  flutter_dotenv: ^5.1.0
```

---

## 🧱 Environment Setup

To dynamically manage environments like dev, staging, and production:

1. Create a `.env` file at the root of your Flutter app:

```env
API_BASE_URL=<your-server-url>
```

2. Register the `.env` file in your `pubspec.yaml`:

```yaml
flutter:
  assets:
    - .env
```

3. Load the environment and set up dependencies before `runApp()`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lynk_io/lynk_io.dart';

void main() async {
  await dotenv.load();
  final baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  setupDependencies(
    baseUrl: baseUrl,
    getToken: () async {
      // Replace with your token logic
      return 'your-auth-token';
    },
  );

  runApp(MyApp());
}
```

---

## 🛡️ Token-based Auth Interceptor

The package supports authenticated requests via an optional `getToken()` function:

```dart
setupDependencies(
  baseUrl: baseUrl,
  getToken: () async {
    // fetch your token securely
    return await storage.read(key: 'accessToken');
  },
);
```

All requests will automatically include:

```
Authorization: Bearer <your-token>
```

---

## 📦 Example API Usage

Define a model class:

```dart
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
        id: json['id'],
        title: json['title'],
        completed: json['completed'],
      );
}
```

Fetch a list of todo items:

```dart
final api = locator<ApiClient>();

final result = await api.get<List<ItemModel>>(
  endpoint: '/todos',
  fromJson: (json) {
    final rawList = json as List;
    return rawList.map((e) => ItemModel.fromJson(e)).toList();
  },
);

if (result.isSuccess) {
  final items = result.data!;
  for (final item in items) {
    AppLogger.info('Item: ${item.title}');
  }
} else {
  AppLogger.error('Error: ${result.error!.message}');
}
```

---

## 📤 POST Request Example

```dart
final result = await api.get<ItemModel>(
  endpoint: '/todos/1',
  fromJson: (json) => ItemModel.fromJson(json as Map<String, dynamic>),
);
```

---

## 🔄 Other Supported Methods

### ✅ `GET<T>()`

```dart
final result = await api.get<List<ItemModel>>(
  endpoint: '/todos',
  fromJson: (json) {
    final rawList = json as List;
    return rawList.map((e) => ItemModel.fromJson(e)).toList();
  },
);
```

### ✅ `POST<T>()`

```dart
final result = await api.post<ItemModel>(
  endpoint: '/todos',
  data: {
    'title': 'New task',
    'completed': false,
  },
  fromJson: (json) => ItemModel.fromJson(json as Map<String, dynamic>),
);
```

### ✅ `PUT<T>()`

```dart
final result = await api.put<ItemModel>(
  endpoint: '/todos/1',
  data: {
    'title': 'Updated task',
    'completed': true,
  },
  fromJson: (json) => ItemModel.fromJson(json as Map<String, dynamic>),
);
```

### ✅ `PATCH<T>()`

```dart
final result = await api.patch<ItemModel>(
  endpoint: '/todos/1',
  data: {
    'completed': true,
  },
  fromJson: (json) => ItemModel.fromJson(json as Map<String, dynamic>),
);
```

### ✅ `DELETE<T>()`

```dart
final result = await api.delete<ItemModel>(
  endpoint: '/todos/1',
  fromJson: (json) => ItemModel.fromJson(json as Map<String, dynamic>),
);
```

All methods return a unified `ApiResponse<T>` that encapsulates success and error data.

---

## 📁 File Upload & Download

Upload a file:

```dart
final api = locator<ApiClient>();
await api.files.uploadFile(
  'path/to/file.jpg',
  '/upload-endpoint',
);
```

Download a file:

```dart
await api.files.downloadFile(
  'https://server.com/file.pdf',
  '/local/save/path/file.pdf',
);
```

---

## 🧪 Testing & Extensibility

* Easily mock the `ApiClient` for tests
* Pass custom interceptors via `setupDependencies(...)`
* Add more interceptors like caching, logging, etc.

---

## 👨‍💻 Author

Built and maintained with ❤️ by **Siva G**  
Feel free to contribute, fork, or drop feedback!

---