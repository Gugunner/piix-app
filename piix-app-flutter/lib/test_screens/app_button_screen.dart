import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/utils/list_utils.dart';
import 'package:piix_mobile/widgets/button/app_button_barrel_file.dart';

enum ButtonState {
  one,
  two,
  three,
  four,
}

class AppButtonScreen extends StatefulWidget {
  static const routeName = '/app_button_screen';
  const AppButtonScreen({super.key});

  @override
  State<AppButtonScreen> createState() => _AppButtonScreenState();
}

class _AppButtonScreenState extends State<AppButtonScreen> {
  ButtonState? state = ButtonState.one;

  List<ButtonState> states = [ButtonState.four];

  bool change = false;

  void addRemoveButtonState(ButtonState state) {
    setState(() {
      if (states.contains(state)) {
        final index = states.indexWhere((st) => st == state);
        states = states.removeIndexValue(index);
        return;
      }
      states = [...states, state];
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('WELCOME TO TEST RUN!'),
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    children: [
                      const Text('APP SWITCH LIST TILE BUTTON'),
                      ListTile(
                        leading: const Text('Enabled Set Switch'),
                        trailing: AppSwitchButton(
                          value: true,
                          onChanged: (value) {
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Text('Enabled Unset Switch'),
                        trailing: AppSwitchButton(
                          value: false,
                          onChanged: (value) {
                            setState(() {
                              change = value;
                            });
                          },
                        ),
                      ),
                      const ListTile(
                        leading: Text('Disabled Set Switch'),
                        trailing: AppSwitchButton(
                          value: true,
                          onChanged: null,
                        ),
                      ),
                      const ListTile(
                        leading: Text('Disabled Unset Switch'),
                        trailing: AppSwitchButton(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    children: [
                      const Text('APP RADIO LIST TILE BUTTON'),
                      AppListTileButton(
                        title: Text(ButtonState.one.name),
                        onTap: () {
                          setState(() {
                            state = ButtonState.one;
                          });
                        },
                        horizontalTitleGap: 0,
                        leading: AppRadioButton<ButtonState>(
                          value: ButtonState.one,
                          groupValue: state,
                          onChanged: (value) {
                            setState(() {
                              state = value;
                            });
                          },
                        ),
                        selected: state == ButtonState.one,
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.two.name),
                        onTap: () {
                          setState(() {
                            state = ButtonState.two;
                          });
                        },
                        horizontalTitleGap: 0,
                        leading: AppRadioButton<ButtonState>(
                          value: ButtonState.two,
                          groupValue: state,
                          onChanged: (value) {
                            setState(() {
                              state = value;
                            });
                          },
                        ),
                        selected: state == ButtonState.two,
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.three.name),
                        horizontalTitleGap: 0,
                        leading: AppRadioButton<ButtonState>(
                          value: state,
                          groupValue: ButtonState.three,
                          onChanged: null,
                        ),
                        selected: state == ButtonState.three,
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.four.name),
                        horizontalTitleGap: 0,
                        leading: const AppRadioButton<ButtonState>(
                          value: ButtonState.four,
                          groupValue: ButtonState.four,
                          onChanged: null,
                        ),
                        selected: state == ButtonState.four,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    children: [
                      const Text('APP CHECKBOX BUTTON'),
                      AppListTileButton(
                        title: Text(ButtonState.one.name),
                        onTap: () {
                          addRemoveButtonState(ButtonState.one);
                        },
                        leading: AppCheckboxButton(
                          value: states.contains(ButtonState.one),
                          onChanged: (bool) {
                            addRemoveButtonState(ButtonState.one);
                          },
                        ),
                        selected: states.contains(ButtonState.one),
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.two.name),
                        leading: AppCheckboxButton(
                          value: states.contains(ButtonState.two),
                          onChanged: null,
                        ),
                        selected: states.contains(ButtonState.two),
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.three.name),
                        onTap: () {
                          addRemoveButtonState(ButtonState.three);
                        },
                        leading: AppCheckboxButton(
                          value: states.contains(ButtonState.three),
                          onChanged: (bool) {
                            addRemoveButtonState(ButtonState.three);
                          },
                        ),
                        selected: states.contains(ButtonState.three),
                      ),
                      AppListTileButton(
                        title: Text(ButtonState.four.name),
                        leading: AppCheckboxButton(
                          value: states.contains(ButtonState.four),
                          onChanged: null,
                        ),
                        selected: states.contains(ButtonState.four),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Column(
                    children: [
                      const Text('APP FILLED SIZED BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton(
                        text: 'Regular Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Column(
                    children: [
                      const Text('APP FILLED SIZED SMALL BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppFilledSizedButton.small(
                        text: 'Small Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    children: [
                      const Text('APP OUTLINED SIZED BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton(
                        text: 'Regular Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Column(
                    children: [
                      const Text('APP OUTLINED SIZED SMALL BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppOutlinedSizedButton.small(
                        text: 'Small Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Column(
                    children: [
                      const Text('APP TEXT SIZED BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppTextSizedButton(
                        text: 'Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton(
                        text: 'Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Column(
                    children: [
                      const Text('APP TEXT TITLE SIZED BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Ultimate Title Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.title(
                        text: 'Title Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Column(
                    children: [
                      const Text('APP TEXT HEADLINE SIZED BUTTON'),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Keep Selected Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Loading Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Disabled Button',
                        onPressed: null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Keep Selected Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        keepSelected: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Loading Icon Button',
                        onPressed: () {
                          debugPrint('Click!');
                        },
                        loading: true,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextSizedButton.headline(
                        text: 'Headline Disabled Icon Button',
                        onPressed: null,
                        iconData: Icons.thumb_up_outlined,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
