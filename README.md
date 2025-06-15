# 🔗 lynk_io

A scalable and reusable API communication layer built with Dio for Flutter apps.  
Designed to simplify API calls, error handling, and dependency setup — following Clean Architecture, modular design, and SOLID principles.

---

## 🚀 Features

- Generic GET, POST, PUT, PATCH, DELETE support
- Clean separation of concerns using SOLID principles
- Global error handling with structured exceptions
- Built-in pluggable logger
- Plug-and-play dependency injection via `get_it`
- `.env` based API URL configuration (cross-platform)
- Optional **auth interceptor** via `getToken()` callback
- Multipart file upload / download utilities
- Easily extensible and testable structure

---

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  lynk_io: ^0.0.3 # latest
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
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name']);
}
```

Fetch user data:

```dart
final api = locator<ApiClient>();

final result = await api.get<User>(
  endpoint: '/user/<user-id>',
  fromJson: User.fromJson,
);

if (result.isSuccess) {
  AppLogger.log("User: ${result.data!.name}");
} else {
  AppLogger.error("Error: ${result.error!.message}");
}
```

---

## 📤 POST Request Example

```dart
final result = await api.post<User>(
  endpoint: '/users',
  body: {
    'name': 'Siva G',
    'email': 'siva@example.com',
  },
  fromJson: User.fromJson,
);
```

---

## 🔄 Other Supported Methods

### ✅ `GET<T>()`

```dart
api.get<T>(
  endpoint: '/items',
  fromJson: T.fromJson,
);
```

### ✅ `POST<T>()`

```dart
api.post<T>(
  endpoint: '/items',
  body: {...},
  fromJson: T.fromJson,
);
```

### ✅ `PUT<T>()`

```dart
api.put<T>(
  endpoint: '/items/1',
  body: {...},
  fromJson: T.fromJson,
);
```

### ✅ `PATCH<T>()`

```dart
api.patch<T>(
  endpoint: '/items/1',
  body: {...},
  fromJson: T.fromJson,
);
```

### ✅ `DELETE<T>()`

```dart
api.delete<T>(
  endpoint: '/items/1',
  fromJson: T.fromJson,
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

- Easily mock the `ApiClient` for tests
- Pass custom interceptors via `setupDependencies(...)`
- Add more interceptors like caching, logging, etc.

---

## 👨‍💻 Author

Built and maintained with ❤️ by **Siva G**  
Feel free to contribute, fork, or drop feedback!

---