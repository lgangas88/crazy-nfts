import 'dart:convert';

import 'package:crazy_nfts/domain/models/contract.dart';
import 'package:crazy_nfts/domain/models/file_information.dart';
import 'package:crazy_nfts/domain/models/nft_metadata.dart';

NFT nftFromJson(String str) => NFT.fromJson(json.decode(str));

class NFT {
  NFT({
    this.chain,
    this.contractAddress,
    this.tokenId,
    this.contract,
    this.metadata,
    this.metadataUrl,
    this.fileUrl,
    this.animationUrl,
    this.cachedFileUrl,
    this.cachedAnimationUrl,
    this.mintDate,
    this.fileInformation,
    this.updatedDate,
  });

  String? contractAddress;
  String? chain;
  String? tokenId;
  Contract? contract;
  NFTMetadata? metadata;
  String? metadataUrl;
  String? fileUrl;
  String? animationUrl;
  String? cachedFileUrl;
  String? cachedAnimationUrl;
  DateTime? mintDate;
  FileInformation? fileInformation;
  DateTime? updatedDate;

  factory NFT.fromJson(dynamic json) => NFT(
        chain: json["chain"],
        contractAddress: json["contract_address"],
        tokenId: json["token_id"],
        contract: json["contract"] != null
            ? Contract.fromJson(json["contract"])
            : null,
        metadata: json["metadata"] != null
            ? NFTMetadata.fromJson(json["metadata"])
            : null,
        metadataUrl: json["metadata_url"],
        fileUrl: json["file_url"],
        animationUrl: json["animation_url"],
        cachedFileUrl: json["cached_file_url"],
        cachedAnimationUrl: json["cached_animation_url"],
        mintDate: json["mint_date"] != null
            ? DateTime.parse(json["mint_date"])
            : null,
        fileInformation: json["file_information"] != null
            ? FileInformation.fromJson(json["file_information"])
            : null,
        updatedDate: json["updated_date"] != null
            ? DateTime.parse(json["updated_date"])
            : null,
      );
}
