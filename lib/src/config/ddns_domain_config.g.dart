// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ddns_domain_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDNSDomainConfigArgs _$DDNSDomainConfigArgsFromJson(
        Map<String, dynamic> json) =>
    DDNSDomainConfigArgs(
      nameArgs: json['name'] as String,
      recordsArgs: (json['records'] as List<dynamic>)
          .map((e) => DDNSRecordConfigArgs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DDNSDomainConfigArgsToJson(
        DDNSDomainConfigArgs instance) =>
    <String, dynamic>{
      'name': instance.nameArgs,
      'records': instance.recordsArgs,
    };
