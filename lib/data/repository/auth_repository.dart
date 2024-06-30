import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/model/model.dart';
import 'package:amitamin_frontend/data/model/request_refresh_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = AuthRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/auth');

  return repository;
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = 
    _AuthRepository;


  @POST('/login')
  Future<ResponseCommonListModel> requestLoginRepository(@Body() RequestLoginModel requestLoginModel);

  @POST('/logout')
  Future<ResponseCommonListModel> requestLogoutRepository(@Body() RequestLogoutModel requestLogoutModel);

  @POST('/refresh')
  Future<ResponseCommonListModel> requestRefreshRepository(@Body() RequestRefreshModel requestRefreshModel);
}