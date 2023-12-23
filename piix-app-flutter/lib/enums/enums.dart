/// Enum that represents the different types of fields in a form.
enum FieldType {
  uniqueId,
  name,
  lastName,
  email,
  phone,
}

/// Enum that represents the different types of login.
enum LoginType { email, phone, invalid, unset }

///claims thumbs status
enum ThumbsStatus {
  thumbsUp,
  thumbsDown,
  thumbsNone,
}

@Deprecated('Will be removed in 4.0')
enum ButtonTypeDeprecated {
  text,
  outlined,
  elevated,
}

@Deprecated('Will be removed in 4.0')

///Button plan types
enum PlanButtonDeprecated {
  remove,
  add,
}

@Deprecated('Will be removed in 4.0')

///alert types
enum AlertTypeDeprecated {
  none,
  error,
  success,
  badRequest,
}

@Deprecated('Will be removed in 4.0')

///alert state
enum AlertStateDeprecated {
  show,
  hide,
}

enum BarType {
  Code128A,
  Code128B,
  Code128C,
}

enum ComboRow { detail, list }

@Deprecated('Will be removed in 4.0')
enum GeneralQuotationStateDeprecated {
  idle,
  getting,
  accomplished,
  empty,
  notFound,
  conflict,
  error,
  unexpectedError,
}

@Deprecated('Will be removed in 4.0')
enum HomeStateDeprecated {
  idle,
  loading,
  finish,
  error,
}

enum MembershipAlert {
  basicMembership,
  emptyBasicForm,
  additionalForms,
  basicInformation,
  ticketsFound,
  activatingMembership,
  none
}

enum EditCredentialType { email, phone }
