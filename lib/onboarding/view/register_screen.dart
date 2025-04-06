import 'package:bronze_mirror/common/component/wide_button.dart';
import 'package:bronze_mirror/common/provider/size_provider.dart';
import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/component/custom_text_field.dart';

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

  String? validateName(String? text) {
    if (text != null && text.length > 16) {
      return '16자 이내로 입력해주세요.';
    }
    if (text != null && !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(text)) {
      return '숫자와 특수문자는 사용할 수 없습니다.';
    }
    return null;
  }

  String? validateNickname(String? text) {
    if (text != null && text.length > 16) {
      return '16자 이내로 입력해주세요.';
    }
    if (text != null && !RegExp(r'^[a-zA-Z가-힣\s]+$').hasMatch(text)) {
      return '숫자와 특수문자는 사용할 수 없습니다.';
    }
    return null;
  }

  String? validateBirth(String? text) {
    if (!RegExp(r'^\d{6}$').hasMatch(text!)) {
      return '생년월일 6자리를 입력해주세요.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = ref.read(deviceHeightProvider);

    return Scaffold(
      backgroundColor: WHITE,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
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
              SizedBox(height:24),
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
              WideButton(
                text: '회원가입',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('생년월일: ${birthController.text}');
                    print('이름: ${nameController.text}');
                    print('닉네임: ${nicknameController.text}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
