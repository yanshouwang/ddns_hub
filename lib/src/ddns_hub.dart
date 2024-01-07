import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as sio;
import 'package:shelf_router/shelf_router.dart';

import 'config.dart';
import 'ddns.dart';
import 'storage.dart';
import 'util.dart';

part 'ddns_hub.g.dart';

class DDNSHub {
  final Storage _storage;
  final HttpClient _httpClient;
  final Set<DDNSClient> _ddnsClients;
  final Map<DDNSType, String> _values;

  DDNSHub()
      : _storage = FileStorage('/.ddns_hub/config.json'),
        _httpClient = HttpClient(),
        _ddnsClients = {},
        _values = {};

  Logger get _logger => Logger('$runtimeType');
  Router get _router => _$DDNSHubRouter(this);

  Future<void> setUp() async {
    // Create config file if not exists.
    final existes = await _storage.exists();
    if (!existes) {
      final undefinedConfigJSON = DDNSHubConfig().toJSON();
      final undefinedConfigText = json.encode(undefinedConfigJSON);
      await _storage.write(undefinedConfigText);
    }
    final configText = await _storage.read();
    final configJSON = json.decode(configText);
    final config = DDNSHubConfig.fromJSON(configJSON);
    final duration = config.duration;
    final ticks = config.times;
    final ipv4Url = config.ipv4Url;
    final ipv6Url = config.ipv6Url;
    final goDaddyConfig = config.goDaddy;
    if (goDaddyConfig != null) {
      final goDaddy = GoDaddyClient(
        key: goDaddyConfig.key,
        secret: goDaddyConfig.secret,
        domains: goDaddyConfig.domains
            .map((domainConfig) => DDNSDomain(
                  name: domainConfig.name,
                  records: domainConfig.records
                      .expand((recordConfig) =>
                          recordConfig.types.map((typeName) => DDNSRecord(
                                name: recordConfig.name,
                                type: DDNSType.values.firstWhere(
                                    (type) => type.name == typeName),
                                value: '',
                              )))
                      .toSet(),
                ))
            .toSet(),
      );
      _ddnsClients.add(goDaddy);
    }
    _updateDDNS(
      duration: Duration(seconds: duration),
      ticks: ticks,
      ipv4Url: ipv4Url == null ? null : Uri.parse(ipv4Url),
      ipv6Url: ipv6Url == null ? null : Uri.parse(ipv6Url),
    );
  }

  CTS? _cts;

  void _updateDDNS({
    required Duration duration,
    required int ticks,
    required Uri? ipv4Url,
    required Uri? ipv6Url,
  }) async {
    if (_cts != null) {
      _logger.severe('_updateDDNS is called when CTS is not null.');
      return;
    }
    final cts = CTS();
    _cts = cts;
    var tick = 0;
    while (!cts.cancelled) {
      try {
        final values = <DDNSType, String>{};
        if (ipv4Url == null && ipv6Url == null) {
          throw ArgumentError('Get IP address without ipv4Url or ipv6Url.');
        }
        if (ipv4Url != null) {
          values[DDNSType.a] = await _httpClient.getIPv4Address(ipv4Url);
        }
        if (ipv6Url != null) {
          values[DDNSType.aaaa] = await _httpClient.getIPv6Address(ipv6Url);
        }
        final unchanged =
            values.keys.every((key) => values[key] == _values[key]);
        final remainedTicks = ticks - tick % ticks;
        if (unchanged && remainedTicks != 0) {
          _logger.info('unchanged, will update after $remainedTicks times.');
          return;
        }
        for (var client in _ddnsClients) {
          await client.update(values);
        }
        for (var entry in values.entries) {
          final type = entry.key;
          final value = entry.value;
          _values[type] = value;
        }
      } catch (e, stack) {
        _logger.severe('$e', e, stack);
      } finally {
        tick++;
        await Future.delayed(duration);
      }
    }
  }

  Future<HttpServer> serve(Object address, int port) async {
    final loggerMiddleware = logRequests(
      logger: (message, failed) {
        if (failed) {
          _logger.severe(message);
        } else {
          _logger.info(message);
        }
      },
    );
    final handler =
        Pipeline().addMiddleware(loggerMiddleware).addHandler(_router);
    final server = await sio.serve(handler, address, port);
    return server;
  }

  @Route.get('/version')
  Future<Response> getVersion(Request request) async {
    return Response.ok('version');
  }
}

extension on HttpClient {
  Future<String> getIPv4Address(Uri url) async {
    final request = await getUrl(url);
    final response = await request.close();
    final content = await response.transform(utf8.decoder).join();
    final match = ipv4Exp.firstMatch(content);
    if (match == null) {
      throw HttpException('Match IPv4 failed with content: $content');
    }
    return match[0]!;
  }

  Future<String> getIPv6Address(Uri url) async {
    final request = await getUrl(url);
    final response = await request.close();
    final content = await response.transform(utf8.decoder).join();
    final match = ipv6Exp.firstMatch(content);
    if (match == null) {
      throw HttpException('Match IPv6 failed with content: $content');
    }
    return match[0]!;
  }
}
