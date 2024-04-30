import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:very_good_coffee_app/features/shared/custom_colors.dart';
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

  void _getLikedImages() async {
    Provider.of<ImagesProvider>(context, listen: false).getLikedImagesOffline();
  }

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
    _getLikedImages();
    super.initState();
    _scrollController.addListener(_onScroll);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImagesProvider>();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _firstLoading
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
                        child: ImageWithLoader(image: provider.images[index]),
                      ),
                      Positioned(
                        bottom: 32,
                        right: 16,
                        child: TextButton.icon(
                          onPressed: () {
                            provider.toggleLikedImage(provider.images[index]);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: CustomColors.secondaryColor,
                            foregroundColor: Colors.white,
                          ),
                          icon: Icon(
                            provider.isLiked(provider.images[index])
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: const Text("Save"),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
    );
  }
}
