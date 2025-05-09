import 'package:bronze_mirror/common/repository/image_delete_repository.dart';
import 'package:bronze_mirror/user/provider/user_images_provider.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_menu/pie_menu.dart';

import '../style/design_system.dart';
import '../../onboarding/utils/date.dart';
import '../../user/component/custom_avatar.dart';
import '../../home/model/feed_images_model.dart';
import '../../home/provider/feed_images_provider.dart';
import '../../home/utils/image.dart';
import '../../home/component/custom_pie.dart';

/// Home과 User Screen에서 사용되는 카드 컴포넌트입니다. 사진, 생성 날짜, 사용자 프로필 정보 등이 담겨 있습니다.
class FeedCard extends StatelessWidget {
  final FeedImage image;
  final bool wide;

  const FeedCard({required this.image, this.wide = false, super.key});

  @override
  Widget build(BuildContext context) {
    if(wide){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0XFF7CC2AC).withAlpha(30),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                offset: Offset(0, 4), // x=0, y=4
                blurRadius: 10, // blur
                spreadRadius: 0, // spread
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    width: 300,
                    image.url,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Positioned(child: _Profile(image: image)),
                      Positioned(right: 4, child: _CustomPie(image: image)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        width: 320,
        height: 380,
        decoration: BoxDecoration(
          color: Color(0XFFD1E7E1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              offset: Offset(0, 4), // x=0, y=4
              blurRadius: 10, // blur
              spreadRadius: 0, // spread
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: image.url,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    height: 280,
                    width: 296,
                    image.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Positioned(child: _Profile(image: image)),
                    Positioned(right: 4, child: _CustomPie(image: image)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 카드 컴포넌트 내 프로필
class _Profile extends StatelessWidget {
  final FeedImage image;

  const _Profile({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(r: 24, imgUrl: image.profileImage),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              image.nickname,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Text(
              DateUtils.getFormattedDate(image.date.toIso8601String()),
              style: TextStyle(fontSize: 12.0, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}

class _CustomPie extends ConsumerWidget {
  final FeedImage image;

  const _CustomPie({required this.image, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return PieMenu(
      actions: [
        customPieAction(
          icon: const Icon(Icons.delete),
          onPressed: () async{
            await ref.watch(ImageDeleteRepositoryProvider).deleteImage(image.id.toString());
            await ref.read(feedImagesProvider.notifier).fetchImages(page: 0);
            await ref.read(userImagesProvider.notifier).getImages();
          },
        ),
        customPieAction(
          icon: const Icon(Icons.share),
          onPressed: () => shareImage(image.url),
        ),
        customPieAction(
          icon: const Icon(Icons.download_rounded),
          onPressed: () => downloadAndSaveImage(context, image.url),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: SvgPicture.asset(
          'assets/icon/list.svg',
          height: 20.0,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ),
    );
  }
}

// 피드 카드 로딩 스켈레톤 컴포넌트
class FeedCardLoading extends StatelessWidget {
  const FeedCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                borderRadius: BorderRadius.circular(4),
                width: double.infinity,
                height: 240,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                    width: 48,
                    height: 48,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                      lines: 2,
                      spacing: 6,
                      lineStyle: SkeletonLineStyle(
                        height: 12,
                        borderRadius: BorderRadius.circular(8),
                        minLength: MediaQuery.of(context).size.width / 8,
                        maxLength: MediaQuery.of(context).size.width / 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
