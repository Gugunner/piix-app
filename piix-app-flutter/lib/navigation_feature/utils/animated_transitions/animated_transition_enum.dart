///Provides the correct animated transition effect value
///when an unregistered route that can have multiple transitions
///depending on from where is being navigated to. Pass as an argument
///when using any push named method from the [Navigator].
///
///Remember to check the specified transition in [UnergisteredRouteUtils].
enum AnimatedTransition {
  fadeIn,
  slideLeft,
  slideRight,
  slideTop,
  slideBottom,
}
