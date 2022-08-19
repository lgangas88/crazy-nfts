import 'package:crazy_nfts/data/api-services/nft_service.dart';
import 'package:crazy_nfts/domain/interfaces/nft_interface.dart';
import 'package:crazy_nfts/ui/pages/home_page.dart';
import 'package:crazy_nfts/ui/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const MyApp());
}

final List<SingleChildWidget> providers = [
  Provider<NFTInterface>(
    create: (context) => NFTService(),
  ),
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Crazy NFTs',
            theme: themeProvider.isDark
                ? ThemeData.dark().copyWith(
                    textTheme:
                        Typography.whiteCupertino.apply(fontFamily: 'Poppins'))
                : ThemeData.light().copyWith(
                    textTheme:
                        Typography.blackCupertino.apply(fontFamily: 'Poppins')),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
