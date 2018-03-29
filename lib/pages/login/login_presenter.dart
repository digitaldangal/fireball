import 'package:Fireball/data/rest_data.dart';
import 'package:Fireball/models/user.dart';
import 'package:Fireball/utils/constants.dart';
import 'package:Fireball/utils/instagram.dart' as insta;

abstract class LoginScreenContract {
  void onLoginSuccess(User user);

  void onLoginScuccess(insta.Token token);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestData api = new RestData();

  LoginScreenPresenter(this._view);

  doLogin(String username, String password) {
    api.login(username, password).then((User user) {
      _view.onLoginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }

  void perform_login() {
    assert(_view != null);
    insta.getToken(constants.APP_ID, constants.APP_SECRET).then((token) {
      if (token != null) {
        _view.onLoginScuccess(token);
      } else {
        _view.onLoginError('Error');
      }
    });
  }
}
