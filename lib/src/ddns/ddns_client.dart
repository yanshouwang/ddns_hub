import 'package:logging/logging.dart';

import 'ddns_domain.dart';
import 'ddns_type.dart';

abstract class DDNSClient {
  final Set<DDNSDomain> domains;

  DDNSClient({required this.domains});

  Logger get logger => Logger('$runtimeType');

  Future<void> update(Map<DDNSType, String> values);
}
