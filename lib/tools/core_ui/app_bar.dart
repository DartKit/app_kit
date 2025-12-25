import 'package:app_kit/core/kt_export.dart';

class CoAppBar extends AppBar {
  CoAppBar(dynamic title,
      {super.key,
      List<Widget>? actions,
      Color? backgroundColor,
      Color? navigatorColor,
      Color? titleColor,
      GestureTapCallback? onLeadingTap,
      super.bottom,
      double? elevation,
      bool? scrollTitle,
      Widget? leading
      // super.backgroundColor,
      // super.padding,
      // super.margin,
      // super.showLeading = true,
      // super.iconHeight,
      // super.iconWidth,
      // GestureTapCallback? onLeadingTap,
      // double? height,
      // double? width
      })
      : super(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title.runtimeType != String
                    ? Container(
                        // padding: EdgeInsets.only(right: (actions != null && actions.isEmpty)? 50.r: 0.r),
                        child: title,
                      )
                    : (scrollTitle == true
                        ? Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  title.toString(),
                                  style: TextStyle(
                                      color: titleColor??Colors.black,
                                      fontSize: 18.r,
                                      fontWeight: AppFont.bold),
                                )),
                          )
                        : Text(
                            title.toString(),
                            style: TextStyle(
                                color: titleColor??Colors.black,
                                fontSize: 18.r,
                                fontWeight: AppFont.bold),
                          )),
              ],
            ),
            centerTitle: true,
            actions: actions
                ?.map((e) => Center(
                      child:
                          e.paddingOnly(right: e == actions.last ? 10.r : 2.r),
                    ))
                .toList(),
            backgroundColor: backgroundColor ?? CC.white,
            foregroundColor: navigatorColor,
            elevation: elevation ?? 0.5,
            scrolledUnderElevation: 0,
            // surfaceTintColor: CC.white,
            forceMaterialTransparency: false,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.r,
                color: const Color(0xff242928)),
            leading: leading ??
                InkWell(
                    // color: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onLeadingTap ??
                        () {
                          Get.back();
                        },
                    child: Container(
                      // margin: EdgeInsets.only(),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 23.r,
                        color: Colors.black,
                      ),
                    )));
}

class SearchButton extends IconButton {
  SearchButton({super.key, required VoidCallback onTap, bool isGot = false})
      : super(
            onPressed: onTap,
            icon: Icon(
              isGot ? Icons.youtube_searched_for : Icons.search_rounded,
              size: 30.0,
              color: isGot ? CC.red : Color(0xff000000),
            ));
}

// class NavButton extends IconButton {
//   NavButton(VoidCallback onTap,IconData icon):super(onPressed: onTap,icon:  Icon(icon, size: 24.0, color: Color(0xff000000),));
// }
