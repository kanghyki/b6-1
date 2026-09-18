-- SQLite 전용: 결과에 컬럼명을 표시합니다.
.headers on

-- SQLite 전용: 결과를 테두리가 있는 표 형태로 출력합니다.
.mode box

-- SQLite 전용: NULL 값을 빈칸 대신 NULL 문자열로 표시합니다.
.nullvalue NULL

-- SQLite 전용: 실행되는 SQL 명령문 자체를 화면에 함께 출력합니다. (주석도 출력)
.echo on

-- SQLite 전용: 테이블의 컬럼 정보를 확인합니다.
-- PRAGMA table_info(table_name)

-- SQLite 전용: 테이블의 인덱스 목록을 확인합니다.
-- PRAGMA index_list(table_name);

-- SQLite 전용: 테이블의 정의된 외래 키를 확인합니다.
-- PRAGMA foreign_key_list(table_name);

-- SQLite 전용: 해당 인덱스가 어떤 컬럼으로 구성되어 있는지 확인합니다.
-- PRAGMA index_info(sqlite_autoindex_customers_1);

-- customers
PRAGMA table_info(customers);
PRAGMA index_list(customers);


-- menu_items
PRAGMA table_info(menu_items);
PRAGMA index_list(menu_items);


-- orders
PRAGMA table_info(orders);
PRAGMA foreign_key_list(orders);
PRAGMA index_list(orders);


-- order_items
PRAGMA table_info(order_items);
PRAGMA foreign_key_list(order_items);
PRAGMA index_list(order_items);


-- SQLite 전용: 외래 키 위반 데이터를 검사합니다. 위반이 없으면 결과 행이 없습니다.
PRAGMA foreign_key_check;

SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS menu_count FROM menu_items;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS detail_count FROM order_items;