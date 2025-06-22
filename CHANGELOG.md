
## 0.0.1

- Initial release
- Supports GET requests with error handling
- Setup with dependency injection
- Utilities and logging

## 0.0.2

- Readme file updated with features and installation instructions

## 0.0.3

- Introduced Optional **auth interceptor** via `getToken()` callback

## 0.0.4

- dart format performed
- documentation and examples added
- followed Dart file conventions

## 0.0.5

- released on pub.dev along with changelog updates

## 0.0.6

- Downgraded logger dependency to ^1.1.0 to ensure compatibility with the stacked package.
- Updated the fromJson parameter to accept dynamic instead of strictly Map<String, dynamic> 
  for broader deserialization support.
- Introduced default interceptors that are applied only when the app layer does not provide custom interceptors.