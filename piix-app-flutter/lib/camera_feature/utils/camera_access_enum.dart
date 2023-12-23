
///Contains all the states that a [camera] can pass through
///when requesting access.
///
///When first initializing any [camera] it can be in the [waiting]
///state if the [camera] which changes to either [denied] if the user
///chooses not to allow the use of the camera or [granted] if the
///user allows it.
enum CameraAccess {
  ///The state a camera is in when it is loading.
  waiting,
  ///The user has not granted access to the camera or microphone.
  denied,
  ///The user has allowed both the use of the camera and the 
  ///microphone.
  granted,
}
