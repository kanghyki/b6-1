-- SQLite 전용: 조회 결과에 컬럼명을 표시합니다.
.headers on
-- SQLite 전용: 조회 결과를 테두리가 있는 표 형태로 출력합니다.
.mode box
-- SQLite 전용: NULL 값을 빈칸 대신 NULL 문자열로 표시합니다.
.nullvalue NULL

SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS menu_count FROM menu_items;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS detail_count FROM order_items;

-- SQLite 전용: 존재하는 데이터 중 FK 위반 검사.
PRAGMA foreign_key_check;