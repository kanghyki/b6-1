-- SQLite 전용: 조회 결과에 컬럼명을 표시합니다.
.headers on

-- SQLite 전용: 조회 결과를 테두리가 있는 표 형태로 출력합니다.
.mode box

-- SQLite 전용: NULL 값을 빈칸 대신 NULL 문자열로 표시합니다.
.nullvalue NULL

-- SQLite 전용: 실행되는 SQL 명령문 자체를 화면에 함께 출력합니다. (주석도 출력)
.echo on

-- SQLite 전용: FK 검사 활성화. BEGIN 이전에 실행합니다.
PRAGMA foreign_keys = ON;

-- Q01: 현재 가격이 5,000원 이상인 메뉴를 조회한다.
SELECT id, name, price
FROM menu_items
WHERE price >= 5000
ORDER BY id;

-- Q02: 메뉴를 가격 내림차순, 번호 오름차순으로 정렬한다.
SELECT id, name, price
FROM menu_items
ORDER BY price DESC, id ASC;

-- Q03: 최근 주문 세 건을 날짜와 주문 번호 역순으로 조회한다.
SELECT id, customer_id, ordered_on, status
FROM orders
ORDER BY ordered_on DESC, id DESC
LIMIT 3;

-- Q04: 이름에 라떼가 포함되고 가격이 5,000원 이하인 메뉴를 찾는다.
SELECT id, name, price
FROM menu_items
WHERE name LIKE '%Latte%' AND price <= 5000
ORDER BY id;

-- Q05: 모든 주문에 주문자의 이름을 붙여 조회한다.
SELECT o.id AS order_id, c.name AS customer_name, o.ordered_on, o.status
FROM orders AS o
INNER JOIN customers AS c ON c.id = o.customer_id
ORDER BY o.id;

-- Q06: 상세별 메뉴 이름, 수량, 주문 당시 단가와 금액을 조회한다.
SELECT oi.id AS detail_id, oi.order_id, m.name,
       oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS line_amount
FROM order_items AS oi
INNER JOIN menu_items AS m ON m.id = oi.menu_item_id
ORDER BY oi.id;

-- Q07: 주문이 없는 고객까지 포함해 고객과 주문을 조회한다.
SELECT c.id AS customer_id, c.name, o.id AS order_id
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id
ORDER BY c.id, o.id;

-- Q08: 1번 주문의 고객 정보와 메뉴별 구매 내역을 조회한다.
SELECT o.id AS order_id, c.name AS customer_name, o.ordered_on,
       m.name AS menu_name, oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS line_amount
FROM orders AS o
INNER JOIN customers AS c ON c.id = o.customer_id
INNER JOIN order_items AS oi ON oi.order_id = o.id
INNER JOIN menu_items AS m ON m.id = oi.menu_item_id
WHERE o.id = 1
ORDER BY oi.id;

-- Q09: 모든 고객의 주문 이력 수를 집계하며 미주문 고객은 0으로 표시한다.
SELECT c.id AS customer_id, c.name, COUNT(o.id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id
GROUP BY c.id, c.name
ORDER BY order_count DESC, c.id;

-- Q10: 결제 완료 주문만 대상으로 메뉴별 판매 수량과 매출을 집계한다.
SELECT m.id AS menu_id, m.name,
       SUM(oi.quantity) AS sold_quantity,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM menu_items AS m
INNER JOIN order_items AS oi ON oi.menu_item_id = m.id
INNER JOIN orders AS o ON o.id = oi.order_id
WHERE o.status = 'PAID'
GROUP BY m.id, m.name
ORDER BY revenue DESC, m.id;

-- Q11: 결제 완료 주문의 총액을 먼저 구한 후 날짜별 평균 주문 금액을 계산한다.
SELECT totals.ordered_on,
       COUNT(*) AS paid_order_count,
       AVG(totals.order_total) AS average_order_amount
FROM (
    SELECT o.id, o.ordered_on,
           SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders AS o
    INNER JOIN order_items AS oi ON oi.order_id = o.id
    WHERE o.status = 'PAID'
    GROUP BY o.id, o.ordered_on
) AS totals
GROUP BY totals.ordered_on
ORDER BY totals.ordered_on;

-- Q12: 현재 전체 메뉴 평균 가격보다 비싼 메뉴를 조회한다.
SELECT id, name, price
FROM menu_items
WHERE price > (SELECT AVG(price) FROM menu_items)
ORDER BY price DESC, id;

-- Q13: 아메리카노 현재 가격만 수정하고 확인 후 실습 변경을 취소한다.
BEGIN;
SELECT id, name, price FROM menu_items WHERE id = 1;
UPDATE menu_items SET price = 4200 WHERE id = 1;
-- SQLite 전용: 바로 앞 UPDATE가 영향 준 행 수
SELECT changes() AS changed_rows;
SELECT id, name, price FROM menu_items WHERE id = 1;
SELECT id, unit_price FROM order_items WHERE menu_item_id = 1 ORDER BY id;
ROLLBACK;
SELECT id, name, price FROM menu_items WHERE id = 1;

-- Q14: 주문이 없는 고객 10번만 삭제하고 확인 후 변경을 취소한다.
BEGIN;
SELECT id, name FROM customers WHERE id = 10;
DELETE FROM customers
WHERE id = 10
  AND NOT EXISTS (
      SELECT 1 FROM orders WHERE orders.customer_id = customers.id
  );
-- SQLite 전용: 바로 앞 DELETE가 영향 준 행 수
SELECT changes() AS deleted_rows;
SELECT COUNT(*) AS remaining_target FROM customers WHERE id = 10;
ROLLBACK;
SELECT id, name FROM customers WHERE id = 10;

-- Q15: orders.customer_id 조건으로 주문을 검색하거나 조인할 때 탐색 성능을 높이기 위해 인덱스를 만든다.
-- SQLite 전용: 조회 계획을 확인한다.
EXPLAIN QUERY PLAN SELECT id FROM orders WHERE customer_id = 1;
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
-- SQLite 전용: 생성된 인덱스 목록과 변경 후 조회 계획을 확인한다.
PRAGMA index_list('orders');
EXPLAIN QUERY PLAN SELECT id FROM orders WHERE customer_id = 1;
SELECT id FROM orders WHERE customer_id = 1 ORDER BY id;
