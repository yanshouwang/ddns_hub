import 'ddns_record.dart';

class DDNSDomain {
  final String name;
  final Set<DDNSRecord> records;

  DDNSDomain({
    required this.name,
    required this.records,
  });

  @override
  operator ==(Object other) {
    return other is DDNSDomain && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
