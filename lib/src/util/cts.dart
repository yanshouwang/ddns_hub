class CTS {
  CTS() : _cancelled = false;

  bool _cancelled;
  bool get cancelled => _cancelled;

  void cancel() {
    _cancelled = true;
  }
}
