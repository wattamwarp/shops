import 'package:freezed_annotation/freezed_annotation.dart';
part 'repo_response.freezed.dart';

@freezed
class RepoResponse<T> with _$RepoResponse<T> {
  const factory RepoResponse.success(T data) = Success<T>;
  const factory RepoResponse.error(String message) = Error<T>;
}
