import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/image_with_loader.dart';
import 'package:very_good_coffee_app/features/home/home_service.dart';
import 'package:very_good_coffee_app/features/shared/images_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = HomeService();
  final _scrollController = ScrollController();
  bool _firstLoading = true;
  bool _loading = true;

  Future<void> _getData() async {
    setState(() => _loading = true);
    await _service.getListImageHomePage().then((value) {
      _firstLoading = false;
      _loading = false;
      Provider.of<ImagesProvider>(context, listen: false).addImages(value);
      setState(() {});
    });
  }

  void _onScroll() async {
    if (!_loading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      setState(() {
        _loading = true;
      });

      await _getData().then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: const Text("Very Good Coffee App")),
        body: Consumer<ImagesProvider>(builder: (context, provider, child) {
          return _firstLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ImageWithLoader(image: provider.images[index]);
                        },
                        childCount: provider.images.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _loading
                          ? Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            )
                          : const SizedBox(),
                    ),
                  ],
                );
        }));
  }
}
