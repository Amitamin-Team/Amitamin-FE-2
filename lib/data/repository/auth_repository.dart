import 'package:amitamin_frontend/common/common.dart';
import 'package:amitamin_frontend/data/model/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = AuthRepository(dio, baseUrl: ProjectConstant.BASE_URL);

  return repository;
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = 
    _AuthRepository;


  @POST('/login')
  Future<ResponseCommonMapModel> requestLoginRepository({
    required RequestLoginModel requestLoginModel
  });

  @POST('/logout')
  Future<ResponseCommonListModel> requestLogoutRepository({
    required RequestLogoutModel requestLogoutModel
  });
}