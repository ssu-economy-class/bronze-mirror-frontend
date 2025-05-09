import 'package:bronze_mirror/common/const/message.dart';
import 'package:bronze_mirror/common/layout/blur_background.dart';
import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pie_menu/pie_menu.dart';
import '../../common/api/firebase_analytics.dart';
import '../../common/component/feed_card.dart';
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

    logScreenView(name: 'HomeScreen');

    // ✅ fetchImages는 Provider가 생성되며 호출되므로 생략 가능
    // ✅ ScrollListener 제거
  }

  Future<void> onRefresh() async {
    await ref.read(feedImagesProvider.notifier).fetchImages(page: 0);
    logEvent(
      name: '리프레쉬',
      parameters: {
        'screen': 'home',
      },
    );
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
          child: BlurBackgroundThird(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: state is FeedImagesData ? state.images.length : 10,
              itemBuilder: (context, index) {
                if (state is FeedImagesLoading) {
                  return const FeedCardLoading();
                } else if (state is FeedImagesData) {
                  final image = state.images[index];
            
                  // ✅ 마지막에서 두 번째 카드가 보일 때 다음 페이지 요청
                  if (index == state.images.length - 2 && !state.isLast) {
                    ref
                        .read(feedImagesProvider.notifier)
                        .fetchImages(page: state.page + 1);
                  }
            
                  return Column(children: [FeedCard(image: image, wide: true)]);
                } else if (state is FeedImagesError) {
                  // ✅ push는 build 안에서 직접 호출하지 않도록 안전 처리
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ErrorScreen(message: SERVER_ERROR),
                      ),
                    );
                  });
                  return const SizedBox.shrink();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
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
