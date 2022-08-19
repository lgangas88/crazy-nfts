import 'package:crazy_nfts/domain/models/nft.dart';
import 'package:flutter/material.dart';

class NFTDetailPage extends StatelessWidget {
  final NFT nft;
  final Widget background;

  const NFTDetailPage({
    super.key,
    required this.nft,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: '${nft.contractAddress}-${nft.tokenId}',
              child: background,
            ),
          ),
        ],
      ),
    );
  }
}
