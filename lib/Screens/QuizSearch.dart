import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizDetails.dart';
import 'package:quiz_prokit/main.dart';
import 'package:quiz_prokit/model/QuizModels.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizDataGenerator.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';
import 'package:quiz_prokit/utils/QuizWidget.dart';

class QuizSearch extends StatefulWidget {
  static String tag = '/QuizSearch';

  @override
  _QuizSearchState createState() => _QuizSearchState();
}

class _QuizSearchState extends State<QuizSearch> {
  late List<NewQuizModel> mListings;
  var searchCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    mListings = getQuizData();
  }

  Widget quizAll() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: mListings.map((e) {
        return Container(
          color: context.cardColor,
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    imageUrl: e.quizImage,
                    height: context.width() * 0.4,
                    width: MediaQuery.of(context).size.width / 0.25,
                    fit: BoxFit.cover,
                  )),
              Text(e.quizName, style: primaryTextStyle()).paddingOnly(top: 8, left: 16, right: 16, bottom: 8),
              4.height,
              Text(
                e.totalQuiz,
                style: boldTextStyle(color: quiz_textColorSecondary),
              ).paddingOnly(left: 16, right: 16, bottom: 8),
            ],
          ),
        ).cornerRadiusWithClipRRect(16).onTap(
          () {
            QuizDetails().launch(context);
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            quizTopBar('Search'),
            Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: searchCont,
                style: primaryTextStyle(),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: appStore.isDarkModeOn ? white : black),
                  contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  hintText: quiz_lbl_search,
                  filled: true,
                  fillColor: context.cardColor,
                  hintStyle: primaryTextStyle(color: quiz_view_color),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: quiz_app_background, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: quiz_app_background, width: 0.0),
                  ),
                ),
              ),
            ),
            searchCont.text.length >= 1 ? quizAll() : Container()
          ],
        ),
      ),
    );
  }
}
