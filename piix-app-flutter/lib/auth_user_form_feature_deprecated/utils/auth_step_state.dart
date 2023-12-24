enum AuthStepState {
  idle,
  personal,
  documentation,
  ready,
  error,
}

extension AuthStepStateExtend on AuthStepState {
  bool get disablePersonalInformation => false;

  bool get donePersonalInformation {
    switch (this) {
      case AuthStepState.documentation:
      case AuthStepState.ready:
      case AuthStepState.error:
        return true;
      default:
        return false;
    }
  }

  bool get disableDocumentation {
    switch (this) {
      case AuthStepState.documentation:
      case AuthStepState.ready:
      case AuthStepState.error:
        return false;
      default:
        return true;
    }
  }

  bool get doneDocumentation {
    switch (this) {
      case AuthStepState.ready:
        return true;
      default:
        return false;
    }
  }
}
