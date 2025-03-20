import 'dart:io';
import 'dart:typed_data';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/immerse/component/button/submit_button.dart';
import 'package:bronze_mirror/immerse/layout/immerse_layout.dart';
import 'package:bronze_mirror/immerse/provider/image_picker_provider.dart';
import 'package:bronze_mirror/immerse/view/final_image_view_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../component/custom_slider.dart';
import '../component/button/custom_icon_button.dart';
import '../provider/opacity_provider.dart';
import '../utils/camera.dart';

class ImageDrawScreen extends ConsumerStatefulWidget {
  const ImageDrawScreen({super.key});

  @override
  ConsumerState<ImageDrawScreen> createState() => _ImageDrawScreenState();
}

class _ImageDrawScreenState extends ConsumerState<ImageDrawScreen> {
  bool _isFlipped = false;
  bool _showOpacitySlider = false;

  Uint8List? _editedImage;
  CameraController? _cameraController;

  /// 변환 상태 변수 (크기, 위치, 각도)
  double _scale = 1.0; // 확대/축소
  Offset _offset = Offset.zero; // 이동 위치
  double _rotation = 0.0; // 회전
  double _initialRotation = 0.0; // 회전값 스택

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  @override
  Widget build(BuildContext context) {
    final XFile? image = ref.watch(imageProvider);
    final double opacity = ref.watch(opacityProvider);

    final double width = ref.watch(deviceWidthProvider);

    if (image == null) {
      return const Scaffold(
        body: Center(child: Text("선택된 이미지가 없거나 형식이 잘못됐습니다.")),
      );
    }

    return ImmerseLayout(
      title: '',
      color: Colors.white,
      isLeftIcon: true,
      child: Stack(
        children: [
          /// 카메라 뷰
          Positioned.fill(
            child:
                _cameraController != null &&
                        _cameraController!.value.isInitialized
                    ? Center(
                      child: AspectRatio(
                        aspectRatio: 1/ _cameraController!.value.aspectRatio,
                        child: CameraPreview(_cameraController!),
                      ),
                    )
                    : Container(color: Colors.black),
          ),

          /// 버튼 등 UI
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ImageSection(image, opacity),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
                child: _EditButtonSection(image, width),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 이미지 표시 및 변환 영역
  Widget _ImageSection(XFile image, double opacity) {
    return GestureDetector(
      onScaleStart: (details) {
        _initialRotation = _rotation;
      },
      onScaleUpdate: (details) {
        setState(() {
          _scale = details.scale.clamp(0.5, 3.0);
          _offset += details.focalPointDelta;
          _rotation = _initialRotation + details.rotation;
        });
      },
      child: Opacity(
        opacity: opacity,
        child: Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()
                ..translate(_offset.dx, _offset.dy)
                ..rotateZ(_rotation)
                ..scale(_scale),
          child:
              _editedImage != null
                  ? Image.memory(_editedImage!, width: 300, fit: BoxFit.contain)
                  : Image.file(
                    File(image.path),
                    width: 300,
                    fit: BoxFit.contain,
                  ),
        ),
      ),
    );
  }

  /// 편집 버튼 섹션
  Widget _EditButtonSection(XFile image, double width) {
    return SizedBox(
      height: 160,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            onPressed: () async {
              final result = await applyFlip(
                imageFile: File(image.path),
                isCurrentlyFlipped: _isFlipped,
              );
              if (result != null) {
                setState(() {
                  _editedImage = result;
                  _isFlipped = !_isFlipped;
                });
              }
            },
            icon: const Icon(Icons.flip, color: Colors.white),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconButton(
                onPressed: () {
                  setState(() {
                    _showOpacitySlider = !_showOpacitySlider;
                  });
                },
                icon: const Icon(
                  Icons.water_drop_outlined,
                  color: Colors.white,
                ),
              ),
              if (_showOpacitySlider) const CustomSlider(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 초기화 버튼 (위치, 크기, 회전값 리셋)
              CustomIconButton(
                onPressed: _resetImage,
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),

              /// Next 버튼
              SubmitButton(
                onPressed:
                    () => pickImage(
                      imageProvider: finalImageProvider,
                      source: ImageSource.camera,
                      nextScreen: FinalImageViewScreen(),
                      context: context,
                    ),
                text: 'Complete',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 카메라 권한 및 초기화
  Future<void> _setupCamera() async {
    bool granted = await requestCameraPermission();
    if (granted) {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final controller = CameraController(
          cameras[0],
          ResolutionPreset.ultraHigh,
        );
        await controller.initialize();
        if (mounted) {
          setState(() {
            _cameraController = controller;
          });
        }
      }
    }
  }

  /// 모든 상태 초기화
  void _resetImage() {
    setState(() {
      _editedImage = null;
      _isFlipped = false;
      _showOpacitySlider = false;
      _scale = 1.0; // 크기 초기화
      _offset = Offset.zero; // 위치 초기화
      _rotation = 0.0; // 회전 초기화
    });
    ref.read(opacityProvider.notifier).setOpacity(0.5);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
