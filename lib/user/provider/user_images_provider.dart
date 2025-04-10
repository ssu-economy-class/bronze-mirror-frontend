import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_images_model.dart';
import '../repository/user_images_repository.dart';

final userImagesProvider = StateNotifierProvider<UserImagesNotifier, UserImagesState>((ref) {
  final repo = ref.watch(userImagesRepositoryProvider);
  return UserImagesNotifier(repository: repo);
});

class UserImagesNotifier extends StateNotifier<UserImagesState> {
  final UserImagesRepository repository;

  UserImagesNotifier({required this.repository}) : super(const UserImagesLoading()) {
    getImages();
  }

  Future<void> getImages() async {
    try {
      final response = await repository.getMyImages();
      state = UserImagesData(response.images, response.imageCount);
    } catch (e, st) {
      state = UserImagesError(e.toString());
    }
  }
}

abstract class UserImagesState {
  const UserImagesState();

  factory UserImagesState.loading() = UserImagesLoading;
  factory UserImagesState.data(List<UserImage> images, int imageCount) = UserImagesData;
  factory UserImagesState.error(String message) = UserImagesError;
}

class UserImagesLoading extends UserImagesState {
  const UserImagesLoading();
}

class UserImagesData extends UserImagesState {
  final List<UserImage> images;
  final int imageCount;

  const UserImagesData(this.images, this.imageCount);
}

class UserImagesError extends UserImagesState {
  final String message;

  const UserImagesError(this.message);
}
