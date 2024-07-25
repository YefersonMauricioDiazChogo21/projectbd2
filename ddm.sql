INSERT INTO country (name_country) VALUES ('Colombia');

INSERT INTO city (name_city, id_country) VALUES 
('Bogotá', 1),
('Medellín', 1),
('Cali', 1),
('Barranquilla', 1),
('Cartagena', 1),
('Bucaramanga', 1),
('Pereira', 1),
('Manizales', 1),
('Santa Marta', 1),
('Villavicencio', 1);

INSERT INTO bike_brand (brand_name) VALUES 
('Trek'),
('Specialized'),
('Cannondale'),
('Giant'),
('Scott');

INSERT INTO bike_model (model_name, id_bike_brand) VALUES 
('Domane', 1),
('Stumpjumper', 2),
('Synapse', 3),
('Defy', 4),
('Spark', 5);

INSERT INTO bike (id_bike_model, id_bike_brand , price, stock) VALUES 
(1, 1, 1500.00, 10),
(2, 2, 2500.00, 5),
(3, 3, 1800.00, 7),
(4, 4, 2000.00, 8),
(5, 5, 2200.00, 6);

INSERT INTO customer (id,customer_name, email, phone, id_city) VALUES 
(1,'Juan Pérez', 'juan.perez@hotmail.com', 3001233567, 1);
(2,'María García', 'maria.garcia@hotmail.com', 3002345678, 2),
(3,'Carlos López', 'carlos.lopez@outlook.com', 3003456789, 3),
(4,'Ana Martínez', 'ana.martinez@yahoo.com', 3004567890, 4),
(5,'Luis Rodríguez', 'luis.rodriguez@gmail.com', 3005678901, 5);

INSERT INTO supplier (supplier_name, contact_name, phone, email, id_city) VALUES 
('Supplier A', 'Contact A', 3001112222, 'contacta@suppliera.com', 1),
('Supplier B', 'Contact B', 3002223333, 'contactb@supplierb.com', 2),
('Supplier C', 'Contact C', 3003334444, 'contactc@supplierc.com', 3),
('Supplier D', 'Contact D', 3004445555, 'contactd@supplierd.com', 4),
('Supplier E', 'Contact E', 3005556666, 'contacte@suppliere.com', 5);

INSERT INTO replacement (replacement_name, replacement_description, price, stock, id_supplier) VALUES 
('Chain', 'Bicycle chain', 20.00, 50, 1),
('Brake Pads', 'Brake pads for mountain bikes', 15.00, 100, 2),
('Tire', '26 inch bicycle tire', 30.00, 70, 3),
('Seat', 'Comfortable bicycle seat', 40.00, 30, 4),
('Handlebar', 'Carbon fiber handlebar', 100.00, 20, 5);

INSERT INTO purchase (purchase_date, id_supplier, total) VALUES 
('2023-07-01', 1, 1000.00),
('2023-07-02', 2, 1500.00),
('2023-07-03', 3, 1200.00),
('2023-07-04', 4, 1300.00),
('2023-07-05', 5, 1100.00);

INSERT INTO purchase_detail (id_purchase, id_replacement, amount, unit_price) VALUES 
(1, 1, 10, 20.00),
(2, 2, 50, 15.00),
(3, 3, 20, 30.00),
(4, 4, 10, 40.00),
(5, 5, 5, 100.00);

INSERT INTO sale (sale_date, id_customer, total) VALUES 
('2023-07-10', 1, 1500.00),
('2023-07-11', 2, 2500.00),
('2023-07-12', 3, 1800.00),
('2023-07-13', 4, 2000.00),
('2023-07-14', 5, 2200.00);

INSERT INTO sale_detail (id_sale, id_bike, amount, unit_price) VALUES 
(1, 1, 1, 1500.00),
(2, 2, 1, 2500.00),
(3, 3, 1, 1800.00),
(4, 4, 1, 2000.00),
(5, 5, 1, 2200.00);
