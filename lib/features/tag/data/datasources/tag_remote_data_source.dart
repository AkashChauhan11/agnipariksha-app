import '../../../../core/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/tag_model.dart';
import '../../domain/entities/tag.dart';

abstract class TagRemoteDataSource {
  Future<List<TagModel>> getTagsByType(TagType type, {bool? isActive});
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final ApiService apiService;

  TagRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TagModel>> getTagsByType(TagType type, {bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final response = await apiService.get(
        '${ApiConstants.getTags}/type/${_tagTypeToString(type)}',
        queryParameters: queryParams,
      );

      final responseData = response.data;
      List<dynamic> data;

      if (responseData is List) {
        data = responseData;
      } else if (responseData is Map<String, dynamic>) {
        data = responseData['data'] as List<dynamic>? ?? [];
      } else {
        data = [];
      }

      print("data: $data");

      return data
          .map((json) => TagModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("error in data source: ${e.toString()}");
      rethrow;
    }
  }

  String _tagTypeToString(TagType type) {
    switch (type) {
      case TagType.main:
        return 'main';
      case TagType.subject:
        return 'subject';
    }
  }
}

