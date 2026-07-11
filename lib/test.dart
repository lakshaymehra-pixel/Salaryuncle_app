import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
void main()async {
  final encryptor = MyEncrypt(defaultKey: "Rfeds235443#\$%!&SwwwreEr4298fc1c149afbf\$4c8996fb92427ae41e4649b934ca495991b7852b855");

  final encoded = encryptor.encode('1522', urlSafe: true);
  print('Encoded: $encoded');

  final decoded = encryptor.decode(encoded);
  print('Decoded: $decoded');
}


class MyEncrypt {
  final String defaultKey;

  MyEncrypt({required this.defaultKey});

  String encode(String plainText, {String? key, bool urlSafe = true}) {
    final usedKey = key ?? defaultKey;
    final encrypter = _getEncrypter(usedKey);

    final iv = IV.fromSecureRandom(16); // Random IV for each encryption
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // Combine IV and encrypted data
    final combined = iv.bytes + encrypted.bytes;
    String base64 = base64Encode(combined);

    if (urlSafe) {
      base64 = _toUrlSafe(base64);
    }

    return base64;
  }

  String decode(String encodedText, {String? key}) {
    final usedKey = key ?? defaultKey;
    final encrypter = _getEncrypter(usedKey);

    String base64 = _fromUrlSafe(encodedText);
    final combined = base64Decode(base64);

    // Extract IV and ciphertext
    final iv = IV(Uint8List.fromList(combined.sublist(0, 16)));
    final ciphertext = combined.sublist(16);

    final encrypted = Encrypted(Uint8List.fromList(ciphertext));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  Encrypter _getEncrypter(String key) {
    final keyBytes = sha256.convert(utf8.encode(key)).bytes;
    return Encrypter(AES(Key(Uint8List.fromList(keyBytes))));
  }

  String _toUrlSafe(String input) {
    return input.replaceAll('+', '.').replaceAll('=', '-').replaceAll('/', '~');
  }

  String _fromUrlSafe(String input) {
    return input.replaceAll('.', '+').replaceAll('-', '=').replaceAll('~', '/');
  }
}