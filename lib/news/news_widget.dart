
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/news/news_deatils.dart';

import 'package:provider/provider.dart';

import '../api/api_manager.dart';
import '../l10n/app_localizations.dart';
import '../model/news_response.dart';
import '../model/source_response.dart';
import '../provider/app_language_provider.dart';
import '../utils/app_colors.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController scrollController =
  ScrollController();
  final List<Articles> articles = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  bool showLoadingText = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNews();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchNews();
      }
    });
  }

  @override
  void didUpdateWidget(covariant NewsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source.id != widget.source.id) {
      currentPage = 1;
      articles.clear();
      hasMore = true;
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      showLoadingText = false;
      errorMessage = null;
    });

    Timer(const Duration(milliseconds: 300), () {
      if (mounted && isLoading) {
        setState(() {
          showLoadingText = true;
        });
      }
    });

    var languageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );

    try {
      final response = await ApiManager.getNewsBySourceId(
        sourceId: widget.source.id ?? "",
        language: languageProvider.appLanguage,
        page: currentPage,
        pageSize: 20,
      );

      if (response?.status == 'error') {
        setState(() {
          errorMessage = response?.message ?? "Unknown server error";
          isLoading = false;
        });
        return;
      }

      if (response != null && response.articles != null) {
        setState(() {
          articles.addAll(response.articles!);

          hasMore = response.articles!.length == 20;

          if (hasMore) currentPage++;
        });
      } else {
        setState(() => hasMore = false);
      }
    } catch (e) {
      setState(() {
        errorMessage = "Something went wrong: $e";
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null && articles.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage!,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: fetchNews,
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

    if (articles.isEmpty && isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.greyColor),
      );
    }

    if (articles.isEmpty && !isLoading) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noArticles,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      );
    }


    return ListView.builder(
      controller: scrollController,
      itemCount: articles.length + 1,
      itemBuilder: (context, index) {
        if (index < articles.length) {
          var article = articles[index];
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => NewsDetailsBottomSheet(article: article),
              );
            },
            child: NewsItem(news: article),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: !hasMore
                  ? Text(
                'No more news available',
                style: Theme.of(context).textTheme.labelLarge,
              )
                  : isLoading
                  ? const CircularProgressIndicator(color: AppColors.greyColor)
                  : const SizedBox.shrink(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController
        .dispose();
    super.dispose();
  }
}
