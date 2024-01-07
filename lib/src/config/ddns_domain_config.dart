import 'package:json_annotation/json_annotation.dart';

import 'ddns_record_config.dart';

part 'ddns_domain_config.g.dart';

class DDNSDomainConfig {
  final String name;
  final List<DDNSRecordConfig> records;

  DDNSDomainConfig({
    required this.name,
    required this.records,
  });

  factory DDNSDomainConfig.fromJSON(Map<String, dynamic> json) {
    final args = DDNSDomainConfigArgs.fromJson(json);
    return DDNSDomainConfig.fromArgs(args);
  }

  factory DDNSDomainConfig.fromArgs(DDNSDomainConfigArgs args) {
    return DDNSDomainConfig(
      name: args.nameArgs,
      records: args.recordsArgs
          .map((recordArgs) => DDNSRecordConfig.formArgs(recordArgs))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    final args = toArgs();
    return args.toJson();
  }

  DDNSDomainConfigArgs toArgs() {
    return DDNSDomainConfigArgs(
      nameArgs: name,
      recordsArgs: records.map((record) => record.toArgs()).toList(),
    );
  }
}

@JsonSerializable(includeIfNull: false)
class DDNSDomainConfigArgs {
  @JsonKey(name: 'name')
  final String nameArgs;
  @JsonKey(name: 'records')
  final List<DDNSRecordConfigArgs> recordsArgs;

  DDNSDomainConfigArgs({
    required this.nameArgs,
    required this.recordsArgs,
  });

  factory DDNSDomainConfigArgs.fromJson(Map<String, dynamic> json) =>
      _$DDNSDomainConfigArgsFromJson(json);

  Map<String, dynamic> toJson() => _$DDNSDomainConfigArgsToJson(this);
}
