# cadt_project2_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 1. Setup package name For [Android]
1. Looking at the build.gradle file:
    - Go to android/app/build.gradle.
    - Look for the applicationId field inside the defaultConfig block, which represents the package name for your Android app.
```
defaultConfig {
    applicationId "dev.codemie.cadt_project2_mobile" // This is your package name
    minSdkVersion 21
    targetSdkVersion 33
    versionCode 1
    versionName "1.0"
}
```
2. Check your directory structure:
    - In android/app/src/main/kotlin/ or android/app/src/main/java/, the folder structure will be based on your package name. For example, if your package name is dev.codemie.cadt_project2_mobile, you will see a directory structure like dev/codemie/cadt_project2_mobile/.

Add the correct package name as package="dev.codemie.cadt_project2_mobile" inside the <manifest> tag if it’s not present, or confirm it through the build.gradle file and directory structure.
## 2. For iOS (Bundle Identifier)
The bundle identifier for your Flutter iOS app is defined in the ios/Runner.xcodeproj or ios/Runner.xcworkspace file:

Open the ios folder in your Flutter project using Xcode.
In Xcode, click on the Runner project in the project navigator on the left.
Select the Runner target, then click on the General tab.
You’ll see the Bundle Identifier under Identity.
```
Bundle Identifier: com.example.myapp
```
For iOS: Open the Runner project in Xcode, and in the General tab, update the Bundle Identifier.

## Packages
- flutter_appauth: ^8.0.3

- flutter_secure_storage: ^8.0.0
Use flutter_secure_storage to securely store and retrieve a token in a Flutter app.
```
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create a storage instance
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

// Write data (e.g., storing a token)
await secureStorage.write(key: 'access_token', value: 'your_access_token');

// Read data (e.g., retrieving the token)
String? token = await secureStorage.read(key: 'access_token');

// Delete data (e.g., clearing the token)
await secureStorage.delete(key: 'access_token');
```

### Use Case in OAuth 2.0 Authentication
In the context of OAuth 2.0, after obtaining tokens (access tokens, refresh tokens, etc.), you should store them securely. flutter_secure_storage is ideal for this purpose because it ensures that the sensitive information (e.g., tokens) is not easily accessible by other apps or users. This is why it's commonly used in conjunction with flutter_appauth, as seen in the code I provided earlier.

For example:

Access Token Storage: Store the access token after authentication.
Refresh Token Storage: Store the refresh token securely so you can use it to refresh the access token when it expires.

```
import 'dart:io' show Platform;

final String _redirectUrl = Platform.isAndroid
    ? 'dev.codemie.cadt_project2_mobile:/callback'
    : 'dev.codemie.cadt-project2-mobile:/callback';

```
