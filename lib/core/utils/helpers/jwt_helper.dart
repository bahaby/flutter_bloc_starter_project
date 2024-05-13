import 'dart:convert';

class JwtHelper {
  static bool isTokenExpiring(String? token,
      {Duration durationOffset = const Duration(minutes: 1)}) {
    if (token == null) {
      return true;
    }
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return true;
      }

      final payload = json.decode(
        utf8.decode(
          base64Url.decode(
            base64Url.normalize(parts[1]),
          ),
        ),
      );

      final exp = payload['exp'];
      if (exp == null) return true;
      final nowPlus = DateTime.now().add(durationOffset);

      return DateTime.fromMillisecondsSinceEpoch(exp * 1000).isBefore(nowPlus);
    } catch (e) {
      return true;
    }
  }
}
