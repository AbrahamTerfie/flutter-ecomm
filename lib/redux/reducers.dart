import 'package:hilu_flutter/models/app_state.dart';
import 'package:hilu_flutter/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(user: userReducer(state.user, action));
}

userReducer(user, action) {
  if (action is GetUserAction) {
    // return user saved under from action
    return action.user;
  }
  return user;
}
