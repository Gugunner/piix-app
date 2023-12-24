import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


///A defined [DrawerHeader] that shows its information
///inside a [Column] and can have either a [headline] a
///[bottomline] or both.
///
///The headline is the title of the [AppDrawerHeader] and normally is 
///constituted of a [Text] with a bigger and bolder [TextStyle].
///
///The bottomline is the rest of the information and can be any [Widget].
final class AppDrawerHeader extends DrawerHeader {
  AppDrawerHeader({super.key, this.headline, this.bottomline})
      : super(
          padding: EdgeInsets.fromLTRB(12.w, 20.h, 16.w, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (headline != null) headline,
              if (headline != null && bottomline != null)
                SizedBox(height: 20.h),
              if (bottomline != null) bottomline,
            ],
          ),
        );

  ///The title of the [DrawerHeader] normally is a [Text].
  final Widget? headline;
  ///The rest of the body of the [DrawerHeader] can be any
  ///[Widget].
  final Widget? bottomline;
}
