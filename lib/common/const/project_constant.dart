class ProjectConstant {
  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const EXPIRES_IN = 'expires_in';

  static const AUTO_LOGIN_YN = 'auto_login_YN';

  static const BASE_URL = 'http://localhost:8080/api'; // <- 이 부분을 바꿔서 테스트하기!!!

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
  
  // 나중에 다른 파일로 옮길 예정
  static const Map<int, Map<String, dynamic>> FATIGUE_SCORE_MAP = {
    0 : {
      'score' : 0,
      'path' : 'assets/icons/emoji/state=0.svg',
      'comment' : '',
    },
    1 : {
      'score' : 1,
      'path' : 'assets/icons/emoji/state=1.svg',
      'comment' : '',
    },
    2 : {
      'score' : 2,
      'path' : 'assets/icons/emoji/state=2.svg',
      'comment' : '',
    },
    3 : {
      'score' : 3,
      'path' : 'assets/icons/emoji/state=3.svg',
      'comment' : '',
    },
    4 : {
      'score' : 4,
      'path' : 'assets/icons/emoji/state=4.svg',
      'comment' : '',
    },
    5 : {
      'score' : 5,
      'path' : 'assets/icons/emoji/state=5.svg',
      'comment' : '',
    },
    6 : {
      'score' : 6,
      'path' : 'assets/icons/emoji/state=6.svg',
      'comment' : '',
    },
    7 : {
      'score' : 7,
      'path' : 'assets/icons/emoji/state=7.svg',
      'comment' : '',
    },
    8 : {
      'score' : 8,
      'path' : 'assets/icons/emoji/state=8.svg',
      'comment' : '',
    },
    9 : {
      'score' : 9,
      'path' : 'assets/icons/emoji/state=9.svg',
      'comment' : '',
    },
    10 : {
      'score' : 10,
      'path' : 'assets/icons/emoji/state=10.svg',
      'comment' : '',
    },
  };

}