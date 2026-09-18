BEGIN;

INSERT INTO customers (id, name, email) VALUES
    (1, 'Kim Hana', 'hana@example.test'),
    (2, 'Lee Duri', 'duri@example.test'),
    (3, 'Park Sebom', 'sebom@example.test'),
    (4, 'Choi Narae', 'narae@example.test'),
    (5, 'Jung Daon', 'daon@example.test'),
    (6, 'Kang Yeoreum', 'summer@example.test'),
    (7, 'Jo Gaeul', 'autumn@example.test'),
    (8, 'Yoon Gyeoul', 'winter@example.test'),
    (9, 'Jang Bada', 'sea@example.test'),
    (10, 'Im Haneul', 'sky@example.test');

INSERT INTO menu_items (id, name, price) VALUES
    (1, 'Americano', 4000),
    (2, 'Cafe Latte', 4500),
    (3, 'Vanilla Latte', 5000),
    (4, 'Cappuccino', 4500),
    (5, 'Cafe Mocha', 5500),
    (6, 'Chocolate', 5000),
    (7, 'Green Tea', 4000),
    (8, 'Lemonade', 5500),
    (9, 'Cheesecake', 6500),
    (10, 'Croissant', 3500);

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