import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  PermissionUtil._();

  static Future<bool> checkPermission(Permission permission) async {
    var status = await permission.status;
    return status == PermissionStatus.granted;
  }

  static Future<Map<Permission, PermissionStatus>?> requestPermission(
      List<Permission> permissions) async {
    if (permissions.isEmpty) {
      return null;
    }
    // Map<Permission, PermissionStatus> statuses =
    //     await [Permission.storage].request();
    return permissions.request();
  }

// _ask() async {
//   var status = await Permission.storage.status;
//   if (status != PermissionStatus.granted) {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();
//     if (statuses[Permission.storage] != PermissionStatus.granted) {
//       return null;
//     }
//   }
// }
}
