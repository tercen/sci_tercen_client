class ServiceError {
  late Map _data;
  Object? originalError;

  ServiceError(int statusCode, String error, [String? reason]) {
    _data = {};
    _data["statusCode"] = statusCode;
    _data["error"] = error;
    _data["reason"] = reason ?? error;
  }
  ServiceError.fromObject(int statusCode, String error, Map reasonObject,
      [String? reason]) {
    _data = {};
    _data["statusCode"] = statusCode;
    _data["error"] = error;
    _data["reasonObject"] = reasonObject;
    _data["reason"] = reason ?? error;
  }

  factory ServiceError.fromJson(Map data) {
    if (data.containsKey("reasonObject")) {
      return ServiceError.fromObject(data["statusCode"], data["error"],
          data["reasonObject"], data["reason"]);
    } else {
      return ServiceError(data["statusCode"], data["error"], data["reason"]);
    }
  }

  factory ServiceError.fromError(e) {
    if (e is ServiceError) return e;
    return ServiceError.unknown(e.toString());
  }
  ServiceError.abort(String error, [String? reason]) : this(-1, error, reason);
  ServiceError.unknown([String? reason]) : this(500, 'unknown', reason);
  ServiceError.conflict(String error, [String? reason])
      : this(409, error, reason);

  ServiceError.bad(String error, [String? reason]) : this(400, error, reason);
  ServiceError.forbidden(String error, [String? reason])
      : this(401, error, reason);

  ServiceError.notFound(String error, [String? reason])
      : this(404, error, reason);
  ServiceError.userAbort(String error) : this(-1, error, "User abort");

  @override
  String toString() => "$runtimeType($_data)";

  Map toJson() => _data;
  Map? get reasonObject => _data["reasonObject"];
  String get reason => _data["reason"];
  String get error => _data["error"];
  int get statusCode => _data["statusCode"];
  bool? get isLogged => _data["isLogged"] ?? false;
  set isLogged(bool? b) {
    _data["isLogged"] = b;
  }

  bool get isBadRequestError => statusCode == 400;
  bool get isUnauthorizedError => statusCode == 401;
  bool get isConflictError => statusCode == 409;
  bool get isNotFoundError => statusCode == 404;
  bool get isUnknownError => statusCode == 500;
  bool get isUserAbortError => statusCode == -1;
  bool get isTimeoutError => statusCode == 504;

  String get statusCodeDescription {
    String text;
    if (isNotFoundError) {
      text = "Not found";
    } else if (isBadRequestError) {
      text = "Bad request";
    } else if (isConflictError) {
      text = "Conflict";
    } else if (isUnauthorizedError) {
      text = "Not authorized";
    } else if (isUnknownError) {
      text = "Unexpected error : $error";
    } else {
      text = "Unexpected error : $error";
    }
    return text;
  }

  @override
  int get hashCode => statusCode.hashCode;

  @override
  bool operator ==(other) =>
      other is ServiceError &&
      other.statusCode == statusCode &&
      other.error == error;
}
