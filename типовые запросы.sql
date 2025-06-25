-- ===========================
-- 1. Поиск доступных автомобилей для аренды
-- ===========================

-- Отображает все автомобили, которые можно арендовать прямо сейчас:

SELECT id, model, mileage, rental_price_per_day
FROM cars
WHERE status = 'available';

-- ===========================
-- 2. История аренд конкретного клиента
-- ===========================

-- Показывает, какие машины арендовал клиент, с датами и итоговой суммой:

SELECT r.id AS rental_id, c.model, r.rental_start, r.rental_end, r.total
FROM rentals r
JOIN cars c ON r.car_id = c.id
WHERE r.client_id = 1;

-- ===========================
-- 3. Расчет общей выручки за период
-- ===========================

SELECT SUM(total) AS total_income
FROM rentals
WHERE rental_start >= '2025-06-01' AND rental_start <= '2025-06-30';

-- ===========================
-- 4. Выдача аренд, оформленных конкретным менеджером
-- ===========================

-- Пример вызова:

SELECT m.full_name, COUNT(*) AS rentals_count, SUM(r.total) AS total_earned
FROM rentals r
JOIN managers m ON r.manager_id = m.id
GROUP BY r.manager_id;

-- ===========================
-- 4. 5. Список автомобилей, находящихся в ремонте
-- ===========================

-- Пример вызова: Выводит машины, которые недоступны из-за техобслуживания:

SELECT id, model, mileage
FROM cars
WHERE status = 'maintenance';