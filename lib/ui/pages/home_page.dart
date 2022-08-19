import 'package:crazy_nfts/ui/components/custom_bottom_navigation_bar.dart';
import 'package:crazy_nfts/ui/pages/explore_collections_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: indexPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            indexPage = index;
          });
        },
        children: [
          ExploreCollectionsPage.create(),
          Material(
            color: Colors.red,
          ),
          Material(
            color: Colors.green,
          ),
          Material(
            color: Colors.blue,
          ),
          Material(
            color: Colors.yellow,
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemPressed: (index) {
          setState(() {
            indexPage = index;
            _pageController.jumpToPage(index);
          });
        },
        selectedIndex: indexPage,
      ),
    );
  }
}
