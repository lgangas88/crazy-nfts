import 'package:crazy_nfts/domain/models/contract_metadata.dart';

class Contract {
  Contract({
    this.name,
    this.symbol,
    this.type,
    this.metadata,
  });

  String? name;
  String? symbol;
  String? type;
  ContractMetadata? metadata;

  factory Contract.fromJson(dynamic json) => Contract(
        name: json["name"],
        symbol: json["symbol"],
        type: json["type"],
        metadata: json["metadata"] != null
            ? ContractMetadata.fromJson(json["metadata"])
            : null,
      );
}
