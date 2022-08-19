import 'package:crazy_nfts/domain/interfaces/nft_interface.dart';
import 'package:crazy_nfts/domain/models/requests/nft_requests.dart';
import 'package:crazy_nfts/domain/models/responses/nft_responses.dart';
import 'package:crazy_nfts/environment.dart';
import 'package:dio/dio.dart';

class NFTService implements NFTInterface {
  @override
  Future<GetNFTListResponse> getNFTList(
      GetNFTListRequest getNFTListRequest) async {
    const url = '${Environment.baseUrl}${Environment.nfts}';

    const Map<String, dynamic> headers = {
      'Authorization': Environment.nftPortAPI,
    };

    final response = await Dio().get(
      url,
      queryParameters: getNFTListRequest.queryParams(),
      options: Options(headers: headers),
    );

    print(response.data);

    return GetNFTListResponse.fromJson(response.data);
  }
}
