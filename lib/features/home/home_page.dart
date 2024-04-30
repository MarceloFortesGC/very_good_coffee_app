import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/home/home_offline.dart';
import 'package:very_good_coffee_app/features/home/home_online.dart';
import 'package:very_good_coffee_app/features/home/home_service.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = HomeService();
  bool _firstLoading = true;
  bool _hasConnection = true;

  void _getLikedImages() async {
    Provider.of<ImagesProvider>(context, listen: false).getLikedImagesOffline();
  }

  Future<void> _getData() async {
    final provider = Provider.of<ImagesProvider>(context, listen: false);

    if (provider.images.isEmpty) {
      _firstLoading = true;
      setState(() {});
    }

    try {
      await _service.getListImageHomePage().then((value) {
        _hasConnection = true;
        _firstLoading = false;
        provider.addImages(value);
        setState(() {});
      });
    } catch (e) {
      _hasConnection = false;
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
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _firstLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasConnection
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: HomeOnline(),
                )
              : HomeOffline(
                  onTapTryAgain: _getData,
                  loading: _firstLoading,
                ),
    );
  }
}
