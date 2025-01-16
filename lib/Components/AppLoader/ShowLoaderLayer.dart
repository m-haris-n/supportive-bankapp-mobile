import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'AppLoader.dart';

class ShowLoaderLayer extends StatelessWidget {
  bool startLoading, showText;
  Widget? child, showExtraText;
  double? loaderSize;

  ShowLoaderLayer(
      {this.startLoading = false, this.child, this.loaderSize, this.showText = false, this.showExtraText});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: startLoading,
      opacity: 0.6,
      progressIndicator: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLoader(
            loaderSize: loaderSize,
          ),
          showText ? showExtraText ?? SizedBox() : SizedBox()
        ],
      ),
      child: child!,
    );
  }
}
