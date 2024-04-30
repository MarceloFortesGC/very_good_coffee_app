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

  final _controller = PageController();

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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<ImagesProvider>(
        builder: (context, provider, child) {
          return _firstLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: provider.images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Center(
                            child: ImageWithLoader(
                              image: provider.images[index],
                            ),
                          ),
                          Positioned(
                            bottom: 32,
                            right: 16,
                            child: TextButton.icon(
                              onPressed: () {
                                provider
                                    .toggleLikedImage(provider.images[index]);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFA26334),
                                foregroundColor: Colors.white,
                              ),
                              icon: Icon(Icons.favorite_border),
                              label: const Text("Save"),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
