import 'package:api_veri/product/database/hive_initialize.dart';
import 'package:api_veri/product/database/hive_operations.dart';

class HiveManager with HiveInitialize {
  static final HiveManager _instance = HiveManager._internal();
  factory HiveManager() => _instance;
  HiveManager._internal();

  final HiveOperations _operations = HiveOperations();

  @override
  Future<void> initHive() async {
    await _operations.initHive();
  }

  HiveOperations get operations => _operations;
}
