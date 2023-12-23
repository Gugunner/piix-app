import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piix_mobile/camera_feature/camera_screen_barrel_file.dart';
import 'package:piix_mobile/camera_feature/camera_utils_barrel_file.dart';
import 'package:piix_mobile/file_feature/file_model_barrel_file.dart';
import 'package:piix_mobile/form_feature/form_utils_barrel_file.dart';
import 'package:piix_mobile/form_feature/ui/widgets/documentation_camera_form_field/documentation_camera_barrel_file.dart';
import 'package:piix_mobile/navigation_feature/utils/navigator_key_state.dart';

///The basic field that implements a [DocumentationCameraInputDecorator] and
///controls the [initialPicture] taken.
///
///The camera field can also regulate how the [DocumentationCameraInputDecorator] can
///behave by setting the [enabled] property to either true or false,
///this property is included in the passed [decoration] and allows
///to overwrite it.
///
///Passing a [focusNode] allows the field to request any focus to it or
///to pass the focus to another element that can request focus inside the same
///[FocusScope].
///
///When setting [onChanged], the value is passed over to the
///[DocumentationCameraScreen] by executing [_savePicture] which
///waits for the [FileContentModel] value containing the [_picture.path] to the
///current temporal photograph taken but can also be null.
///
///Any time a new [_picture] is taken then it tries to execute
///[onEditingComplete]. Consider using it when focus should pass to another
///element or a specific action needs to be perfomed when a new [_picture]
///will be used.
///
///Use [onSubmitted] when a new [_picture] is taken and a submission of the
///photograph is needed instead of passing focus to another element.
///
///Use [onTap] when a specific action needs to occur when the user taps once
///over the specified [GestureDetector] or [Material] class. By default if no
///[onTap] is passed it executes [_savePicture] inside [_onTap].
///
///Use [onDeletePicture] when a specific action needs to occur when the
///current photograph is erased which is considered to be deleted.
///The passed argument is executed before setting the [_picture] value to
///[null].
///
///Use [onReplace ] when a specific action needs to occur when the current
///photograph is trying to be replaced. The passed argument is executed before
///calling [_savePicture].
///
///A [initialPicture] can be set. If a [_picture] is taken
///the current [initialPicture] will not show even if a value is present.
class DocumentationCameraField extends StatefulWidget {
  DocumentationCameraField({
    super.key,
    required this.cameraSilhouette,
    this.readOnly = false,
    this.canRequestFocus = true,
    this.maxLines = 1,
    this.enabled,
    this.focusNode,
    CameraInputDecoration? decoration,
    this.style,
    this.textAlign,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTap,
    this.onDoubleTap,
    this.onDeletePicture,
    this.onReplacePicture,
    this.onTapOutside,
    this.initialPicture,
  }) : decoration = decoration ?? CameraInputDecoration();

  ///Shows which silhouette should be present in
  ///the [DocumentationCameraScreen].
  final CameraSilhouette cameraSilhouette;

  ///Controls all callback executions [onTap], [onDeletePicture] and
  ///[onReplacePicture] from being called and all the methods used to control
  ///the field. When set to true no callback or method will execute.
  final bool readOnly;

  ///Allows this element to request focus.
  final bool canRequestFocus;

  ///Controls the global allowed number of lines for the
  ///errorMaxLines and helperMaxLines inside the [CameraInputDecoration].
  final int maxLines;

  ///If null or true will allow interactions with this field.
  final bool? enabled;

  ///The governing controller that handles focus for this field.
  final FocusNode? focusNode;

  ///Pass the CameraInputDecoration values to control
  ///the status which determine the [Color]s, [TextStyle]s
  ///or overwrite the [Color]s and [TextStyle]s too.
  final CameraInputDecoration? decoration;

  ///If not null will overwrite all [TextStyle]s in
  ///the [DocumentationCameraInputDecorator] and [CameraInputDecoration].
  final TextStyle? style;

  ///Sets the aligment of text for the
  final TextAlign? textAlign;

  ///Executes the callback when the photograph taken changes.
  final ValueChanged<FileContentModel?>? onChanged;

  ///Executes when a new photograph is taken.
  final VoidCallback? onEditingComplete;

  ///Executes only when done or send is pressed on the keyboard.
  final ValueChanged<FileContentModel>? onSubmitted;

  ///Executes instead of [_onTap] if not null will require
  ///the parent Widget to control all the photograph taken and
  ///navigate to the camera screen.
  final VoidCallback? onTap;

  ///Executes instead of [_onDoubleTap] if not null will require
  ///the parent Widget to control what happens when double tapping
  ///the field.
  final VoidCallback? onDoubleTap;

  ///Executes before [_onDeletePhoto].
  final VoidCallback? onDeletePicture;

  ///Executes before [_onReplacePhoto].
  final VoidCallback? onReplacePicture;

  ///Executes when tapping outside the field.
  final TapRegionCallback? onTapOutside;

  ///When set it will use the picture instead
  ///if no other picture is taken
  ///an [Image] of this property.
  final FileContentModel? initialPicture;

  @override
  State<DocumentationCameraField> createState() =>
      _DocumentationCameraFieldState();
}

///Current implementation of the [DocumentationCameraField] that stores inside
///[_picture] the last photograph taken.
///
///Other properties that it stores and manages are the [_focusNode]
///which changes only when comparing values of this inside
///[didChangeDependencies] and [_canDelete] which allows the
///[DocumentationCameraInputDecorator] to show the button to delete
///the current [_picture] only if set to true.
///
///This also handles any changes to the [_effectiveFocusNode] and executes
///the basic calls for [_onTap], [_onDoubleTap], [_onLongPress],
///[_onDeletePicture] and [_onReplacePicture]. As well as navigate to
///[DocumentationCameraScreen] by invoking [_waitForPicture].
class _DocumentationCameraFieldState extends State<DocumentationCameraField> {
  //The difference in calling the term picture or photo is that photo is the
  //[Image] rendered picture, while picture is the file containing the
  //information.

  ///Stores the [Uint8List] information and [path] of the photograph taken.
  FileContentModel? _picture;

  ///Used if no parent [widget.focusNode] is passed.
  FocusNode? _focusNode;

  ///Stores the actual value which allows deleting a [_picture].
  bool _canDelete = false;

  ///Returns the real [FocusNode] used in the field.
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  //Currently the field does not allow hover
  final bool _isHovering = false;

  ///Checks that the field is enabled by reading the parent [widget] or the
  ///passed [widget.decoration.enabled] property if no value is passed then
  ///by default is enabled.
  bool get _isEnabled => widget.enabled ?? widget.decoration?.enabled ?? true;

  //Creates the [CameraInputDecoration] used by the
  /// [DocumentationCameraInputDecorator].
  CameraInputDecoration get _effectiveDecoration {
    final themeData = Theme.of(context);
    //Checks if the parent widget passed a decoration and if not instantiates a
    //new one.
    final effectiveDecoration = ((widget.decoration ?? CameraInputDecoration())
                .applyDefaults(themeData.inputDecorationTheme)
            //Note that is must be cast as a CameraInputDecoration to
            //use the overriden copyWith method.
            as CameraInputDecoration)
        .copyWith(
      //Passes over the new values that are overwritten by applyDefaults.
      enabled: _isEnabled,
      hintMaxLines: widget.decoration?.hintMaxLines ?? widget.maxLines,
      errorMaxLines: widget.decoration?.errorMaxLines ?? widget.maxLines,
      helperMaxLines: widget.decoration?.helperMaxLines ?? widget.maxLines,
      filled: _picture != null || (widget.decoration?.filled ?? false),
      canDelete: _canDelete,
    );
    //Since copyWith method returns an InputDecoration it must be cast
    //as a CameraInputDecoration.
    return effectiveDecoration as CameraInputDecoration;
  }

  void _handleFocusChanged() {
    setState(() {
      // Rebuild the widget on focus change.
    });
  }

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
    _effectiveFocusNode.addListener(_handleFocusChanged);
    //If initial picture data is passed with a value
    //then it initializes the picture to be shown.
    if (widget.initialPicture != null) {
      _picture = widget.initialPicture;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
  }

  @override
  void didUpdateWidget(DocumentationCameraField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }
    _effectiveFocusNode.canRequestFocus = widget.canRequestFocus && _isEnabled;
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  ///Navigates to [DocumentationCameraScreen] and returns
  ///the picture taken or null if the screen is popped without
  ///any picture selected.
  Future<FileContentModel?> _waitForPicture() async =>
      NavigatorKeyState().slideToLeftRoute(
        page: DocumentationCameraScreen(
          cameraSilhouette: widget.cameraSilhouette,
          onChanged: widget.onChanged,
        ),
        routeName: '',
      );

  ///Reads the [FileContentModel] as a picture and then passes over
  ///the picture path inside a new [File] to store in [_picture],
  ///so that [Image.file] inside [build] can render the [Widget].
  void _onTakePicture() async {
    final picture = await _waitForPicture();
    setState(() {
      _canDelete = false;
      if (picture != null) {
        _picture = picture;
        //Passes the new picture taken to the parent if onChanged
        //is not null.
        widget.onChanged?.call(picture);
        //If a new picture is taken it calls onEditingComplete
        //passed by the parent.
        widget.onEditingComplete?.call();
      }
    });
  }

  void _onTap() async {
    //If the field is readable only it exits.
    if (widget.readOnly) return;
    //If a parent onTap callback was passed then it executes
    //the parent callback instead.
    if (widget.onTap != null) return widget.onTap?.call();
    //If a picture has already been taken then it does nothing.
    if (_picture != null) return;
    //If no picture is stored it will take a picture.
    _onTakePicture();
  }

  void _onDoubleTap() async {
    //If the field is readable only it exits.
    if (widget.readOnly) return;
    //If a parent onDoubleTap callback was passed then it executes
    //the parent callback instead.
    if (widget.onDoubleTap != null) return widget.onDoubleTap?.call();
    //If no picture is stored it will take a picture.
    if (_picture == null) return _onTakePicture();
    try {
      final imageData = base64Decode(_picture!.base64Content);
      // final base64Image = await _picture?.readAsBytes();
      //If a picture is already stored then it will open the
      //preview screen to show the picture.
      final keepPicture = await NavigatorKeyState().slideToTopRoute<bool?>(
        page: DocumentationPreviewScreen(
          imageData,
          cameraSilhouette: widget.cameraSilhouette,
        ),
        routeName: '',
      );
      //If the user selects not to keep the current photograph
      //then it will replace the picture.
      if (keepPicture == false) {
        _onReplacePicture();
      }
    } catch (error) {
      //TODO: Log Error
      return;
    }
  }

  void _onLongPress() async {
    //If the field is readable only it exits.
    if (widget.readOnly) return;
    //If not picture is taken then instead it will
    //onTap.
    if (_picture == null) return _onTap();
    //If there is already a picture it will toggle between
    //allowing to delete the photograph or not.
    setState(() {
      _canDelete = !_canDelete;
    });
  }

  void _onReplacePicture() async {
    //If the field is readable only it exits.
    if (widget.readOnly) return;
    //Executes parent onReplacePicture if it is not null.
    widget.onReplacePicture?.call();
    //If the picture is to be replaced then it will take a new picture.
    _onTakePicture();
  }

  void _onDeletePicture() async {
    //If the field is readable only it exits.
    if (widget.readOnly) return;
    //Executes parent onDeletePicture if it is not null.
    widget.onDeletePicture?.call();
    //When the picture is trying to be delete a modal appears to ask
    //for confirmation.
    final delete = await showDialog<bool?>(
        context: context, builder: (context) => const DeleteImageModal());
    //If the confirmation is approved then it will set the
    //_picture to null and prevent any execution that allows to delete a picture
    //since there is no picture.
    if (delete ?? false) {
      setState(() {
        _picture = null;
        _canDelete = false;
      });
      //Calls parent onChanged if not set to null
      //to delete the picture in the parent.
      widget.onChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Builds the [Image.file] which renders
    //the photograph image.
    Widget? child;

    if (_picture != null) {
      final imageData = base64Decode(_picture!.base64Content);
      child = Transform.scale(
        scaleX: widget.cameraSilhouette == CameraSilhouette.selfie ? -1 : 1,
        child: Image.memory(
          imageData,
          width: 121.w,
          height: 98.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            //TODO: Change to UI placeholder when ready
            return const Placeholder();
          },
        ),
      );
    }

    return TapRegion(
      onTapOutside: widget.onTapOutside,
      child: Focus(
        focusNode: _effectiveFocusNode,
        debugLabel: 'DocumentationCameraField',
        child: DocumentationCameraInputDecorator(
          decoration: _effectiveDecoration,
          baseStyle: widget.style,
          textAlign: widget.textAlign,
          isHovering: _isHovering,
          isFocused: _effectiveFocusNode.hasFocus,
          onTap: _onTap,
          onLongPress: _onLongPress,
          onDoubleTap: _onDoubleTap,
          onReplacePhoto: _onReplacePicture,
          onDeletePhoto: _onDeletePicture,
          child: child,
        ),
      ),
    );
  }
}
