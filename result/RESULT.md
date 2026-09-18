
-- SQLite 전용: FK 검사 활성화. BEGIN 이전에 실행합니다.
PRAGMA foreign_keys = ON;

-- Q01: 현재 가격이 5,000원 이상인 메뉴를 조회한다.
SELECT id, name, price
FROM menu_items
WHERE price >= 5000
ORDER BY id;
┌────┬───────────────┬───────┐
│ id │     name      │ price │
├────┼───────────────┼───────┤
│ 3  │ Vanilla Latte │ 5000  │
│ 5  │ Cafe Mocha    │ 5500  │
│ 6  │ Chocolate     │ 5000  │
│ 8  │ Lemonade      │ 5500  │
│ 9  │ Cheesecake    │ 6500  │
└────┴───────────────┴───────┘

-- Q02: 메뉴를 가격 내림차순, 번호 오름차순으로 정렬한다.
SELECT id, name, price
FROM menu_items
ORDER BY price DESC, id ASC;
┌────┬───────────────┬───────┐
│ id │     name      │ price │
├────┼───────────────┼───────┤
│ 9  │ Cheesecake    │ 6500  │
│ 5  │ Cafe Mocha    │ 5500  │
│ 8  │ Lemonade      │ 5500  │
│ 3  │ Vanilla Latte │ 5000  │
│ 6  │ Chocolate     │ 5000  │
│ 2  │ Cafe Latte    │ 4500  │
│ 4  │ Cappuccino    │ 4500  │
│ 1  │ Americano     │ 4000  │
│ 7  │ Green Tea     │ 4000  │
│ 10 │ Croissant     │ 3500  │
└────┴───────────────┴───────┘

-- Q03: 최근 주문 세 건을 날짜와 주문 번호 역순으로 조회한다.
SELECT id, customer_id, ordered_on, status
FROM orders
ORDER BY ordered_on DESC, id DESC
LIMIT 3;
┌────┬─────────────┬────────────┬────────┐
│ id │ customer_id │ ordered_on │ status │
├────┼─────────────┼────────────┼────────┤
│ 12 │ 1           │ 2026-09-06 │ PAID   │
│ 11 │ 3           │ 2026-09-06 │ PAID   │
│ 10 │ 8           │ 2026-09-05 │ PAID   │
└────┴─────────────┴────────────┴────────┘

-- Q04: 이름에 라떼가 포함되고 가격이 5,000원 이하인 메뉴를 찾는다.
SELECT id, name, price
FROM menu_items
WHERE name LIKE '%Latte%' AND price <= 5000
ORDER BY id;
┌────┬───────────────┬───────┐
│ id │     name      │ price │
├────┼───────────────┼───────┤
│ 2  │ Cafe Latte    │ 4500  │
│ 3  │ Vanilla Latte │ 5000  │
└────┴───────────────┴───────┘

-- Q05: 모든 주문에 주문자의 이름을 붙여 조회한다.
SELECT o.id AS order_id, c.name AS customer_name, o.ordered_on, o.status
FROM orders AS o
INNER JOIN customers AS c ON c.id = o.customer_id
ORDER BY o.id;
┌──────────┬───────────────┬────────────┬───────────┐
│ order_id │ customer_name │ ordered_on │  status   │
├──────────┼───────────────┼────────────┼───────────┤
│ 1        │ Kim Hana      │ 2026-09-01 │ PAID      │
│ 2        │ Lee Duri      │ 2026-09-01 │ PAID      │
│ 3        │ Kim Hana      │ 2026-09-02 │ PAID      │
│ 4        │ Park Sebom    │ 2026-09-02 │ CANCELLED │
│ 5        │ Choi Narae    │ 2026-09-03 │ PAID      │
│ 6        │ Jung Daon     │ 2026-09-03 │ PAID      │
│ 7        │ Lee Duri      │ 2026-09-04 │ PAID      │
│ 8        │ Kang Yeoreum  │ 2026-09-04 │ PAID      │
│ 9        │ Jo Gaeul      │ 2026-09-05 │ CANCELLED │
│ 10       │ Yoon Gyeoul   │ 2026-09-05 │ PAID      │
│ 11       │ Park Sebom    │ 2026-09-06 │ PAID      │
│ 12       │ Kim Hana      │ 2026-09-06 │ PAID      │
└──────────┴───────────────┴────────────┴───────────┘

-- Q06: 상세별 메뉴 이름, 수량, 주문 당시 단가와 금액을 조회한다.
SELECT oi.id AS detail_id, oi.order_id, m.name,
       oi.quantity, oi.unit_price,
       oi.quantity * oi.unit_price AS line_amount
FROM order_items AS oi
INNER JOIN menu_items AS m ON m.id = oi.menu_item_id
ORDER BY oi.id;
┌───────────┬──────────┬───────────────┬──────────┬────────────┬─────────────┐
│ detail_id │ order_id │     name      │ quantity │ unit_price │ line_amount │
├───────────┼──────────┼───────────────┼──────────┼────────────┼─────────────┤
│ 1         │ 1        │ Americano     │ 2        │ 3800       │ 7600        │
│ 2         │ 1        │ Cheesecake    │ 1        │ 6500       │ 6500        │
│ 3         │ 2        │ Cafe Latte    │ 1        │ 4500       │ 4500        │
│ 4         │ 2        │ Croissant     │ 2        │ 3500       │ 7000        │
│ 5         │ 3        │ Vanilla Latte │ 1        │ 5000       │ 5000        │
│ 6         │ 3        │ Croissant     │ 1        │ 3500       │ 3500        │
│ 7         │ 4        │ Cafe Mocha    │ 1        │ 5500       │ 5500        │
│ 8         │ 5        │ Americano     │ 1        │ 4000       │ 4000        │
│ 9         │ 5        │ Cappuccino    │ 1        │ 4500       │ 4500        │
│ 10        │ 6        │ Chocolate     │ 2        │ 5000       │ 10000       │
│ 11        │ 7        │ Lemonade      │ 1        │ 5500       │ 5500        │
│ 12        │ 7        │ Cheesecake    │ 1        │ 6500       │ 6500        │
│ 13        │ 8        │ Green Tea     │ 1        │ 4000       │ 4000        │
│ 14        │ 8        │ Croissant     │ 1        │ 3500       │ 3500        │
│ 15        │ 9        │ Cafe Latte    │ 2        │ 4500       │ 9000        │
│ 16        │ 10       │ Cafe Mocha    │ 1        │ 5500       │ 5500        │
│ 17        │ 10       │ Cheesecake    │ 1        │ 6500       │ 6500        │
│ 18        │ 11       │ Vanilla Latte │ 2        │ 5000       │ 10000       │
│ 19        │ 11       │ Croissant     │ 1        │ 3500       │ 3500        │
│ 20        │ 12       │ Americano     │ 1        │ 4000       │ 4000        │
│ 21        │ 12       │ Cafe Latte    │ 1        │ 4500       │ 4500        │
└───────────┴──────────┴───────────────┴──────────┴────────────┴─────────────┘

-- Q07: 주문이 없는 고객까지 포함해 고객과 주문을 조회한다.
SELECT c.id AS customer_id, c.name, o.id AS order_id
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id
ORDER BY c.id, o.id;
┌─────────────┬──────────────┬──────────┐
│ customer_id │     name     │ order_id │
├─────────────┼──────────────┼──────────┤
│ 1           │ Kim Hana     │ 1        │
│ 1           │ Kim Hana     │ 3        │
│ 1           │ Kim Hana     │ 12       │
│ 2           │ Lee Duri     │ 2        │
│ 2           │ Lee Duri     │ 7        │
│ 3           │ Park Sebom   │ 4        │
│ 3           │ Park Sebom   │ 11       │
│ 4           │ Choi Narae   │ 5        │
│ 5           │ Jung Daon    │ 6        │
│ 6           │ Kang Yeoreum │ 8        │
│ 7           │ Jo Gaeul     │ 9        │
│ 8           │ Yoon Gyeoul  │ 10       │
│ 9           │ Jang Bada    │ NULL     │
│ 10          │ Im Haneul    │ NULL     │
└─────────────┴──────────────┴──────────┘

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
┌──────────┬───────────────┬────────────┬────────────┬──────────┬────────────┬─────────────┐
│ order_id │ customer_name │ ordered_on │ menu_name  │ quantity │ unit_price │ line_amount │
├──────────┼───────────────┼────────────┼────────────┼──────────┼────────────┼─────────────┤
│ 1        │ Kim Hana      │ 2026-09-01 │ Americano  │ 2        │ 3800       │ 7600        │
│ 1        │ Kim Hana      │ 2026-09-01 │ Cheesecake │ 1        │ 6500       │ 6500        │
└──────────┴───────────────┴────────────┴────────────┴──────────┴────────────┴─────────────┘

-- Q09: 모든 고객의 주문 이력 수를 집계하며 미주문 고객은 0으로 표시한다.
SELECT c.id AS customer_id, c.name, COUNT(o.id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.id
GROUP BY c.id, c.name
ORDER BY order_count DESC, c.id;
┌─────────────┬──────────────┬─────────────┐
│ customer_id │     name     │ order_count │
├─────────────┼──────────────┼─────────────┤
│ 1           │ Kim Hana     │ 3           │
│ 2           │ Lee Duri     │ 2           │
│ 3           │ Park Sebom   │ 2           │
│ 4           │ Choi Narae   │ 1           │
│ 5           │ Jung Daon    │ 1           │
│ 6           │ Kang Yeoreum │ 1           │
│ 7           │ Jo Gaeul     │ 1           │
│ 8           │ Yoon Gyeoul  │ 1           │
│ 9           │ Jang Bada    │ 0           │
│ 10          │ Im Haneul    │ 0           │
└─────────────┴──────────────┴─────────────┘

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
┌─────────┬───────────────┬───────────────┬─────────┐
│ menu_id │     name      │ sold_quantity │ revenue │
├─────────┼───────────────┼───────────────┼─────────┤
│ 9       │ Cheesecake    │ 3             │ 19500   │
│ 10      │ Croissant     │ 5             │ 17500   │
│ 1       │ Americano     │ 4             │ 15600   │
│ 3       │ Vanilla Latte │ 3             │ 15000   │
│ 6       │ Chocolate     │ 2             │ 10000   │
│ 2       │ Cafe Latte    │ 2             │ 9000    │
│ 5       │ Cafe Mocha    │ 1             │ 5500    │
│ 8       │ Lemonade      │ 1             │ 5500    │
│ 4       │ Cappuccino    │ 1             │ 4500    │
│ 7       │ Green Tea     │ 1             │ 4000    │
└─────────┴───────────────┴───────────────┴─────────┘

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
┌────────────┬──────────────────┬──────────────────────┐
│ ordered_on │ paid_order_count │ average_order_amount │
├────────────┼──────────────────┼──────────────────────┤
│ 2026-09-01 │ 2                │ 12800.0              │
│ 2026-09-02 │ 1                │ 8500.0               │
│ 2026-09-03 │ 2                │ 9250.0               │
│ 2026-09-04 │ 2                │ 9750.0               │
│ 2026-09-05 │ 1                │ 12000.0              │
│ 2026-09-06 │ 2                │ 11000.0              │
└────────────┴──────────────────┴──────────────────────┘

-- Q12: 현재 전체 메뉴 평균 가격보다 비싼 메뉴를 조회한다.
SELECT id, name, price
FROM menu_items
WHERE price > (SELECT AVG(price) FROM menu_items)
ORDER BY price DESC, id;
┌────┬───────────────┬───────┐
│ id │     name      │ price │
├────┼───────────────┼───────┤
│ 9  │ Cheesecake    │ 6500  │
│ 5  │ Cafe Mocha    │ 5500  │
│ 8  │ Lemonade      │ 5500  │
│ 3  │ Vanilla Latte │ 5000  │
│ 6  │ Chocolate     │ 5000  │
└────┴───────────────┴───────┘

-- Q13: 아메리카노 현재 가격만 수정하고 확인 후 실습 변경을 취소한다.
BEGIN;
SELECT id, name, price FROM menu_items WHERE id = 1;
┌────┬───────────┬───────┐
│ id │   name    │ price │
├────┼───────────┼───────┤
│ 1  │ Americano │ 4000  │
└────┴───────────┴───────┘
UPDATE menu_items SET price = 4200 WHERE id = 1;
-- SQLite 전용: 바로 앞 UPDATE가 영향 준 행 수
SELECT changes() AS changed_rows;
┌──────────────┐
│ changed_rows │
├──────────────┤
│ 1            │
└──────────────┘
SELECT id, name, price FROM menu_items WHERE id = 1;
┌────┬───────────┬───────┐
│ id │   name    │ price │
├────┼───────────┼───────┤
│ 1  │ Americano │ 4200  │
└────┴───────────┴───────┘
SELECT id, unit_price FROM order_items WHERE menu_item_id = 1 ORDER BY id;
┌────┬────────────┐
│ id │ unit_price │
├────┼────────────┤
│ 1  │ 3800       │
│ 8  │ 4000       │
│ 20 │ 4000       │
└────┴────────────┘
ROLLBACK;
SELECT id, name, price FROM menu_items WHERE id = 1;
┌────┬───────────┬───────┐
│ id │   name    │ price │
├────┼───────────┼───────┤
│ 1  │ Americano │ 4000  │
└────┴───────────┴───────┘

-- Q14: 주문이 없는 고객 10번만 삭제하고 확인 후 변경을 취소한다.
BEGIN;
SELECT id, name FROM customers WHERE id = 10;
┌────┬───────────┐
│ id │   name    │
├────┼───────────┤
│ 10 │ Im Haneul │
└────┴───────────┘
DELETE FROM customers
WHERE id = 10
  AND NOT EXISTS (
      SELECT 1 FROM orders WHERE orders.customer_id = customers.id
  );
-- SQLite 전용: 바로 앞 DELETE가 영향 준 행 수
SELECT changes() AS deleted_rows;
┌──────────────┐
│ deleted_rows │
├──────────────┤
│ 1            │
└──────────────┘
SELECT COUNT(*) AS remaining_target FROM customers WHERE id = 10;
┌──────────────────┐
│ remaining_target │
├──────────────────┤
│ 0                │
└──────────────────┘
ROLLBACK;
SELECT id, name FROM customers WHERE id = 10;
┌────┬───────────┐
│ id │   name    │
├────┼───────────┤
│ 10 │ Im Haneul │
└────┴───────────┘

-- Q15: orders.customer_id 조건으로 주문을 검색하거나 조인할 때 탐색 성능을 높이기 위해 인덱스를 만든다.
-- SQLite 전용: 쿼리 플랜을 확인합니다.
EXPLAIN QUERY PLAN SELECT id FROM orders WHERE customer_id = 1;
QUERY PLAN
`--SCAN orders
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
-- SQLite 전용: 테이블의 인덱스 목록을 확인합니다.
PRAGMA index_list('orders');
┌─────┬────────────────────────┬────────┬────────┬─────────┐
│ seq │          name          │ unique │ origin │ partial │
├─────┼────────────────────────┼────────┼────────┼─────────┤
│ 0   │ idx_orders_customer_id │ 0      │ c      │ 0       │
└─────┴────────────────────────┴────────┴────────┴─────────┘
EXPLAIN QUERY PLAN SELECT id FROM orders WHERE customer_id = 1;
QUERY PLAN
`--SEARCH orders USING COVERING INDEX idx_orders_customer_id (customer_id=?)
SELECT id FROM orders WHERE customer_id = 1 ORDER BY id;
┌────┐
│ id │
├────┤
│ 1  │
│ 3  │
│ 12 │
└────┘
