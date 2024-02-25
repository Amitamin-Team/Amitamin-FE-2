import 'package:amitamin_frontend/data/model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

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