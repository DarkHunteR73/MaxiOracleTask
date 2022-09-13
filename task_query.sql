SELECT a.address, 
	CAST(SUM(r.addr_id) / r.addr_id AS UNSIGNED) count_of_residents
    
FROM address a 
	LEFT JOIN residents r 
	ON a.id = r.addr_id
    
GROUP BY a.address
ORDER BY count_of_residents DESC