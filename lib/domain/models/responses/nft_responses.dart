import 'package:crazy_nfts/domain/models/nft.dart';

class GetNFTListResponse {
  final String response;
  final List<NFT> nfts;
  final String continuation;

  GetNFTListResponse({
    required this.response,
    required this.nfts,
    required this.continuation,
  });

  factory GetNFTListResponse.fromJson(dynamic data) {
    return GetNFTListResponse(
      response: data['response'],
      nfts: data['nfts'] != null
          ? List<NFT>.from(data['nfts'].map((e) => NFT.fromJson(e)))
          : [],
      continuation: data['continuation'],
    );
  }
}
