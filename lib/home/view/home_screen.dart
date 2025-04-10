import 'package:bronze_mirror/common/const/message.dart';
import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pie_menu/pie_menu.dart';
import '../component/feed_card.dart';
import '../provider/feed_images_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // ✅ 진입 시마다 새로운 데이터 요청 (캐시가 있더라도)
    Future.microtask(() {
      ref.read(feedImagesProvider.notifier).fetchImages(page: 0);
    });
  }

  void _onScroll() {
    final state = ref.read(feedImagesProvider);
    if (state is FeedImagesData &&
        !state.isLast &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
      ref.read(feedImagesProvider.notifier).fetchImages(page: state.page + 1);
    }
  }

  Future<void> onRefresh() async {
    await ref.read(feedImagesProvider.notifier).fetchImages(page: 0);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedImagesProvider);

    return DefaultLayout(
      child: PieCanvas(
        theme: const PieTheme(
          delayDuration: Duration.zero,
          rightClickShowsMenu: false,
          leftClickShowsMenu: true,
          pointerSize: 0,
          pointerColor: Colors.transparent,
          pointerDecoration: null,
          overlayColor: Colors.transparent,
        ),
        child: LiquidPullToRefresh(
          onRefresh: onRefresh,
          animSpeedFactor: 5,
          showChildOpacityTransition: false,
          backgroundColor: WHITE,
          color: Colors.grey[300],
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: state is FeedImagesData ? state.images.length : 10,
            itemBuilder: (context, index) {
              if (state is FeedImagesLoading) {
                return FeedCardLoading();
              } else if (state is FeedImagesData) {
                final image = state.images[index];
                return Column(children: [FeedCard(image: image)]);
              } else if (state is FeedImagesError) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ErrorScreen(message: SERVER_ERROR)));
                return SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
