import 'package:json_annotation/json_annotation.dart';

part 'ddns_record_config.g.dart';

class DDNSRecordConfig {
  final String name;
  final List<String> types;

  DDNSRecordConfig({
    required this.name,
    required this.types,
  });

  factory DDNSRecordConfig.fromJSON(Map<String, dynamic> json) {
    final args = DDNSRecordConfigArgs.fromJson(json);
    return DDNSRecordConfig.formArgs(args);
  }

  factory DDNSRecordConfig.formArgs(DDNSRecordConfigArgs args) {
    return DDNSRecordConfig(
      name: args.nameArgs,
      types: args.typesArgs,
    );
  }

  Map<String, dynamic> toJSON() {
    final args = toArgs();
    return args.toJson();
  }

  DDNSRecordConfigArgs toArgs() {
    return DDNSRecordConfigArgs(
      nameArgs: name,
      typesArgs: types,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DDNSRecordConfigArgs {
  @JsonKey(name: 'name')
  final String nameArgs;
  @JsonKey(name: 'types')
  final List<String> typesArgs;

  DDNSRecordConfigArgs({
    required this.nameArgs,
    required this.typesArgs,
  });

  factory DDNSRecordConfigArgs.fromJson(Map<String, dynamic> json) =>
      _$DDNSRecordConfigArgsFromJson(json);

  Map<String, dynamic> toJson() => _$DDNSRecordConfigArgsToJson(this);
}
