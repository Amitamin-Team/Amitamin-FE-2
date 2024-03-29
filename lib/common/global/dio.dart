import 'package:amitamin_frontend/common/const/project_constant.dart';
import 'package:amitamin_frontend/common/global/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    // TODO : 요청 시 토큰 처리
    final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);

    // TODO : 헤더에 토큰 삽입

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO : 토큰이 유효하지 않을 때
    final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);

    if(refreshToken == null) {
      return handler.reject(err);
    }

    final statusCode = err.response?.statusCode;
    final requestPath = err.requestOptions.path;

    // TODO : REFRESH TOKEN 재발급 요청
    if(statusCode == 401 && requestPath != '/reissue') {
      final dio = Dio();

      try {
        final resp = await dio.post(
          '${ProjectConstant.BASE_URL}/reissue',
          options: Options(
            headers: {},
          ),
        );

        // 응답으로 받은 토큰 
        final accessToken = resp.data['access_token'];
        final refreshToken = resp.data['refresh_token'];
        // secure storage에 토큰 다시 저장
        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: accessToken);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: refreshToken);

        // 요청 재전송
        final response = await dio.fetch(err.requestOptions);

        return handler.resolve(response);
      } on DioException {
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }
}