import 'package:amitamin_frontend/common/const/project_constant.dart';
import 'package:amitamin_frontend/common/global/secure_storage.dart';
import 'package:amitamin_frontend/data/data.dart';
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

    // 헤더 설정
    options.headers = {
      'Content-Type': 'application/json',
    };

    // TODO : 요청 시 토큰 처리
    final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);

    // TODO : 헤더에 토큰 삽입

    // 디버깅 코드
    print("###################");
    print(options.data);
    print(options.path);
    print(options.baseUrl);
    print(options.contentType);
    print(options.responseType);
    print("###################");
    
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

    if(accessToken == null || refreshToken == null) {
      return handler.reject(err);
    }

    final statusCode = err.response?.statusCode;
    final requestPath = err.requestOptions.path;

    // TODO : REFRESH TOKEN 재발급 요청
    if((statusCode == 401 || statusCode == 422) && requestPath != '/refresh') {
      final dio = Dio();

      try {
        final resp = await dio.post(
          '${ProjectConstant.BASE_URL}/auth/refresh',
          options: Options(
            headers: {},
          ),
          data: {
            'refresh_token' : await storage.read(key: ProjectConstant.REFRESH_TOKEN),
          }
        );

        ResponseCommonListModel responseCommonListModel = ResponseCommonListModel.fromJson(resp.data);
        ResponseRefreshModel responseRefreshModel = ResponseRefreshModel.fromJson(responseCommonListModel.data![0]);

        // 응답으로 받은 토큰 
        final accessToken = responseRefreshModel.access_token;
        final refreshToken = responseRefreshModel.refresh_token;
        final expiresIn = responseRefreshModel.expires_in;
        // secure storage에 토큰 다시 저장
        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: accessToken);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: refreshToken);
        await storage.write(key: ProjectConstant.EXPIRES_IN, value: expiresIn.toString());
        await storage.write(key: ProjectConstant.LOING_TIME, value: DateTime.now().toString());

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