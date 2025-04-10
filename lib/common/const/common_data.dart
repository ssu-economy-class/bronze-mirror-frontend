import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

const APP_NAME = '청동거울'; // 앱명

const SCREEN_NAMES = [
  'Home',
  // 'Map',
  'Immerse',
  // 'Calendar',
  'User',
]; // Appbar Title, BottomBar명

const BOTTOMBAR_ICONS = [
  'assets/icon/bottom_navigator_bar/home.png',
  // 'assets/icon/bottom_navigator_bar/map.png',
  'assets/icon/bottom_navigator_bar/immerse.png',
  // 'assets/icon/bottom_navigator_bar/calendar.png',
  'assets/icon/bottom_navigator_bar/user.png',
];

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// 에뮬레이터의 로컬호스트
final emulatorIp = 'http://10.0.2.2:8080';
// 시뮬레이터의 로컬호스트
final simulatorIp = 'http://127.0.0.1:8080';
// 컴퓨터의 로컬호스트(애뮬레이터로 테스트 할 때)
const computerIp = 'http://10.21.33.46:8080';
// 운영체제에 따라 IP 바꾸기
// final ip = Platform.isIOS ? simulatorIp : emulatorIp; // 에뮬레이터로 테스트할 때
final ip = computerIp;