
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../provider/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_text_style.dart';

class SelectTheme extends StatefulWidget {
  const SelectTheme({super.key});

  @override
  State<SelectTheme> createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme> {
  Widget getSelectedLanguage({required String textTheme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme, style: AppTextStyle.medium20Gray),
        Icon(Icons.check, color: AppColors.whiteColor, size: 35),
      ],
    );
  }

  Widget getUnSelectedLanguage({required String textTheme}) {
    return Text(textTheme, style: AppTextStyle.medium20Black);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              setState(() {});
            },
            child: themeProvider.isDarkMode
                ? getSelectedLanguage(
              textTheme: AppLocalizations.of(context)!.dark,
            )
                : getUnSelectedLanguage(
              textTheme: AppLocalizations.of(context)!.dark,
            ),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
              setState(() {});
            },
            child: !(themeProvider.isDarkMode)
                ? getSelectedLanguage(
              textTheme: AppLocalizations.of(context)!.light,
            )
                : getUnSelectedLanguage(
              textTheme: AppLocalizations.of(context)!.light,
            ),
          ),
        ],
      ),
    );
  }
}
