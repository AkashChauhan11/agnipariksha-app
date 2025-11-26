import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../models/state_model.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<CountryModel>> getCountries({bool? isActive});
  
  Future<List<StateModel>> getStatesByCountry({
    required String countryId,
    bool? isActive,
  });
  
  Future<List<CityModel>> getCitiesByState({
    required String stateId,
    bool? isActive,
  });
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final ApiService apiService;

  LocationRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CountryModel>> getCountries({bool? isActive}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final response = await apiService.get(
        ApiConstants.getCountries,
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
      
      return data
          .map((json) => CountryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StateModel>> getStatesByCountry({
    required String countryId,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'countryId': countryId,
      };
      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final response = await apiService.get(
        ApiConstants.getStates,
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
      
      return data
          .map((json) => StateModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CityModel>> getCitiesByState({
    required String stateId,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'stateId': stateId,
      };
      if (isActive != null) {
        queryParams['isActive'] = isActive.toString();
      }

      final response = await apiService.get(
        ApiConstants.getCities,
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
      
      return data
          .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

