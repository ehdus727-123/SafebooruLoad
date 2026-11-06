# SafebooruLoad

크롤러가 만든 월별 CSV(`YYYYMM.csv`)를 MariaDB `safebooru.posts` 테이블에 적재하는 스크립트입니다.

| 파일 | 하는 일 |
|---|---|
| `daily_load.bat` | 지난달과 이번 달 CSV를 `current.csv`로 복사하고 `load.sql`을 실행합니다. 결과는 `load.log`에 남습니다. |
| `load.sql` | `LOAD DATA LOCAL INFILE ... REPLACE`로 CSV를 `posts`에 넣습니다. 같은 ID는 덮어써서 중복이 생기지 않습니다. |
| `sb.cnf.example` | MariaDB 접속 설정 예시. `sb.cnf`로 복사해 비밀번호를 채워 쓰세요. |

## 사용
1. 폴더를 `C:\safebooru_load`에 둡니다.
2. `sb.cnf.example`을 `sb.cnf`로 복사하고 `sb` 계정 비밀번호를 적습니다. `sb.cnf`는 `.gitignore`에 들어 있어 올라가지 않습니다.
3. `daily_load.bat`의 `SRC`(크롤러 output 폴더)와 `MARIADB` 경로를 환경에 맞게 확인합니다.
4. `daily_load.bat`을 실행하거나 작업 스케줄러에 등록합니다.

비밀번호가 든 `sb.cnf`, 데이터 파일 `current.csv`, 로그 `load.log`는 저장소에 올리지 않습니다.
