import 'package:json_annotation/json_annotation.dart';

import 'go_daddy_config.dart';

part 'ddns_hub_config.g.dart';

class DDNSHubConfig {
  final int duration;
  final int times;
  final String? ipv4Url;
  final String? ipv6Url;
  final GoDaddyConfig? goDaddy;

  DDNSHubConfig({
    this.duration = 60,
    this.times = 5,
    this.ipv4Url = 'https://v4.ident.me',
    this.ipv6Url = 'https://v6.ident.me',
    this.goDaddy,
  });

  factory DDNSHubConfig.fromJSON(Map<String, dynamic> json) {
    final args = DDNSHubConfigArgs.fromJson(json);
    return DDNSHubConfig.fromArgs(args);
  }

  factory DDNSHubConfig.fromArgs(DDNSHubConfigArgs args) {
    final goDaddyArgs = args.goDaddyArgs;
    return DDNSHubConfig(
      duration: args.durationArgs,
      times: args.timesArgs,
      ipv4Url: args.ipv4UrlArgs,
      ipv6Url: args.ipv6UrlArgs,
      goDaddy: goDaddyArgs == null ? null : GoDaddyConfig.fromArgs(goDaddyArgs),
    );
  }

  Map<String, dynamic> toJSON() {
    final args = toArgs();
    return args.toJson();
  }

  DDNSHubConfigArgs toArgs() {
    return DDNSHubConfigArgs(
      durationArgs: duration,
      timesArgs: times,
      ipv4UrlArgs: ipv4Url,
      ipv6UrlArgs: ipv6Url,
      goDaddyArgs: goDaddy?.toArgs(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DDNSHubConfigArgs {
  @JsonKey(name: 'duration')
  final int durationArgs;
  @JsonKey(name: 'times')
  final int timesArgs;
  @JsonKey(name: 'ipv4Url')
  final String? ipv4UrlArgs;
  @JsonKey(name: 'ipv6Url')
  final String? ipv6UrlArgs;
  @JsonKey(name: 'goDaddy')
  final GoDaddyConfigArgs? goDaddyArgs;

  DDNSHubConfigArgs({
    required this.durationArgs,
    required this.timesArgs,
    this.ipv4UrlArgs,
    this.ipv6UrlArgs,
    this.goDaddyArgs,
  });

  factory DDNSHubConfigArgs.fromJson(Map<String, dynamic> json) =>
      _$DDNSHubConfigArgsFromJson(json);

  Map<String, dynamic> toJson() => _$DDNSHubConfigArgsToJson(this);
}
