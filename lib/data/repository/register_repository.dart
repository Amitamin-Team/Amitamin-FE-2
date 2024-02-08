import 'package:amitamin_frontend/data/model/model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'register_repository.g.dart';

@RestApi()
abstract class RegisterRepository {
  factory RegisterRepository(Dio dio, {String baseUrl}) = 
    _RegisterRepository;

  
  @POST('/users')
  Future<ResponseRegisterModel> requestRegisterRepository({
    required RequestRegisterModel requestRegisterModel
  });
}