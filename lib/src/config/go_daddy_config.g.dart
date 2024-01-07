// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_daddy_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoDaddyConfigArgs _$GoDaddyConfigArgsFromJson(Map<String, dynamic> json) =>
    GoDaddyConfigArgs(
      keyArgs: json['key'] as String,
      secretArgs: json['secret'] as String,
      domainsArgs: (json['domains'] as List<dynamic>)
          .map((e) => DDNSDomainConfigArgs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoDaddyConfigArgsToJson(GoDaddyConfigArgs instance) =>
    <String, dynamic>{
      'key': instance.keyArgs,
      'secret': instance.secretArgs,
      'domains': instance.domainsArgs,
    };
