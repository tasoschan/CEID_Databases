/*1*/
SELECT mobo_model,COUNT(*) AS total_cpus FROM CPU,motherboard WHERE cpu_socket=mobo_socket GROUP BY mobo_model ORDER BY count(*) ASC;
/*2*/
SELECT admin_ranking,AVG(monthly_wage) AS average_wage FROM `Admin` INNER JOIN Salary ON admin_salary=admin_id WHERE s_month <= 03 GROUP BY admin_ranking;
/*3*/
SELECT hd_type,hd_model,hd_capacity_in_GB,hd_price,hd_connection,COUNT(order_hd) FROM HD INNER JOIN `Order` ON order_hd=hd_model GROUP BY hd_model ORDER BY hd_type;
/*4*/
SELECT CONCAT(psu_model," ",psu_pwr_in_Watt) AS "'psu_model' with 'psu_watts'",COUNT(*) FROM PSU INNER JOIN `Order` ON order_psu=psu_model WHERE psu_model NOT LIKE "%Plus%" AND psu_model=order_psu ORDER BY COUNT(*) DESC LIMIT 0,3;
/*5*/
SELECT customer_name,customer_surname,COUNT(order_code) FROM Customer INNER JOIN `Order` ON customer_id_order=customer_id GROUP BY customer_name ORDER BY COUNT(order_code) DESC;
/*6*/
SELECT CONCAT(a.admin_name," ",a.admin_surname) AS Senior,CONCAT(b.admin_name," ",b.admin_surname) AS Junior FROM `Admin` AS a INNER JOIN `Admin` AS b ON b.admin_supervised_by=a.admin_id WHERE a.admin_ranking LIKE "Senior";