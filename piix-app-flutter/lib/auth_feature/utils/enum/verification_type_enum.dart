enum VerificationType {
  signIn,
  signUp,
  update,
  recover;

  int get totalSteps {
    switch (this) {
      case VerificationType.signIn:
        return 2;
      case VerificationType.signUp:
        return 5;
      case VerificationType.update:
        return 2;
      case VerificationType.recover:
        return 4;
    }
  }
}
