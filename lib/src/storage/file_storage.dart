import 'dart:io';

import 'storage.dart';

class FileStorage extends Storage {
  final File _file;

  FileStorage(String path) : _file = File(path);

  @override
  Future<bool> exists() async {
    final exists = await _file.exists();
    return exists;
  }

  @override
  Future<String> read() async {
    final value = await _file.readAsString();
    return value;
  }

  @override
  Future<void> write(String value) async {
    await _file.create(recursive: true);
    await _file.writeAsString(value);
  }
}
