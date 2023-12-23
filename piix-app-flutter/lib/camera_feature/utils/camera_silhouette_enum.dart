///Contains the values used when using [CameraSilhouettePainter]
///to draw the silhouette overlay and its border surrounded it.
///
///A silhouette overlay is a shaped space in the screen used
///to specifically take a focused picture of a real life element.
///
///Choose [id] to create a silhouette where the focus
///is on an official identification to verify the identity of the user.
///
///Choose [selfie] to create two silhouettes where the focus is
///on the user face and the user official identification, normally
///being holde by the user.
enum CameraSilhouette {
  ///The value used to place a silhouette for an official documentation.
  id,

  ///The value used to place the silhouttes for the user face and the
  ///official documentation being holde by the user.
  selfie,
}