import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

const APP_NAME = '청동거울'; // 앱명

const SCREEN_NAMES = [
  'Home',
  'Map',
  'Immerse',
  'Calendar',
  'User',
]; // Appbar Title, BottomBar명

const BOTTOMBAR_ICONS = [
  Icon(Icons.home_outlined),
  Icon(Icons.location_on_outlined),
  Icon(Icons.add_circle_outline_outlined),
  Icon(Icons.calendar_month_outlined),
  Icon(Icons.person_outlined),
]; // BottomNavigationBar Icons

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// 에뮬레이터의 로컬호스트
final emulatorIp = '10.0.2.2:8080';
// 시뮬레이터의 로컬호스트
final simulatorIp = '127.0.0.1:8080';
// 컴퓨터의 로컬호스트
const computerIp = '10.21.33.46:8080';
// 운영체제에 따라 IP 바꾸기
// final ip = Platform.isIOS ? simulatorIp : emulatorIp; // 에뮬레이터로 테스트할 때
final ip = computerIp;