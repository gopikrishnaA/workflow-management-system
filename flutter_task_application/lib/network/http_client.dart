import 'package:flutter_task_application/res/routes/routes.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Skip interceptor for login and signup APIs
    if (request.url.path.contains(Routes.signInScreen) ||
        request.url.path.contains(Routes.signUpScreen)) {
      return _inner.send(request);
    }

    // Add your interceptor logic here
    print("Intercepting request: ${request.url}");

    // Example: Add authorization header
    request.headers["Authorization"] = "Bearer YOUR_TOKEN";

    return _inner.send(request);
  }
}
