import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_prokit/Screens/QuizEditProfile.dart';
import 'package:quiz_prokit/Screens/QuizSettings.dart';
import 'package:quiz_prokit/main.dart';
import 'package:quiz_prokit/model/QuizModels.dart';
import 'package:quiz_prokit/utils/AppWidget.dart';
import 'package:quiz_prokit/utils/QuizColors.dart';
import 'package:quiz_prokit/utils/QuizConstant.dart';
import 'package:quiz_prokit/utils/QuizDataGenerator.dart';
import 'package:quiz_prokit/utils/QuizImages.dart';
import 'package:quiz_prokit/utils/QuizStrings.dart';

class QuizProfile extends StatefulWidget {
  static String tag = '/QuizProfile';

  @override
  _QuizProfileState createState() => _QuizProfileState();
}

class _QuizProfileState extends State<QuizProfile> {
  late List<QuizBadgesModel> mList;
  late List<QuizScoresModel> mList1;

  int selectedPos = 1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mList = quizBadgesData();
    mList1 = quizScoresData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final imgview = Container(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Container(
                height: width * 0.35,
                width: width * 0.35,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: quiz_white, width: 4)),
                child: CircleAvatar(backgroundImage: CachedNetworkImageProvider(quiz_img_People2), radius: MediaQuery.of(context).size.width / 8.5),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: quiz_white, width: 2), color: context.cardColor),
                child: Icon(Icons.edit, size: 20).onTap(() {
                  QuizEditProfile().launch(context);
                  setState(() {});
                }),
              ).paddingOnly(right: 16, top: 16).onTap(() {
                print("Edit profile");
              })
            ],
          ),
          Text(
            quiz_lbl_Antonio_Perez,
            style: boldTextStyle(color: appStore.isDarkModeOn ? white : quiz_textColorPrimary),
          ).paddingOnly(top: 24),
          Text(quiz_lbl_Xp, style: secondaryTextStyle(color: quiz_textColorSecondary)).paddingOnly(top: 8),
          SizedBox(height: 30),
          Container(
            width: width,
            decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: false),
            margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPos = 1;
                      });
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
                        quiz_lbl_Badges,
                        fontSize: textSizeMedium,
                        fontFamily: fontSemibold,
                        isCentered: true,
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
                        quiz_lbl_Scores,
                        fontSize: textSizeMedium,
                        fontFamily: fontSemibold,
                        isCentered: true,
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
          selectedPos == 1
              ? Container(
                  decoration: boxDecoration(bgColor: context.cardColor, radius: 10, showShadow: true),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              mList[index].img,
                              height: 50,
                              width: 50,
                            ).paddingOnly(right: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(mList[index].title, style: boldTextStyle(color: appStore.isDarkModeOn ? white : quiz_textColorPrimary)),
                                Text(mList[index].subtitle, style: secondaryTextStyle(color: appStore.isDarkModeOn ? gray : quiz_textColorSecondary)),
                              ],
                            ),
                          ],
                        ),
                      ).paddingAll(8),
                    ),
                  ),
                ).paddingOnly(bottom: 16)
              : Container(
                  decoration: boxDecoration(bgColor: context.cardColor, radius: 10, showShadow: true),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList1.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  CachedNetworkImage(
                                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                    imageUrl: mList1[index].img,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ).cornerRadiusWithClipRRect(25).paddingOnly(right: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(mList1[index].title, style: boldTextStyle(color: appStore.isDarkModeOn ? white : quiz_textColorPrimary)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          text(mList1[index].totalQuiz, textColor: quiz_textColorSecondary),
                                          text(mList1[index].scores, textColor: quiz_textColorSecondary, fontSize: textSizeMedium, fontFamily: fontRegular)
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ).paddingAll(8),
                          ))).paddingOnly(bottom: 16)
        ],
      ),
    ).center();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: appStore.isDarkModeOn ? white : black),
              color: blackColor,
              onPressed: () => QuizSettings().launch(context),
            ),
          ],
          leading: Container(),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(color: context.cardColor, child: imgview),
        ),
      ),
    );
  }
}
