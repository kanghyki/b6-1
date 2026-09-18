BEGIN;

INSERT INTO customers (id, name, email) VALUES
    (1, '김하나', 'hana@example.test'),
    (2, '이두리', 'duri@example.test'),
    (3, '박세봄', 'sebom@example.test'),
    (4, '최나래', 'narae@example.test'),
    (5, '정다온', 'daon@example.test'),
    (6, '강여름', 'summer@example.test'),
    (7, '조가을', 'autumn@example.test'),
    (8, '윤겨울', 'winter@example.test'),
    (9, '장바다', 'sea@example.test'),
    (10, '임하늘', 'sky@example.test');

INSERT INTO menu_items (id, name, price) VALUES
    (1, '아메리카노', 4000),
    (2, '카페라떼', 4500),
    (3, '바닐라라떼', 5000),
    (4, '카푸치노', 4500),
    (5, '카페모카', 5500),
    (6, '초콜릿', 5000),
    (7, '녹차', 4000),
    (8, '레몬에이드', 5500),
    (9, '치즈케이크', 6500),
    (10, '크루아상', 3500);

INSERT INTO orders (id, customer_id, ordered_on, status) VALUES
    (1, 1, '2026-09-01', 'PAID'),
    (2, 2, '2026-09-01', 'PAID'),
    (3, 1, '2026-09-02', 'PAID'),
    (4, 3, '2026-09-02', 'CANCELLED'),
    (5, 4, '2026-09-03', 'PAID'),
    (6, 5, '2026-09-03', 'PAID'),
    (7, 2, '2026-09-04', 'PAID'),
    (8, 6, '2026-09-04', 'PAID'),
    (9, 7, '2026-09-05', 'CANCELLED'),
    (10, 8, '2026-09-05', 'PAID'),
    (11, 3, '2026-09-06', 'PAID'),
    (12, 1, '2026-09-06', 'PAID');

INSERT INTO order_items (id, order_id, menu_item_id, quantity, unit_price) VALUES
    (1, 1, 1, 2, 3800),
    (2, 1, 9, 1, 6500),
    (3, 2, 2, 1, 4500),
    (4, 2, 10, 2, 3500),
    (5, 3, 3, 1, 5000),
    (6, 3, 10, 1, 3500),
    (7, 4, 5, 1, 5500),
    (8, 5, 1, 1, 4000),
    (9, 5, 4, 1, 4500),
    (10, 6, 6, 2, 5000),
    (11, 7, 8, 1, 5500),
    (12, 7, 9, 1, 6500),
    (13, 8, 7, 1, 4000),
    (14, 8, 10, 1, 3500),
    (15, 9, 2, 2, 4500),
    (16, 10, 5, 1, 5500),
    (17, 10, 9, 1, 6500),
    (18, 11, 3, 2, 5000),
    (19, 11, 10, 1, 3500),
    (20, 12, 1, 1, 4000),
    (21, 12, 2, 1, 4500);

COMMIT;