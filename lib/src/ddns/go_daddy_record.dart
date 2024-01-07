import 'package:json_annotation/json_annotation.dart';

part 'go_daddy_record.g.dart';

class GoDaddyRecord {
  final String data;
  final String name;
  final int? port;
  final int? priority;
  final String? protocol;
  final String? service;
  final int? ttl;
  final String type;
  final int? weight;

  GoDaddyRecord({
    required this.data,
    required this.name,
    this.port,
    this.priority,
    this.protocol,
    this.service,
    this.ttl,
    required this.type,
    this.weight,
  });

  factory GoDaddyRecord.fromJSON(Map<String, dynamic> json) {
    final args = GoDaddyRecordArgs.fromJson(json);
    return GoDaddyRecord.fromArgs(args);
  }

  factory GoDaddyRecord.fromArgs(GoDaddyRecordArgs args) {
    return GoDaddyRecord(
      data: args.dataArgs,
      name: args.nameArgs,
      port: args.portArgs,
      priority: args.priorityArgs,
      protocol: args.protocolArgs,
      service: args.serviceArgs,
      ttl: args.ttlArgs,
      type: args.typeArgs,
      weight: args.weightArgs,
    );
  }

  Map<String, dynamic> toJSON() {
    final args = toArgs();
    return args.toJson();
  }

  GoDaddyRecordArgs toArgs() {
    return GoDaddyRecordArgs(
      dataArgs: data,
      nameArgs: name,
      portArgs: port,
      priorityArgs: priority,
      protocolArgs: protocol,
      serviceArgs: service,
      ttlArgs: ttl,
      typeArgs: type,
      weightArgs: weight,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class GoDaddyRecordArgs {
  @JsonKey(name: 'data')
  final String dataArgs;
  @JsonKey(name: 'name')
  final String nameArgs;
  @JsonKey(name: 'port')
  final int? portArgs;
  @JsonKey(name: 'priority')
  final int? priorityArgs;
  @JsonKey(name: 'protocol')
  final String? protocolArgs;
  @JsonKey(name: 'service')
  final String? serviceArgs;
  @JsonKey(name: 'ttl')
  final int? ttlArgs;
  @JsonKey(name: 'type')
  final String typeArgs;
  @JsonKey(name: 'weight')
  final int? weightArgs;

  GoDaddyRecordArgs({
    required this.dataArgs,
    required this.nameArgs,
    this.portArgs,
    this.priorityArgs,
    this.protocolArgs,
    this.serviceArgs,
    this.ttlArgs,
    required this.typeArgs,
    this.weightArgs,
  });

  factory GoDaddyRecordArgs.fromJson(Map<String, dynamic> json) =>
      _$GoDaddyRecordArgsFromJson(json);

  Map<String, dynamic> toJson() => _$GoDaddyRecordArgsToJson(this);
}
