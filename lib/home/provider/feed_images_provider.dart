import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/feed_images_model.dart';
import '../repository/feed_images_repository.dart';

final feedImagesProvider = StateNotifierProvider<FeedImagesNotifier, FeedImagesState>((ref) {
  final repo = ref.watch(feedImagesRepositoryProvider);
  return FeedImagesNotifier(repository: repo);
});

class FeedImagesNotifier extends StateNotifier<FeedImagesState> {
  final FeedImagesRepository repository;
  bool _isFetching = false;

  FeedImagesNotifier({required this.repository}) : super(FeedImagesState.loading()) {
    fetchImages(page: 0);
  }

  Future<void> fetchImages({int page = 0}) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final isInitial = state is FeedImagesLoading || state is FeedImagesError;

      if (isInitial) {
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
        state = FeedImagesData(
          images: response.content,
          page: response.page,
          isLast: response.last,
        );
      }
    } catch (e) {
      state = FeedImagesState.error(e.toString());
    } finally {
      _isFetching = false;
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
