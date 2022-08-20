import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_baetles_chord_play/presentation/search/search_view_model.dart';

import '../../domain/model/video.dart';
import '../../widget/atom/app_colors.dart';
import '../../widget/atom/app_font_families.dart';
import '../../widget/atom/search_icon.dart';
import '../../widget/molecule/video_block.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    SearchViewModel viewModel = context.watch<SearchViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: AppColors.black04,
        ),
        leadingWidth: 58,
        title: _searchBar(viewModel),
      ),
      body: _searchResultList(viewModel),
    );
  }

  Widget _searchBar(SearchViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grayF8,
      ),
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              controller: viewModel.controller,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              maxLength: 100,
              autocorrect: false,
              enableInteractiveSelection: false,
              cursorColor: AppColors.black04,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                counterText: '',
                hintText: '악보영상을 검색해보세요!',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: AppFontFamilies.pretendard,
                  fontWeight: FontWeight.w300,
                ),
              ),
              style: TextStyle(
                fontFamily: AppFontFamilies.pretendard,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: AppColors.black04,
              ),
              onSubmitted: (String inputText) {
                viewModel.search(inputText);
              },
            ),
          ),
          GestureDetector(
            onTap: () => viewModel.search(viewModel.controller.text),
            child: Container(
              width: 35,
              height: 37,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
              child: SearchIcon(
                width: 17,
                height: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchResultList(SearchViewModel viewModel) {
    final List<Widget> videoBlocks = [];

    for (Video video in viewModel.searchResult) {
      videoBlocks.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: VideoBlock(
            video: video,
            onClick: (Video video) {
              Navigator.pushNamed(context, "/bridge-page", arguments: video);
            },
          ),
        ),
      );
    }

    return ListView(
      children: videoBlocks,
    );
  }

  @override
  void dispose() {
    context.read<SearchViewModel>().dispose();
    super.dispose();
  }
}
