
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../model/category.dart';
import '../../../provider/app_theme_provider.dart';
import 'category_item.dart';

typedef OnCategoryItemClick = void Function(Category);
class CategoryFragment extends StatelessWidget {
  List<Category> categoriesList = [];
  OnCategoryItemClick onCategoryItemClick;
  CategoryFragment({super.key, required this.onCategoryItemClick});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    categoriesList = Category.getCategoriesList(themeProvider.isDarkMode);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.greetingNews,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: height * 0.02),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onCategoryItemClick(categoriesList[index]);
                    },
                    child: CategoryItem(
                      category: categoriesList[index],
                      index: index,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                itemCount: categoriesList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
