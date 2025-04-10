import 'package:bronze_mirror/common/component/snack_bar.dart';
import 'package:bronze_mirror/common/component/wide_button.dart';
import 'package:bronze_mirror/common/const/message.dart';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:bronze_mirror/common/view/root_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/component/custom_text_field.dart';
import '../model/kakao_register_model.dart';
import '../provider/kakao_info_provider.dart';
import '../provider/kakao_register_provider.dart';
import '../utils/form.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final birthController = TextEditingController();
  final nameController = TextEditingController();
  final nicknameController = TextEditingController();

  bool isActive = false;

  void onFormChange() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != isActive) {
      setState(() {
        isActive = isValid;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 이름, 닉네임 초기값 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfo = ref.read(kakaoInfoProvider);
      if (userInfo != null) {
        nameController.text = userInfo.nickname;
        nicknameController.text = userInfo.nickname;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = ref.read(deviceHeightProvider);
    final userInfo = ref.watch(kakaoInfoProvider);

    return Scaffold(
      backgroundColor: WHITE,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              onChanged: onFormChange,
              child: SizedBox(
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height * 0.15),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        '생년월일, 이름, 닉네임을\n입력해주세요.',
                        style: SUB_TITLE_24,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      title: '생년월일',
                      hintText: '생년월일을 입력해주세요.',
                      controller: birthController,
                      validator: validateBirth,
                    ),
                    CustomTextField(
                      title: '이름',
                      hintText: '이름을 입력해주세요.',
                      controller: nameController,
                      validator: validateName,
                    ),
                    CustomTextField(
                      title: '닉네임',
                      hintText: '닉네임을 입력해주세요.',
                      controller: nicknameController,
                      validator: validateNickname,
                    ),
                    Expanded(
                      child: Center(
                        child: WideButton(
                          text: '회원가입',
                          isActive: isActive,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final request = KakaoRegisterRequest(
                                kakaoId: userInfo!.kakaoId,
                                profileImage: userInfo.profileImageUrl,
                                name: nameController.text,
                                nickname: nicknameController.text,
                                birthdate: birthController.text,
                              );
                              print(userInfo!.kakaoId);
                              print(userInfo.profileImageUrl);
                              print(nameController.text);
                              print(nicknameController.text);
                              print(birthController.text);
                              ref
                                  .read(kakaoRegisterProvider(request).future)
                                  .then((res) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => RootTab(),
                                      ),
                                      (route) => false,
                                    );
                                  })
                                  .catchError((e, stackTrace) {
                                    print('❌ 오류 발생: $e');
                                    print('🪵 스택트레이스: $stackTrace');
                                    showSnackBar(context, SERVER_ERROR);
                                  });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
