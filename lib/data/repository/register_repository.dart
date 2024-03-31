import 'package:amitamin_frontend/common/const/const.dart';
import 'package:amitamin_frontend/common/global/global.dart';
import 'package:amitamin_frontend/data/model/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'register_repository.g.dart';

final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = RegisterRepository(dio, baseUrl: ProjectConstant.BASE_URL);

  return repository;
});

@RestApi()
abstract class RegisterRepository {
  factory RegisterRepository(Dio dio, {String baseUrl}) = 
    _RegisterRepository;

  
  @POST('/users')
  Future<ResponseCommonListModel> requestRegisterRepository({
    required RequestRegisterModel requestRegisterModel
  });
}