import 'package:app_frontend/constant/screen_width.dart';
import 'package:app_frontend/constant/theme/themehelper.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper theme = ThemeHelper();
    ScreenWidth s = ScreenWidth(context);
    return Center(
      child: SizedBox(
        height: s.sheight(3),
        width: s.swidth(6),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color?>(
              Color.lerp(theme.buttoncolor, theme.followbackgroundcolor, 0.5)),
        ),
      ),
    );
  }
}
