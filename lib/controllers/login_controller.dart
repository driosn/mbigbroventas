import 'package:flutter/material.dart';
import 'package:mibigbro_ventas_mobile/data/enums/bigbro_enums.dart';
import 'package:mibigbro_ventas_mobile/data/models/login/login_response.dart';
import 'package:mibigbro_ventas_mobile/data/services/bigbro_service.dart';

final loginControllerInstance = LoginController();

class LoginController extends ChangeNotifier {
  LoginController()
      : loginStatus = BigBroStatus.initial,
        loginResponse = null;

  final BigBroService bigBroService = BigBroService();
  //
  // Attributes
  //
  BigBroStatus loginStatus;
  LoginResponse? loginResponse;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      loginStatus = BigBroStatus.initial;
      notifyListeners();

      loginStatus = BigBroStatus.loading;
      notifyListeners();
      final response = await bigBroService.login(
        email: email,
        password: password,
      );
      loginResponse = response;
      loginStatus = BigBroStatus.success;

      notifyListeners();

      return true;
    } catch (e) {
      loginStatus = BigBroStatus.failure;
      notifyListeners();
      return false;
    }
  }
}
