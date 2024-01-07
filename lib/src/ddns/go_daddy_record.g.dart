// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_daddy_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoDaddyRecordArgs _$GoDaddyRecordArgsFromJson(Map<String, dynamic> json) =>
    GoDaddyRecordArgs(
      dataArgs: json['data'] as String,
      nameArgs: json['name'] as String,
      portArgs: json['port'] as int?,
      priorityArgs: json['priority'] as int?,
      protocolArgs: json['protocol'] as String?,
      serviceArgs: json['service'] as String?,
      ttlArgs: json['ttl'] as int?,
      typeArgs: json['type'] as String,
      weightArgs: json['weight'] as int?,
    );

Map<String, dynamic> _$GoDaddyRecordArgsToJson(GoDaddyRecordArgs instance) {
  final val = <String, dynamic>{
    'data': instance.dataArgs,
    'name': instance.nameArgs,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('port', instance.portArgs);
  writeNotNull('priority', instance.priorityArgs);
  writeNotNull('protocol', instance.protocolArgs);
  writeNotNull('service', instance.serviceArgs);
  writeNotNull('ttl', instance.ttlArgs);
  val['type'] = instance.typeArgs;
  writeNotNull('weight', instance.weightArgs);
  return val;
}
