// login Exception
class UserNotLoggedInAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// register Exception

class WeekPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic Exception

class GenericAuthException implements Exception {}

// fireStore Exception

class PermissionDeniedException implements Exception {}

class SendPasswordLinkException implements Exception {}

class GetDataErrorException implements Exception {}
