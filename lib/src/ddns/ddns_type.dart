/// DDNS type.
enum DDNSType {
  /// IPV4
  a('A'),

  /// IPV6
  aaaa('AAAA');

  /// The name of DDNS type.
  final String name;

  const DDNSType(this.name);
}
