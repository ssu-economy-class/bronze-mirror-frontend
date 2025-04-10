import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/user/provider/userInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../home/component/feed_card.dart';
import '../../home/model/feed_images_model.dart';
import '../model/user_images_model.dart';

class GridGallery extends ConsumerWidget {
  final List<UserImage> imgs;

  const GridGallery({required this.imgs, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoState = ref.watch(userInfoStateProvider);

    return userInfoState.when(
      data: (userInfo) {
        if (userInfo == null) return const SliverToBoxAdapter(child: SizedBox());

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final image = imgs[index];

              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(dialogContext).pop(); // 다이얼로그 닫기
                        },
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
                          child: Center(
                            child: FeedCard(
                              image: FeedImage(
                                url: image.imageUrl,
                                profileImage: userInfo.profileImage,
                                nickname: userInfo.nickname,
                                date: image.date,
                                id: 0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        offset: const Offset(2, 2),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(image.imageUrl, fit: BoxFit.cover),
                  ),
                ),
              );
            }, childCount: imgs.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (err, st) => SliverToBoxAdapter(child: Text("유저 정보를 불러올 수 없습니다")),
    );
  }
}

class GridGalleryLoading extends StatelessWidget {
  const GridGalleryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: double.infinity,
              height: double.infinity,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          childCount: 6,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
      ),
    );
  }
}
