import 'dart:collection';

import 'package:flutter/material.dart';

import '../../domain/model/sheet_music.dart';
import '../../widget/molecule/sheet_info_card.dart';

class BridgeSheetListView extends StatelessWidget {
  final UnmodifiableListView<SheetMusic>? sheets;
  final String videoTitle;

  BridgeSheetListView({Key? key, required this.sheets, required this.videoTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sheets?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return SheetInfoCard(
          sheetTitle: sheets![index].title,
          videoTitle: videoTitle,
          ownerUserId: sheets![index].userId,
          likeCount: sheets![index].likeCount,
          isSelected: false,
        );
      },
    );
  }
}
