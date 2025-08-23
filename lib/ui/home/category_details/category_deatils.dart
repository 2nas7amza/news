
import 'package:flutter/material.dart';
import 'package:news/source/source_tab.dart';
import 'package:provider/provider.dart';
import '../../../api/api_manager.dart';
import '../../../model/category.dart';
import '../../../model/source_response.dart';
import '../../../provider/app_language_provider.dart';
import '../../../utils/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  Category category;
  CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);


    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(
        widget.category.id,
        languageProvider.appLanguage,
      ),
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        }

        // error form client
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                'Something went wrong: ${snapshot.error}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(
                    widget.category.id,
                    languageProvider.appLanguage,
                  );
                  setState(() {}); // Refresh the widget to try again
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }
        if (snapshot.data?.status == 'error') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(
                    widget.category.id,
                    languageProvider.appLanguage,
                  );
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyColor,
                ),
                child: Text(
                  'Try Again',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        }

        // success
        var sourcesList = snapshot.data?.sources ?? [];
        return SourceTab(sourcesList: sourcesList);
      },
    );
  }
}
