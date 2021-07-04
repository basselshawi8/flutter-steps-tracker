import 'package:shared_preferences/shared_preferences.dart';


class SpUtil {
  static SpUtil _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }
}
/*
class MySharedPreferences {
  FlutterSecureStorage _storage;

  bool isInitialized = false;

  String token;
  bool hasToken;

  String firebaseToken;
  bool hasFirebaseToken;

  bool isFirstLaunch;

  String lang;

  String currentAppVersion;
  int os;

  MySharedPreferences() {
    _storage = FlutterSecureStorage();
  }

  fitchAndAssignSPValues() async {
    print(toString());

    /// fitch token
    this.token = await this.getToken();
    refreshTokenValues(token);

    /// fitch firebase token
    this.firebaseToken = await this.getFirebaseToken();
    refreshFirebaseTokenValues(firebaseToken);

    /// set if it is first time the user launch the app
    this.isFirstLaunch = await this.read(KEY_FIRST_START) == null;

    /// determine the lang according to the first time or the SP
    if (isFirstLaunch) {
      /// choose arabic language by default
      this.lang = LANG_AR;
      await this.write(KEY_LANGUAGE, LANG_AR);
    } else {
      /// read language from SP
      this.lang = await this.read(KEY_LANGUAGE);
      this.lang ??= LANG_AR;
    }

    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        currentAppVersion = packageInfo.version;
      });
    } catch (e, s) {
      print(e);
      print(s);
    }
    isInitialized = true;

    print('\nafter init .... \n');
    print(toString());
  }

  /// -----------------------------TOKEN OPERATIONS----------------------------

  setFirstTimeFalse() async {
    var res = await this.write(KEY_FIRST_START, '');
    this.isFirstLaunch = false;
    return res;
  }

  // -------------------------------------------------------------------------

  /// -----------------------------TOKEN OPERATIONS----------------------------

  setLang(String lang) async {
    assert(lang != null);
    this.lang = lang;
    var res = await this.write(KEY_LANGUAGE, lang);
    return res;
  }

  getLang() {
    return this.lang;
  }

  // -------------------------------------------------------------------------

  /// -----------------------------TOKEN OPERATIONS----------------------------

  getToken() async {
    String token = await this.read(KEY_TOKEN);
    refreshTokenValues(token);
    return token;
  }

  saveToken(String tokenWithoutBearer) async {
    assert(tokenWithoutBearer != null && tokenWithoutBearer != '');
    String token = await this.write(KEY_TOKEN, tokenWithoutBearer);
    refreshTokenValues(tokenWithoutBearer);
    print('saved token: ${this.token}');
    return token;
  }

  refreshTokenValues(String token) {
    if (token == null) {
      this.token = null;
      this.hasToken = false;
    } else {
      this.token = token;
      this.hasToken = true;
    }
  }

  deleteToken() async {
    print('deleteToken ..............');
    var res = await this.delete(KEY_TOKEN);
    refreshTokenValues(null);
    return res;
  }

  getFirebaseToken() async {
    String token = await this.read(KEY_FIREBASE_TOKEN);
    refreshFirebaseTokenValues(token);
    return token;
  }

  saveFirebaseToken(String tokenWithoutBearer) async {
    assert(tokenWithoutBearer != null && tokenWithoutBearer != '');
    String token = await this.write(KEY_FIREBASE_TOKEN, tokenWithoutBearer);
    log('token saved' + tokenWithoutBearer.toString());
    refreshFirebaseTokenValues(tokenWithoutBearer);
    return token;
  }

  deleteFirebaseToken() async {
    var res = await this.delete(KEY_FIREBASE_TOKEN);
    refreshFirebaseTokenValues(null);
    return res;
  }

  refreshFirebaseTokenValues(String token) {
    if (token == null) {
      this.firebaseToken = null;
      this.hasFirebaseToken = false;
    } else {
      this.firebaseToken = token;
      this.hasFirebaseToken = true;
    }
  }

  clearUserInfo(BuildContext context) {}

  // -------------------------------------------------------------------------

  /// --------------------------- PRIMARY OPERATION----------------------------
  read(String key) async {
    return await _storage.read(
      key: key,
    );
  }

  write(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  delete(String key) async {
    return await _storage.delete(
      key: key,
    );
  }

// -------------------------------------------------------------------------

}

MySharedPreferences appSharedPrefs = MySharedPreferences();*/
