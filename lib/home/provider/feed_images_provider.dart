import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/feed_images_model.dart';
import '../repository/feed_images_repository.dart';

final feedImagesProvider = StateNotifierProvider<FeedImagesNotifier, FeedImagesState>((ref) {
  final repo = ref.watch(feedImagesRepositoryProvider);
  return FeedImagesNotifier(repository: repo);
});

class FeedImagesNotifier extends StateNotifier<FeedImagesState> {
  final FeedImagesRepository repository;

  FeedImagesNotifier({required this.repository}) : super(FeedImagesState.loading()) {
    fetchImages(); // 앱 처음 시작 시 요청
  }

  // ✅ 기존 데이터 유지 + API 재요청
  Future<void> fetchImages({int page = 0}) async {
    try {
      final isInitial = state is FeedImagesLoading || state is FeedImagesError;

      if (isInitial) {
        // 첫 진입 시엔 로딩 처리
        state = FeedImagesState.loading();
      }

      final response = await repository.getPagedImages(page, 10);

      if (state is FeedImagesData && page > 0) {
        final current = state as FeedImagesData;
        state = FeedImagesData(
          images: [...current.images, ...response.content],
          page: response.page,
          isLast: response.last,
        );
      } else {
        // ✅ page=0일 땐 덮어쓰기
        state = FeedImagesData(
          images: response.content,
          page: response.page,
          isLast: response.last,
        );
      }
    } catch (e) {
      state = FeedImagesState.error(e.toString());
    }
  }
}

abstract class FeedImagesState {
  const FeedImagesState();

  factory FeedImagesState.loading() = FeedImagesLoading;
  factory FeedImagesState.data({
    required List<FeedImage> images,
    required int page,
    required bool isLast,
  }) = FeedImagesData;
  factory FeedImagesState.error(String message) = FeedImagesError;
}

class FeedImagesLoading extends FeedImagesState {
  const FeedImagesLoading();
}

class FeedImagesData extends FeedImagesState {
  final List<FeedImage> images;
  final int page;
  final bool isLast;

  const FeedImagesData({
    required this.images,
    required this.page,
    required this.isLast,
  });
}

class FeedImagesError extends FeedImagesState {
  final String message;
  const FeedImagesError(this.message);
}
