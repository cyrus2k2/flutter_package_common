import 'package:crypto/crypto.dart';

class Sha256Utils {
  Sha256Utils._();

  static Future<Digest> getSha256(Stream<List<int>> stream) async {
    return sha256.bind(stream).first;
  }
}
