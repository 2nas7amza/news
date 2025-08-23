

import 'package:flutter/material.dart';
import 'package:news/source/source_name.dart';

import '../l10n/app_localizations.dart';
import '../model/source_response.dart';
import '../news/news_widget.dart';
import '../utils/app_colors.dart';

class SourceTab extends StatefulWidget {
  List<Source> sourcesList;

  SourceTab({super.key, required this.sourcesList});

  @override
  State<SourceTab> createState() => _SourceTabState();
}

class _SourceTabState extends State<SourceTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sourcesList.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noResources,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      );
    }

    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: AppColors.transparentColor,
            tabAlignment: TabAlignment.start,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            tabs: widget.sourcesList.map((source) {
              return SourceName(
                sources: source,
                isSelected: selectedIndex == widget.sourcesList.indexOf(source),
              );
            }).toList(),
          ),
          Expanded(
            child: NewsWidget(source: widget.sourcesList[selectedIndex]),
          ),
        ],
      ),
    );
  }
}
