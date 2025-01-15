class ApiCallResponse<T> {
  Status? status;
  T? responseData;
  String? message;

  ApiCallResponse.loading(this.message) : status = Status.LOADING;

  ApiCallResponse.completed(this.responseData) : status = Status.COMPLETED;

  ApiCallResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $responseData";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
