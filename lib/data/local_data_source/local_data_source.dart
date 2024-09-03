
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/utils/app_keys.dart';

abstract class LocalDataSource {
  String checkLoginOrNot();
  Future<bool> signOut();
}

class LocalDataSourceImpl extends LocalDataSource {
  late SharedPreferences preferences;

  LocalDataSourceImpl() {
    getSh();
  }

  Future getSh() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  String checkLoginOrNot() {
    return preferences.getString(AppKeys.token)??"";
  }

  @override
  Future<bool> signOut()async {
    return await preferences.setString(AppKeys.token, "");
  }


}