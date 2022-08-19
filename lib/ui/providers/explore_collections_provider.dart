import 'package:crazy_nfts/domain/interfaces/nft_interface.dart';
import 'package:crazy_nfts/domain/models/nft.dart';
import 'package:crazy_nfts/domain/models/requests/nft_requests.dart';
import 'package:flutter/material.dart';

class ExploreCollectionsProvider extends ChangeNotifier {
  final NFTInterface nftService;

  ExploreCollectionsProvider({
    required this.nftService,
  });

  List<NFT>? nftList;
  String? nextList;

  void loadData() async {
    try {
      final response = await nftService.getNFTList(
        GetNFTListRequest(
          continuation: nextList,
        ),
      );
      if (nftList == null) {
        nftList = response.nfts;
      } else {
        nftList!.addAll(response.nfts);
      }
      nextList = response.continuation;
      notifyListeners();
    } catch (e) {
      print('Error $e');
    }
  }
}
