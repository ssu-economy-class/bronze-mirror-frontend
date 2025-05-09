import 'package:bronze_mirror/common/layout/blur_background.dart';
import 'package:bronze_mirror/common/layout/default_layout.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/user/component/custom_avatar.dart';
import 'package:bronze_mirror/user/provider/userInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../common/api/firebase_analytics.dart';
import '../layout/grid_gallery.dart';
import '../provider/user_images_provider.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    logScreenView(name: 'UserScreen');
    // 처음 진입 시 자동 API 요청
    Future.microtask(() async {
      await ref.read(userInfoStateProvider.notifier).getUserInfo();
      await ref.read(userImagesProvider.notifier).getImages();
    });
  }

  Future<void> onRefresh() async {
    await ref.read(userInfoStateProvider.notifier).getUserInfo();
    await ref.read(userImagesProvider.notifier).getImages();
    logEvent(name: '리프레쉬', parameters: {'screen': 'user'});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: WHITE,
      child: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: onRefresh,
        animSpeedFactor: 5,
        showChildOpacityTransition: false,
        backgroundColor: WHITE,
        color:  Colors.grey[300],
        child: Stack(
          children: [
            const BlurPrimary(
              width: 100,
              height: 100,
              alignment: Alignment(-1.0, -0.6),
            ),
            CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: const [
                        SizedBox(height: 40),
                        _Profile(),
                        SizedBox(height: 16),
                        _Nickname(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(),
                ),
                const _Feeds(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Profile extends ConsumerWidget {
  const _Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoStateProvider);
    const double r = 48;

    return userInfo.when(
      data:
          (user) =>
              user == null
                  ? const SizedBox()
                  : CustomAvatar(r: r, imgUrl: user.profileImage),
      loading: () => const CustomAvatarLoading(r: r),
      error: (e, _) => const CustomAvatar(r: r, imgUrl: null),
    );
  }
}

class _Nickname extends ConsumerWidget {
  const _Nickname({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoStateProvider);
    final defaultTextStyle = SUB_TITLE_19.copyWith(color: Colors.black);

    return userInfo.when(
      data:
          (user) =>
              user == null
                  ? const SizedBox()
                  : Text(user.nickname, style: defaultTextStyle),
      loading:
          () =>
              SkeletonAvatar(style: SkeletonAvatarStyle(width: 64, height: 19)),
      error: (e, _) => Text('서버 에러', style: defaultTextStyle),
    );
  }
}

class _Feeds extends ConsumerWidget {
  const _Feeds({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(userImagesProvider);

    if (imageState is UserImagesLoading) {
      return GridGalleryLoading();
    } else if (imageState is UserImagesError) {
      return const SliverToBoxAdapter(child: SizedBox());
    } else if (imageState is UserImagesData) {
      return GridGallery(imgs: imageState.images);
    } else {
      return const SliverToBoxAdapter(child: SizedBox());
    }
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _StickyHeaderDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        final imageState = ref.watch(userImagesProvider);

        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.black.withAlpha(10),
                width: 1.0, // 1px
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (imageState is UserImagesLoading)
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(width: 19, height: 19),
                ),
              if (imageState is UserImagesError)
                Text('서버 에러', style: SUB_TITLE_19),
              if (imageState is UserImagesData)
                Text(
                  imageState.imageCount.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              SizedBox(width: 6),
              Text('체험', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
