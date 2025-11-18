import 'package:agni_pariksha/core/errors/exceptions.dart';
import 'package:agni_pariksha/core/services/api_service.dart';

import '../models/tag_model.dart';
import '../models/sub_tag_model.dart';

abstract class TagRemoteDataSource {
  Future<List<TagModel>> getTags({String? type, bool? isActive});
  Future<TagModel> getTagById(String id);
  Future<List<SubTagModel>> getSubTags({String? tagId, String? type, bool? isActive});
  Future<SubTagModel> getSubTagById(String id);
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final ApiService apiService;

  TagRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TagModel>> getTags({String? type, bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (type != null) queryParams['type'] = type;
      if (isActive != null) queryParams['isActive'] = isActive.toString();

      final response = await apiService.get(
        '/tag',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => TagModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ServerException('Failed to fetch tags');
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Failed to fetch tags: ${e.toString()}');
    }
  }

  @override
  Future<TagModel> getTagById(String id) async {
    try {
      final response = await apiService.get('/tag/$id');

      if (response.statusCode == 200) {
        return TagModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to fetch tag');
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Failed to fetch tag: ${e.toString()}');
    }
  }

  @override
  Future<List<SubTagModel>> getSubTags({String? tagId, String? type, bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (tagId != null) queryParams['tagId'] = tagId;
      if (type != null) queryParams['type'] = type;
      if (isActive != null) queryParams['isActive'] = isActive.toString();

      final response = await apiService.get(
        '/sub-tag',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => SubTagModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw ServerException('Failed to fetch sub-tags');
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Failed to fetch sub-tags: ${e.toString()}');
    }
  }

  @override
  Future<SubTagModel> getSubTagById(String id) async {
    try {
      final response = await apiService.get('/sub-tag/$id');

      if (response.statusCode == 200) {
        return SubTagModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to fetch sub-tag');
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw ServerException('Failed to fetch sub-tag: ${e.toString()}');
    }
  }
}

