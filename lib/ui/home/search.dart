
import 'package:flutter/material.dart';
import 'package:news/news/news_deatils.dart';
import 'package:provider/provider.dart';

import '../../api/api_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../model/news_response.dart';
import '../../news/news_item.dart';
import '../../provider/app_language_provider.dart';
import '../../utils/app_colors.dart';

class AllArticlesWidget extends StatelessWidget {
  final String searchQuery;
  const AllArticlesWidget({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return FutureBuilder<NewsResponse?>(
      future: ApiManager.getNewsBySourceId(
        sourceId: "",
        query: searchQuery.isEmpty ? null : searchQuery,
      ),
      builder: (context, snapshot) {
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.greyColor),
          );
        }

        // Articles
        var articles = snapshot.data?.articles ?? [];

        if (articles.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.noArticles,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            var article = articles[index];
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return NewsDetailsBottomSheet(article: article);
                  },
                );
              },
              child: NewsItem(news: article),
            );
          },
        );
      },
    );
  }
}
