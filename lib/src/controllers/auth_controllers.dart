import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/helpers.dart';
import 'package:get_chat/services/firebase/notification.dart';
import 'package:get_chat/src/models/users.dart';

class AuthControllers extends GetxController {
  // final _apiService = ApiService();
  // final errorMessage = RxString('');
  // var isLoading = false.obs;
  // Future<void> loginUser(String username, String password) async {
  //   final result = await _apiService.login(username, password);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   result.fold((failure) {
  //     Helpers.toast("Login Failed");
  //   }, (success) {
  //     Helpers.setString(key: "apiToken", value: success["token"]);
  //     Helpers.toast("Login Successful");
  //     prefs.setBool("isLoggedIn", true);
  //   });
  // }

  final _auth = FirebaseAuth.instance;
  final _user = Rx<FirebaseUser?>(null);
  FirebaseUser? get user => _user.value;

  Future<FirebaseUser?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseUser.fromFirebaseUser(credential.user!);
      await credential.user!.updateDisplayName(name);
      _user.value = user;
      Helpers.saveUser(key: "isLoggedIn", value: true);
      Helpers.toast("Account creation Successful");
      return user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<FirebaseUser?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseUser.fromFirebaseUser(credential.user!);
      _user.value = user;
      if (_user.value != null) {
        Helpers.saveUser(key: "isLoggedIn", value: true);
        Helpers.toast("Login Successful");
      }
      return user;
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    _user.value = _auth.currentUser != null
        ? FirebaseUser.fromFirebaseUser(_auth.currentUser!)
        : null;
  }
}
