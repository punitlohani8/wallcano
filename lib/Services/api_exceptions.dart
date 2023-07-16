class ApiExceptions implements Exception{
  String? header;
  String? msg;
  ApiExceptions({this.header, this.msg});
  @override
  String toString() {
    return '$header $msg';
  }
}

class UnauthorisedException extends ApiExceptions{
  UnauthorisedException(String msg) : super(header: 'Unauthorised Exception', msg: msg);
}

class FetchDataException extends ApiExceptions{
  FetchDataException(String msg) : super(header: 'FetchData Exception', msg: msg);
}

class BadRequestException extends ApiExceptions{
  BadRequestException(String msg) : super(header: 'BadRequest Exception', msg: msg);
}

class InvalidInputException extends ApiExceptions{
  InvalidInputException(String msg) : super(header: 'InvalidInput Exception', msg: msg);
}