import 'dart:io' show Platform, Directory; // Platform, Directory
import 'dart:ffi' as ffi; // C interpolation for calling C library.
import "package:ffi/ffi.dart"; // calloc : const CallocAllocator calloc = CallocAllocator._();
import 'package:path/path.dart' as path;

/**
 * Dart側でインスタンス生成可能な型
 * Array : 固定配列 (特定の型の親type)
 * Pointer : Cのネイティブポインタ
 * Struct : FFI Structの親type
 * Union : FFI Unionの親type
 * 
 * Dart側で単純なマーカーを示す型
 * Bool : C bool
 * Double: C 64bit-floating point
 * Float: C 32bit-floating point
 * Int8: C 8bit integer
 * Int16: C 16bit integer
 * Int32: C 32bit integer
 * Int64: C 64bit integer
 * NativeFunction: C 関数タイプ
 * Opaque: C opaque typeのすべての親type
 * Uint8: C 8bit unsigned
 * Uint16: C 16bit unsigned
 * Uint32: C 32bit unsigned
 * Uint64: C 64biy unsigned
 * Void: C void
 * 
 * AbiSpecificInteger: ABI-specific integer typeのすべての親type
 * Int: C int
 * IntPtr: C intptr_t
 * Long: C long int (long) 
 * LongLong: C long long
 * Short: C short
 * SignedChar: C signed char
 * Size: C size_t
 * UintPtr: C uintptr_t
 * UnsignedChar: C unsigned char
 * UnsignedInt: C unsigned int
 * UnsignedLong: C unsigned long
 * UnsignedShort: C unsigned short
 * WChar: C wchar_t
 */
// C言語ライブラリの関数インターフェース

/* hello_library */
typedef hello_world_func = ffi.Void Function();
typedef HelloWorld = void Function();

/* primitive_library */

// C sum func - int sum(int a, int b)
typedef SumFunc = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);

// C sub func - int sub(int *a, int b)
typedef SubFunc = ffi.Int32 Function(ffi.Pointer<ffi.Int32> a, ffi.Int32 b);
typedef Sub = int Function(ffi.Pointer<ffi.Int32> a, int b);

// C mul func - int *mul(int a, int b)
typedef MulFunc = ffi.Pointer<ffi.Int32> Function(ffi.Int32 a, ffi.Int32 b);
typedef Mul = ffi.Pointer<ffi.Int32> Function(int a, int b);

// C free func - C側で確保したメモリをDart側で解放
typedef FreePtrFunc = ffi.Void Function(ffi.Pointer<ffi.Int32> a);
typedef FreePtr = void Function(ffi.Pointer<ffi.Int32> a);

void main() {
  // hello_library
  {
    // 動的リンクライブラリのパスを取得
    var libraryPath =
        path.join(Directory.current.path, 'hello_library', 'libhello.so');
    if (Platform.isMacOS) {
      libraryPath =
          path.join(Directory.current.path, 'hello_library', 'libhello.dylib');
    } else if (Platform.isWindows) {
      libraryPath = path.join(
          Directory.current.path, 'hello_library', 'Debug', 'hello.dll');
    }

    // 動的リンクライブラリの読み込み
    final dylib = ffi.DynamicLibrary.open(libraryPath);

    // 関数の参照
    final HelloWorld hello = dylib
        .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
        .asFunction();

    // 関数コール
    hello();
  }

  // primitive_library
  {
    // 動的リンクライブラリのパスを取得
    var libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'libprimitives.so');
    if (Platform.isMacOS) {
      libraryPath = path.join(
          Directory.current.path, 'primitives_library', 'libprimitives.dylib');
    } else if (Platform.isWindows) {
      libraryPath = path.join(Directory.current.path, 'primitives_library',
          'Debug', 'primitives.dll');
    }

    // 動的リンクライブラリの読み込み
    final dylib = ffi.DynamicLibrary.open(libraryPath);

    // call int sum(int a, int b)
    final sumPtr = dylib.lookup<ffi.NativeFunction<SumFunc>>('sum');
    final sum = sumPtr.asFunction<Sum>();
    print('3 + 5 = ${sum(3, 5)}');

    // Create a pointer
    final p = calloc<ffi.Int32>();
    p.value = 3;

    // call int sub(int *a, int b)
    final subPtr = dylib.lookup<ffi.NativeFunction<SubFunc>>('sub');
    final sub = subPtr.asFunction<Sub>();
    print('3 - 5 = ${sub(p, 5)}');

    calloc.free(p);

    // call int *mul(int a, int b)
    final mulPtr = dylib.lookup<ffi.NativeFunction<MulFunc>>('mul');
    final mul = mulPtr.asFunction<Mul>();
    final retPtr = mul(3, 5);
    final int ret = retPtr.value;
    print('3 * 5 = ${ret}');

    // free
    final freePtr = dylib.lookup<ffi.NativeFunction<FreePtrFunc>>('free_ptr');
    final free_ptr = freePtr.asFunction<FreePtr>();
    free_ptr(retPtr);
  }

  // struct_library
  {
    
  }
}
