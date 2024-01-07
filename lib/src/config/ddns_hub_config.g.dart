// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ddns_hub_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDNSHubConfigArgs _$DDNSHubConfigArgsFromJson(Map<String, dynamic> json) =>
    DDNSHubConfigArgs(
      durationArgs: json['duration'] as int,
      timesArgs: json['times'] as int,
      ipv4UrlArgs: json['ipv4Url'] as String?,
      ipv6UrlArgs: json['ipv6Url'] as String?,
      goDaddyArgs: json['goDaddy'] == null
          ? null
          : GoDaddyConfigArgs.fromJson(json['goDaddy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DDNSHubConfigArgsToJson(DDNSHubConfigArgs instance) {
  final val = <String, dynamic>{
    'duration': instance.durationArgs,
    'times': instance.timesArgs,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ipv4Url', instance.ipv4UrlArgs);
  writeNotNull('ipv6Url', instance.ipv6UrlArgs);
  writeNotNull('goDaddy', instance.goDaddyArgs);
  return val;
}
