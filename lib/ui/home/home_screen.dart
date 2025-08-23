
import 'package:flutter/material.dart';
import 'package:news/ui/home/search.dart';

import '../../l10n/app_localizations.dart';
import '../../model/category.dart';
import 'category_details/category_deatils.dart';
import 'category_fragment/category_fragment.dart';
import 'drawer/home_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Category? selectedCategory;
  bool isSearching = false; // Tracks search mode
  String searchQuery = "";

  OutlineInputBorder buildDecorationBorder({required Color colorBorderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 1, color: colorBorderSide),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          style: Theme.of(
            context,
          ).textTheme.labelLarge,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).indicatorColor,
              size: 30,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                searchQuery = "";
                isSearching = false;
                setState(() {});
              },
              icon: Icon(
                Icons.close,
                color: Theme.of(context).indicatorColor,
                size: 24,
              ),
            ),
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: Theme.of(context).textTheme.labelLarge,
            enabledBorder: buildDecorationBorder(
              colorBorderSide: Theme.of(context).indicatorColor,
            ),
            focusedBorder: buildDecorationBorder(
              colorBorderSide: Theme.of(context).indicatorColor,
            ),
          ),
        )
            : Text(
          selectedCategory == null
              ? AppLocalizations.of(context)!.home
              : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        actions: [
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  selectedCategory = null; // Clear category selection
                  isSearching = true; // Already true, but keep for clarity
                });
              },
            ),
        ],
      ),
      drawer: isSearching
          ? null
          : HomeDrawer(onDrawerItemClick: onDrawerItemClick),
      body: isSearching
          ? AllArticlesWidget(
        searchQuery: searchQuery,
      ) // Show all articles & filter
          : selectedCategory == null
          ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
          : CategoryDetails(category: selectedCategory!),
    );
  }

  void onCategoryItemClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    setState(() {});
  }

  void onDrawerItemClick() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
