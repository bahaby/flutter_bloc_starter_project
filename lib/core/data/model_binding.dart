abstract interface class ModelBindings<T> {
  const ModelBindings();

  int? getId(T obj);

  Map<String, Object?> toJson(T obj);

  T fromJson(Map<String, Object?> json);

  int sortDesc(T a, T b);
}
