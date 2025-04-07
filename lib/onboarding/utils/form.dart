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