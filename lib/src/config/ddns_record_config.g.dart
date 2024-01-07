// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ddns_record_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DDNSRecordConfigArgs _$DDNSRecordConfigArgsFromJson(
        Map<String, dynamic> json) =>
    DDNSRecordConfigArgs(
      nameArgs: json['name'] as String,
      typesArgs:
          (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DDNSRecordConfigArgsToJson(
        DDNSRecordConfigArgs instance) =>
    <String, dynamic>{
      'name': instance.nameArgs,
      'types': instance.typesArgs,
    };
