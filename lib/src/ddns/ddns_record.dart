import 'ddns_type.dart';

class DDNSRecord {
  final String name;
  final DDNSType type;
  final String value;
  final int ttl;

  DDNSRecord({
    required this.name,
    required this.type,
    required this.value,
    this.ttl = 600,
  });

  DDNSRecord copyWith({
    String? value,
    int? ttl,
  }) {
    value ??= this.value;
    ttl ??= this.ttl;
    return DDNSRecord(
      name: name,
      type: type,
      value: value,
      ttl: ttl,
    );
  }

  @override
  operator ==(Object other) {
    return other is DDNSRecord && other.name == name && other.type == type;
  }

  @override
  int get hashCode => Object.hash(name, type);
}
