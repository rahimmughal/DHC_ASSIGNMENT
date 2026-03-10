class SuccessResponse<T> {
  final T data;
  final String message;

  SuccessResponse({required this.data, required this.message});

}


class FailureResponse {
  final String error;
  final String message;

  FailureResponse({required this.error, required this.message});

}