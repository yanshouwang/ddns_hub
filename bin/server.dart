import 'dart:developer';
import 'dart:io';

import 'package:ddns_hub/ddns_hub.dart';
import 'package:logging/logging.dart';

void main(List<String> args) async {
  Logger.root.onRecord.listen(onLogged);
  // Use any available host or container IP (usually `0.0.0.0`).
  final address = InternetAddress.anyIPv4;
  // For running in containers, we respect the DDNS_HUB_PORT environment variable.
  final port = int.parse(Platform.environment['DDNS_HUB_PORT'] ?? '3543');
  final ddnsHub = DDNSHub();
  await ddnsHub.setUp();
  final server = await ddnsHub.serve(address, port);
  Logger.root.info('Serving at http://${server.address.host}:${server.port}');
}

void onLogged(LogRecord record) {
  log(
    record.message,
    time: record.time,
    sequenceNumber: record.sequenceNumber,
    level: record.level.value,
    name: record.loggerName,
    zone: record.zone,
    error: record.error,
    stackTrace: record.stackTrace,
  );
}
