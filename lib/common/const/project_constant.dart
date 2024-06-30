class ProjectConstant {
  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const EXPIRES_IN = 'expires_in';
  static const LOING_TIME = 'login_time';

  static const AUTO_LOGIN_YN = 'auto_login_YN';

  static const BASE_URL = 'http://localhost:8080/api'; // <- 이 부분을 바꿔서 테스트하기!!!

  static const PRIVATE_URL = 'https://sedate-deposit-cd0.notion.site/e9fa4d05790048938153dd824c4a8b4c?pvs=4';

  static const INPUT_CODE_00 = '00'; // 초기값
  static const INPUT_CODE_01 = '01'; // 입력값 없음
  static const INPUT_CODE_02 = '02'; // 입력값 길이 오류
  static const INPUT_CODE_03 = '03'; // 입력값 형식 오류
  static const INPUT_CODE_04 = '04'; // 입력값 불일치
  static const INPUT_CODE_05 = '05'; // 입력값 중복 오류
  /* 필요 시 코드 추가 */
  static const INPUT_CODE_09 = '09'; // 입력값 유효성 검증 성공 (API 요청 전)
  static const INPUT_CODE_10 = '10'; // 입력값 API 요청 결과 성공 (API 요청 후)
  static const INPUT_CODE_11 = '11'; // 입력값 API 요청 결과 실패 (response_code가 200이 아닐 때)
  static const INPUT_CODE_12 = '12'; // 입력값 API 요청 완료 (이미 통과한 경우)
  static const INPUT_CODE_13 = '13'; // 기타 오류 

}