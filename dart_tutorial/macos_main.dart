// OSのシステムコールを呼び出す
import 'dart:fft' as ffi;
import 'package::ffi/ffi.dart';
import 'package:path/path.dart' as path;

void main() {
  var result = system('open https://dart.dev');
  print('Result: $result');
}

typedef SystemC = ffi.Int32 Function(ffi.Pointer<Utf8> command);
