import 'package:encrypt/encrypt.dart';

class AesUtil {
  ////生成16字节的随机密钥
  // var key = await FlutterAesEcbPkcs5.generateDesKey(128);
  // static const String _AES_KEY = "super_hero_77777";

  final AESMode aesMode;

  final String AES_KEY;
  final String padding;

  AesUtil(this.AES_KEY, {this.aesMode = AESMode.ecb, this.padding = "PKCS7"});

  /*
  加密
   */
  String encryptString(String data) {
    final key = Key.fromUtf8(AES_KEY);
    final iv = IV.fromUtf8(AES_KEY);

    final encrypter = Encrypter(AES(key, mode: aesMode, padding: padding));

    // Sha256 sha256=Sha256.new  https://api.flutter-io.cn/flutter/package-crypto_crypto/package-crypto_crypto-library.html

    return encrypter.encrypt(data, iv: iv).base64;
  }

  /*
  解密
  */
  String decryptString(String data) {
    final key = Key.fromUtf8(AES_KEY);
    final iv = IV.fromUtf8(AES_KEY);

    final encrypter = Encrypter(AES(key, mode: aesMode, padding: padding));

    return encrypter.decrypt64(data, iv: iv);
  }
}
