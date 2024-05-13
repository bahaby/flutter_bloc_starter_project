import 'package:json_annotation/json_annotation.dart';

class StringToBoolConverter implements JsonConverter<bool, String> {
  const StringToBoolConverter();

  @override
  bool fromJson(String json) => json.toLowerCase() == 'true';

  @override
  String toJson(bool object) => object ? 'true' : 'false';
}
