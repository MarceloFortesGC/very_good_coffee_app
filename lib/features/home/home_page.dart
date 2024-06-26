import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/home/home_loader.dart';
import 'package:very_good_coffee_app/features/home/home_offline.dart';
import 'package:very_good_coffee_app/features/home/home_online.dart';
import 'package:very_good_coffee_app/features/home/home_service.dart';
import 'package:very_good_coffee_app/features/providers/connection_provider.dart';
import 'package:very_good_coffee_app/features/providers/images_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = HomeService();
  bool _firstLoading = true;

  void _getLikedImages() async {
    Provider.of<ImagesProvider>(context, listen: false).getLikedImagesOffline();
  }

  void _precacheImages(List<String> imageUrls) {
    for (String url in imageUrls) {
      precacheImage(NetworkImage(url), context);
    }
  }

  Future<void> _getData() async {
    final imgProvider = Provider.of<ImagesProvider>(context, listen: false);
    final connectionProvider =
        Provider.of<ConnectionProvider>(context, listen: false);

    if (imgProvider.images.isEmpty) {
      _firstLoading = true;
      setState(() {});
    }

    try {
      await _service.getListImageHomePage().then((value) {
        connectionProvider.setHasConnection = true;
        _firstLoading = false;
        imgProvider.addImages(value);
        _precacheImages(value);
        setState(() {});
      });
    } catch (e) {
      connectionProvider.setHasConnection = false;
      _firstLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    _getLikedImages();
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('onlineOrOfflineWrapper'),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _firstLoading
          ? const HomeLoader()
          : context.watch<ConnectionProvider>().getHasConnection
              ? HomeOnline(
                  key: const Key('homeOnline'),
                  loadData: () => _getData(),
                )
              : HomeOffline(
                  key: const Key('homeOffline'),
                  onTapTryAgain: _getData,
                  loading: _firstLoading,
                ),
    );
  }
}
