// 公共方法
import 'package:flutter/material.dart' show Color;
import 'package:flutter/services.dart' show MethodChannel, Clipboard, ClipboardData;

import '../utils/dialog.dart';

final methodChannel = MethodChannel('com.template.flutter');

abstract class PrecisionFix {
  static bool _isNumber(String _number) => num.tryParse(_number) != null;

  static String fromString(String _number, int digit) {
    if (!_isNumber(_number)) return '--';

    return fromNumber(double.parse(_number), digit ?? 0);
  }

  static String fromAllString(String _number, String _digit) {
    if (!_isNumber(_number)) return '--';

    final int digit = _digit == null ? 0 : _digit.split('.').last.length;
    return fromNumber(double.parse(_number), digit);
  }

  static int fromDigitString(String _digit) => _digit == null ? 0 : _digit.split('.').last.length;

  static String fromNumber(num _number, int digit) {
    if (!_isNumber(_number.toString())) return '--';
    assert(digit <= 20 && digit >= 0);

    final int _fractionDigits = (digit ?? 0) + 1;
    if (_fractionDigits > 1 && _fractionDigits <= 20) {
      return _number
          .toStringAsFixed(_fractionDigits)
          .replaceFirst(RegExp(r'\d$'), '');
    }

    return _number.toStringAsFixed(digit);

  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(getColorFromHex(hexColor));

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

String stringFix(String str) => str ?? '- -'; // 字符串占位符

Future<void> copy(String text, { isToast = true }){ // 复制到粘贴板
  if (text != null) return Clipboard
      .setData(ClipboardData(text: text))
      .then((r) => isToast ? Talk.toast('复制成功') : null);

  if (isToast) Talk.toast('复制失败');
  return Future.error('复制失败');
}

Future<ClipboardData> paste() => Clipboard.getData(Clipboard.kTextPlain);
