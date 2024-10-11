import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/model/QuizModels.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizDataGenerator.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';

import '../main.dart';
import 'QuizDetails.dart';

class QuizAllList extends StatefulWidget {
  static String tag = '/QuizAllList';

  @override
  _QuizAllListState createState() => _QuizAllListState();
}

class _QuizAllListState extends State<QuizAllList> {
  late List<NewQuizModel> mListings;
  int selectedPos = 1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mListings = getQuizData();
  }

  Widget quizAll() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: mListings.map((e) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: e.quizImage,
                  height: context.width() * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                  // color: quiz_white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    text(e.quizName, fontSize: textSizeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(e.totalQuiz, textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 8),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails().launch(context);
        });
      }).toList(),
    );
  }

  Widget quizCompleted() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: mListings.map((e) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                child: CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: e.quizImage,
                  height: context.width() * 0.4,
                  width: MediaQuery.of(context).size.width / 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
                  color: context.cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(e.quizName, fontSize: textSizeMedium, maxLine: 2, fontFamily: fontMedium).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
                    text(e.totalQuiz, textColor: quiz_textColorSecondary).paddingOnly(left: 16, right: 16, bottom: 16),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: textSecondaryColor.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(quiz_green),
                    ).paddingOnly(left: 16, right: 16, bottom: 16),
                  ],
                ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(() {
          QuizDetails().launch(context);
        });
      }).toList(),
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.60, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Container(
                  width: width,
                  decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: false),
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            selectedPos = 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(spacing_middle), bottomLeft: Radius.circular(spacing_middle)),
                              color: selectedPos == 1
                                  ? appStore.isDarkModeOn
                                      ? scaffoldDarkColor
                                      : quiz_white
                                  : Colors.transparent,
                              border: Border.all(color: selectedPos == 1 ? quiz_white : Colors.transparent),
                            ),
                            child: text(
                              quiz_lbl_All,
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 1
                                  ? appStore.isDarkModeOn
                                      ? white
                                      : quiz_textColorPrimary
                                  : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                      Container(height: 40, width: 1, color: quiz_light_gray).center(),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPos = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), bottomRight: Radius.circular(spacing_middle)),
                              color: selectedPos == 2
                                  ? appStore.isDarkModeOn
                                      ? scaffoldDarkColor
                                      : quiz_white
                                  : Colors.transparent,
                              border: Border.all(color: selectedPos == 2 ? quiz_white : Colors.transparent),
                            ),
                            child: text(
                              quiz_lbl_Completed,
                              fontSize: textSizeMedium,
                              isCentered: true,
                              fontFamily: fontMedium,
                              textColor: selectedPos == 2
                                  ? appStore.isDarkModeOn
                                      ? white
                                      : quiz_textColorPrimary
                                  : quiz_textColorSecondary,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: selectedPos == 1 ? quizAll() : quizCompleted(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
