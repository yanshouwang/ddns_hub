abstract class Storage {
  Future<bool> exists();
  Future<String> read();
  Future<void> write(String value);
}
