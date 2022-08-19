import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crazy_nfts/domain/interfaces/nft_interface.dart';
import 'package:crazy_nfts/domain/models/nft.dart';
import 'package:crazy_nfts/theme.dart';
import 'package:crazy_nfts/ui/components/circle_crypto.dart';
import 'package:crazy_nfts/ui/components/custom_bottom_navigation_bar.dart';
import 'package:crazy_nfts/ui/components/custom_circular_progress_indicator.dart';
import 'package:crazy_nfts/ui/components/mirrow_style.dart';
import 'package:crazy_nfts/ui/pages/nft_detail_page.dart';
import 'package:crazy_nfts/ui/providers/explore_collections_provider.dart';
import 'package:crazy_nfts/ui/providers/theme_provider.dart';
import 'package:crazy_nfts/utils/constants.dart';
import 'package:crazy_nfts/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TabInfo {
  final String text;
  final VoidCallback callback;

  TabInfo(this.text, this.callback);
}

final List<TabInfo> customTabs = [
  TabInfo('Recent', () {}),
  TabInfo('Tranding', () {}),
  TabInfo('Top', () {}),
  TabInfo('Art', () {}),
  TabInfo('Fashion', () {}),
];

class ExploreCollectionsPage extends StatelessWidget {
  const ExploreCollectionsPage._({Key? key}) : super(key: key);

  static Widget create({Key? key}) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => ExploreCollectionsProvider(
        nftService: context.read<NFTInterface>(),
      )..loadData(),
      child: ExploreCollectionsPage._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: customTabs.length,
      child: CustomScrollView(
        slivers: [
          const _CustomSliverAppBar(),
          Consumer<ExploreCollectionsProvider>(
            builder: (context, bloc, _) => bloc.nftList == null
                ? const SliverFillRemaining(
                    child: Center(
                      child: CustomCircularProgressIndicator(),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16).copyWith(bottom: 100),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final nft = bloc.nftList![index];
                          if (index >= bloc.nftList!.length - 2) {
                            bloc.loadData();
                          }

                          return _NFTCard(nft: nft);
                        },
                        childCount: bloc.nftList!.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _NFTCard extends StatefulWidget {
  const _NFTCard({
    Key? key,
    required this.nft,
  }) : super(key: key);

  final NFT nft;

  @override
  State<_NFTCard> createState() => _NFTCardState();
}

class _NFTCardState extends State<_NFTCard> {
  VideoPlayerController? _videoController;

  late String? _backgroundUrl;

  @override
  void initState() {
    super.initState();
    _backgroundUrl =
        widget.nft.cachedFileUrl ?? widget.nft.cachedAnimationUrl ?? '';

    if (_backgroundUrl != null && isUrlVideo(_backgroundUrl!)) {
      _videoController = VideoPlayerController.network(
        _backgroundUrl!,
      )..initialize()
          .then((value) {
            setState(() => {});
            return _videoController!.play();
          })
          .then((value) => _videoController!.setVolume(0))
          .then((value) => _videoController!.setLooping(true));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget backgroundCard;

    if (_backgroundUrl != null && _backgroundUrl!.isNotEmpty) {
      if (_videoController != null) {
        backgroundCard = _videoController!.value.isInitialized
            ? VideoPlayer(_videoController!)
            : const Center(
                child: CustomCircularProgressIndicator(),
              );
      } else {
        backgroundCard = CachedNetworkImage(
          imageUrl: _backgroundUrl!,
          fit: BoxFit.cover,
          placeholder: (_, __) => const Center(
            child: CustomCircularProgressIndicator(),
          ),
          errorWidget: (_, __, ___) =>
              Image.asset('assets/images/placeholder-image.png'),
        );
      }
    } else {
      backgroundCard = Image.asset('assets/images/placeholder-image.png');
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => NFTDetailPage(
                  nft: widget.nft,
                  background: backgroundCard,
                )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned.fill(
              child: Hero(
                tag: '${widget.nft.contractAddress}-${widget.nft.tokenId}',
                child: backgroundCard,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleCrypto(
                iconData: cryptoIcon[widget.nft.chain]!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  const _CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        expandedTitleScale: 1,
        collapseMode: CollapseMode.pin,
        titlePadding: EdgeInsets.zero,
        background: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore \nCollections',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
              ),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) => IconButton(
                  onPressed: themeProvider.changeTheme,
                  icon: themeProvider.isDark
                      ? const Icon(Icons.light_mode_outlined)
                      : const Icon(Icons.dark_mode_outlined),
                ),
              ),
            ],
          ),
        ),
        title: TabBar(
          isScrollable: true,
          indicatorColor: CustomColors.salmon,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w700),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          tabs: [
            for (final info in customTabs)
              Tab(
                child: Text(
                  info.text,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
