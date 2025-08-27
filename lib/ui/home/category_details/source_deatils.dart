

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/di/di.dart';
import 'package:news/source/source_tab.dart';
import 'package:news/ui/home/category_details/cuibt/source_state.dart';
import 'package:news/ui/home/category_details/cuibt/source_view_model.dart';
import 'package:provider/provider.dart';
import '../../../api/api_manager.dart';
import '../../../model/category.dart';
import '../../../model/source_response.dart';
import '../../../utils/app_colors.dart';

class SourceDetails extends StatefulWidget {
  Category category;
  SourceDetails({super.key, required this.category});

  @override
  State<SourceDetails> createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  SourceViewModel viewModel = SourceViewModel(
      sourceRepository: injectSourceRepository());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSource(widget.category.id);
  }
  @override
  Widget build(BuildContext context) {
     return BlocBuilder<SourceViewModel,SourceState>(
       bloc: viewModel,
         builder: (context, state) {
           if(state is SourceLoadingState){
             return  Center(
               child: CircularProgressIndicator(color: AppColors.greyColor),
                     );
           }
           else if(state is SourceErrorState){
             return Column(
                       children: [
                         Text(
                           state.errorMessage,
                           style: Theme.of(context).textTheme.labelMedium,
                         ),
                         ElevatedButton(
                           onPressed: () {
                             viewModel.getSource(widget.category.id);
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
           else if(state is SourceSuccessState){
             return SourceTab(sourcesList: state.sourceList);
           }
           return Column();
         },
     );

    // return FutureBuilder<SourceResponse?>(
    //   future: ApiManager.getSources(
    //     widget.category.id,
    //
    //   ),
    //   builder: (context, snapshot) {
    //     // loading
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(
    //         child: CircularProgressIndicator(color: AppColors.greyColor),
    //       );
    //     }
    //
    //     // error form client
    //     if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           Text(
    //             'Something went wrong: ${snapshot.error}',
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               ApiManager.getSources(
    //                 widget.category.id,
    //               );
    //               setState(() {}); // Refresh the widget to try again
    //             },
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: AppColors.greyColor,
    //             ),
    //             child: Text(
    //               'Try Again',
    //               style: Theme.of(context).textTheme.labelMedium,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //     if (snapshot.data?.status == 'error') {
    //       return Column(
    //         children: [
    //           Text(
    //             snapshot.data!.message!,
    //             style: Theme.of(context).textTheme.labelMedium,
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               ApiManager.getSources(
    //                 widget.category.id,
    //               );
    //               setState(() {});
    //             },
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: AppColors.greyColor,
    //             ),
    //             child: Text(
    //               'Try Again',
    //               style: Theme.of(context).textTheme.labelMedium,
    //             ),
    //           ),
    //         ],
    //       );
    //     }
    //
    //     // success
    //     var sourcesList = snapshot.data?.sources ?? [];
    //     return SourceTab(sourcesList: sourcesList);
    //   },
    // );
  }
}
