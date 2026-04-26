use the_end;

SELECT 
    COUNT(*) as total_orders,
    COUNT(DISTINCT customer_name) as unique_customers,
    SUM(sale_amount) as total_revenue,
    ROUND(AVG(sale_amount), 2) as avg_order_value
FROM sales
WHERE sale_amount IS NOT NULL;

SELECT 
    product,
    COUNT(*) as orders,
    SUM(sale_amount) as revenue,
    ROUND(SUM(sale_amount) * 100.0 / (SELECT SUM(sale_amount) FROM sales WHERE sale_amount IS NOT NULL), 1) as revenue_percentage
FROM sales
WHERE sale_amount IS NOT NULL
GROUP BY product
ORDER BY revenue DESC;

SELECT 
    customer_name,
    COUNT(*) as purchases,
    SUM(sale_amount) as total_spent,
    ROUND(AVG(sale_amount), 2) as avg_purchase_value
FROM sales
WHERE sale_amount IS NOT NULL
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') as month,
    COUNT(*) as orders,
    SUM(sale_amount) as monthly_revenue,
    ROUND(AVG(sale_amount), 2) as avg_order_value
FROM sales
WHERE sale_amount IS NOT NULL
GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
ORDER BY month;

SELECT 
    CONCAT(e.first_name, ' ', e.last_name) as sales_rep,
    COUNT(s.sale_id) as deals_closed,
    COALESCE(SUM(s.sale_amount), 0) as total_revenue,
    ROUND(AVG(s.sale_amount), 2) as avg_deal_size
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.employee_id
WHERE e.department = 'Sales'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_revenue DESC;

SELECT 
    COUNT(DISTINCT customer_name) as total_customers,
    SUM(CASE WHEN purchase_count > 1 THEN 1 ELSE 0 END) as repeat_customers,
    ROUND(SUM(CASE WHEN purchase_count > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as repeat_rate
FROM (
    SELECT customer_name, COUNT(*) as purchase_count
    FROM sales
    WHERE sale_amount IS NOT NULL
    GROUP BY customer_name
) customer_stats;













