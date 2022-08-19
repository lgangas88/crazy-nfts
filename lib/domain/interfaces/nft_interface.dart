import 'package:crazy_nfts/domain/models/requests/nft_requests.dart';
import 'package:crazy_nfts/domain/models/responses/nft_responses.dart';

abstract class NFTInterface {
  Future<GetNFTListResponse> getNFTList(GetNFTListRequest getNFTListRequest);
}