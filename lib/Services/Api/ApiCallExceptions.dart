class ApiCallException implements Exception {
  final _message;
  final _prefix;

  ApiCallException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiCallException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiCallException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiCallException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ApiCallException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class RequestNotFoundException extends ApiCallException {
  RequestNotFoundException([message]) : super(message, "Request Not Found");
}

class UnAuthorizationException extends ApiCallException {
  UnAuthorizationException([message]) : super(message, "Un-authorized User");
}

class InternalServerException extends ApiCallException {
  InternalServerException([message]) : super(message, "Internal Server Error");
}

class ServerNotFoundException extends ApiCallException {
  ServerNotFoundException([message]) : super(message, "Server Not Found");
}

class UserAlreadyExit extends ApiCallException {
  UserAlreadyExit([message]) : super(message, "User Already Exit");
}