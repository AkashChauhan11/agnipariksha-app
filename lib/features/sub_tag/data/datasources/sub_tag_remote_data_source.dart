import '../../../../core/services/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/sub_tag_model.dart';

abstract class SubTagRemoteDataSource {
  Future<List<SubTagModel>> getSubTagsByTagId(String tagId);
}

class SubTagRemoteDataSourceImpl implements SubTagRemoteDataSource {
  final ApiService apiService;

  SubTagRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<SubTagModel>> getSubTagsByTagId(String tagId) async {
    try {
      final response = await apiService.get(
        '${ApiConstants.getSubTags}/tag/$tagId',
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

      return data
          .map((json) => SubTagModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
