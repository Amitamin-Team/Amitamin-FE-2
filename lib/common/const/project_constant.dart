class ProjectConstant {
  static const ACCESS_TOKEN = 'access_token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const EXPIRED_AT = 'expired_at';

  static const AUTO_LOGIN_YN = 'auto_login_YN';

  static const BASE_URL = 'https://localhost:8080';

  static const REG_NICKNAME_TYPE = 'nickname';
  static const REG_SEX_TYPE = 'sex';
  static const REG_BIRTH_TYPE = 'birth';
  static const REG_PRIVATE_TYPE = 'private';
  static const REG_EMAIL_TYPE = 'email';
  static const REG_CODE_TYPE = 'code';
  static const REG_PASSWD_TYPE = 'password';
  static const REG_SURVEY_TYPE = 'survey';

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

  static const Map<String, Map<String, String>> INPUT_CODE_MAP = {
    '0000' : {
      'value' : '0000',
      'comment' : '초기값',
    },
    '0001' : {
      'value' : '0001',
      'comment' : '입력값 없음',
    },
    '0002' : {
      'value' : '0002',
      'comment' : '입력값 길이 오류',
    },
    '0003' : {
      'value' : '0003',
      'comment' : '입력값 형식 오류',
    },
    '0004' : {
      'value' : '0004',
      'comment' : '입력값 불일치',
    },
    '0005' : {
      'value' : '0005',
      'comment' : '입력값 실패',
    },
    // TODO : 필요 시 추가 오류 코드 정의 (0006 ~ 0008)
    '0009' : {
      'value' : '0009',
      'comment' : '입력값 유효성 검증 성공',
    },
    '0010' : {
      'value' : '0010',
      'comment' : '입력값 통과',
    },
    '0011' : {
      'value' : '0011',
      'comment' : '입력값 통과 완료 (이미 통과 후 다시 요청한 경우)',
    },
  };
}