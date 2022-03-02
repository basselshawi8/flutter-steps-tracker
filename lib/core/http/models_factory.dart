import 'package:micropolis_test/core/models/BaseModel.dart';

class ModelsFactory {
  // Singleton handling.
  static ModelsFactory? _instance;

  static ModelsFactory getInstance() {
    if (_instance != null) return _instance!;
    _instance = ModelsFactory();
    return _instance!;
  }

  // Mapping each model name with the actual value using fromJson factory method.

  Map<String, dynamic Function(Map<String, dynamic>)> _modelsMap = {};
  Map<String, dynamic Function(List<dynamic>)> _modelsList = {};

  // Register the model in the map.
  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelCreator,
    bool isList,
  ) {
    if (isList) {
      _modelsList.putIfAbsent(modelName, () => modelCreator);
    } else {
      _modelsMap.putIfAbsent(modelName, () => modelCreator);
    }
  }

  // Generate the desired T model.
  T createModel<T extends BaseModel>(json) {
    final modelName = T.toString();
    final model = json is List == false
        ? _modelsMap[modelName]!(json) as T
        : _modelsList[modelName]!(json) as T;
    return model;
  }

  // Generate list of T model.
  List<T?> createModelsList<T extends BaseModel>(json) {
    print(T.toString());
    var tmp = (json as List)
        .map((m) => m == null ? null : createModel<T>(m))
        .toList();
    return tmp;
  }
}
