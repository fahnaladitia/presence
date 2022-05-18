class Resource<Type> {
  bool isLoading;
  Type? data;
  String? message;
  Resource({this.isLoading = false, this.data = null, this.message = null});
}

class LoadingResource<Type> extends Resource<Type> {
  LoadingResource({bool isLoading = true}) : super(isLoading: isLoading);
}

class ErrorResource<Type> extends Resource<Type> {
  ErrorResource({required String message}) : super(message: message);
}

class SuccessResource<Type> extends Resource<Type> {
  SuccessResource({required Type data, String? message})
      : super(data: data, message: message);
}
