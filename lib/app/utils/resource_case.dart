import '../core/common/resource.dart';

class ResourceCase<Type> {
  final Function(SuccessResource<Type>) onSuccess;
  final Function(ErrorResource<Type>) onError;
  final Function(LoadingResource<Type>) onLoading;

  ResourceCase({
    required this.onSuccess,
    required this.onError,
    required this.onLoading,
  });

  Future<void> execute(Resource<Type> event) async {
    if (event is SuccessResource<Type>) {
      onSuccess(event);
    } else if (event is LoadingResource<Type>) {
      onLoading(event);
    } else if (event is ErrorResource<Type>) {
      onError(event);
    }
    // switch (event.runtimeType) {
    //   case LoadingResource<Type>:
    //     onLoading(event as LoadingResource<Type>);
    //     break;
    //   case ErrorResource<Type>:
    //     onError(event as ErrorResource<Type>);
    //     break;
    //   case SuccessResource<Type>:
    //     onSuccess(event as SuccessResource<Type>);
    //     break;
    // }
  }
}
