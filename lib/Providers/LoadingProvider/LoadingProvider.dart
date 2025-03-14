import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  callUnFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
    notifyListeners();
  }
}
