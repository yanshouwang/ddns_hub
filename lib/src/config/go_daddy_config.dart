import 'package:json_annotation/json_annotation.dart';

import 'ddns_domain_config.dart';

part 'go_daddy_config.g.dart';

class GoDaddyConfig {
  final String key;
  final String secret;
  final List<DDNSDomainConfig> domains;

  GoDaddyConfig({
    required this.key,
    required this.secret,
    required this.domains,
  });

  factory GoDaddyConfig.fromJSON(Map<String, dynamic> json) {
    final args = GoDaddyConfigArgs.fromJson(json);
    return GoDaddyConfig.fromArgs(args);
  }

  factory GoDaddyConfig.fromArgs(GoDaddyConfigArgs args) {
    final domainsArgs = args.domainsArgs;
    return GoDaddyConfig(
      key: args.keyArgs,
      secret: args.secretArgs,
      domains: domainsArgs
          .map((domainArgs) => DDNSDomainConfig.fromArgs(domainArgs))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    final args = toArgs();
    return args.toJson();
  }

  GoDaddyConfigArgs toArgs() {
    return GoDaddyConfigArgs(
      keyArgs: key,
      secretArgs: secret,
      domainsArgs: domains.map((domain) => domain.toArgs()).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class GoDaddyConfigArgs {
  @JsonKey(name: 'key')
  final String keyArgs;
  @JsonKey(name: 'secret')
  final String secretArgs;
  @JsonKey(name: 'domains')
  final List<DDNSDomainConfigArgs> domainsArgs;

  GoDaddyConfigArgs({
    required this.keyArgs,
    required this.secretArgs,
    required this.domainsArgs,
  });

  factory GoDaddyConfigArgs.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyConfigArgsFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyConfigArgsToJson(this);
}
