CREATE TABLE  pbi-kimia-farma-424406.Dataset.analytics_table AS
SELECT 
  ft.transaction_id, 
  ft.date, 
  ft.branch_id, 
  kc.branch_name, 
  kc.kota, 
  kc.provinsi, 
  kc.rating as rating_cabang,
  ft.customer_name, 
  p.product_id, 
  p.product_name, 
  p.price as actual_price,
  ft.discount_percentage,
  CASE
      WHEN p.price <= 50000 THEN 0.1
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
      ELSE 0.30
  END AS persentase_gross_laba,
  p.price*(1-discount_percentage) as nett_sales,
  (p.price*(1-discount_percentage) *
  CASE
      WHEN p.price <= 50000 THEN 0.1
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
      ELSE 0.30
  END) AS nett_profit,
  ft.rating as rating_transaksi
FROM pbi-kimia-farma-424406.Dataset.kf_product as p

RIGHT JOIN pbi-kimia-farma-424406.Dataset.kf_final_transaction as ft ON p.product_id=ft.product_id

LEFT JOIN pbi-kimia-farma-424406.Dataset.kf_kantor_cabang as kc ON ft.branch_id=kc.branch_id;
