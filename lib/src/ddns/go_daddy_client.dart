import 'dart:convert';
import 'dart:io';

import 'ddns_client.dart';
import 'ddns_record.dart';
import 'ddns_type.dart';
import 'go_daddy_record.dart';

class GoDaddyClient extends DDNSClient {
  final String _key;
  final String _secret;
  final HttpClient _client;

  GoDaddyClient({
    required String key,
    required String secret,
    required super.domains,
  })  : _key = key,
        _secret = secret,
        _client = HttpClient()..findProxy = HttpClient.findProxyFromEnvironment;

  @override
  Future<void> update(Map<DDNSType, String> values) async {
    for (var domain in domains) {
      final url = Uri.https(
        'api.godaddy.com',
        '/v1/domains/${domain.name}/records',
      );
      final request = await _client.patchUrl(url);
      request.headers.add(
        HttpHeaders.contentTypeHeader,
        ContentType.json.toString(),
      );
      request.headers.add(
        HttpHeaders.authorizationHeader,
        'sso-key $_key:$_secret',
      );
      final recordsJSON = domain.records.map((record) {
        final type = record.type;
        final value = values[type];
        return record.copyWith(value: value).toJSON();
      }).toList();
      final recordsText = json.encode(recordsJSON);
      request.write(recordsText);
      final response = await request.close();
      final statusCode = response.statusCode;
      final text = await response.transform(utf8.decoder).join();
      logger.info(text);
      if (statusCode != HttpStatus.ok) {
        throw HttpException(
          'Update ${domain.name} failed with statusCode: $statusCode',
          uri: url,
        );
      }
      logger.info('$domains updated with $values');
    }
  }
}

extension on DDNSRecord {
  Map<String, dynamic> toJSON() {
    return GoDaddyRecord(
      data: value,
      name: name,
      ttl: ttl,
      type: type.name,
    ).toJSON();
  }
}
