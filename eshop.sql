DROP DATABASE IF EXISTS eshop;
CREATE DATABASE eshop;
USE eshop;

/*2.1*/

CREATE TABLE CPU(
cpu_model VARCHAR(30) NOT NULL,
cpu_brand ENUM('AMD', 'Intel') NOT NULL,
cpu_frequency_in_GHz DOUBLE(6,2) NOT NULL,
cpu_cores INT NOT NULL,
cpu_threads INT NOT NULL,
cpu_socket VARCHAR(30) NOT NULL,
cpu_L1_cache INT NOT NULL,
cpu_pwr_consumption DOUBLE(6,2) NOT NULL,
cpu_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY(cpu_model)
) engine=InnoDB;

CREATE TABLE Motherboard(
mobo_model VARCHAR(30) NOT NULL,
mobo_brand VARCHAR(30) NOT NULL,
mobo_socket VARCHAR(30) NOT NULL,
mobo_ram_max_frequency_in_mhz DOUBLE(6,2) NOT NULL,
mobo_ram_slots INT NOT NULL,
mobo_ram_type ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
mobo_form_factor ENUM('uATX/Micro ATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
mobo_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY(mobo_model)
) engine=InnoDB;

CREATE TABLE RAM(
ram_model VARCHAR(30) NOT NULL,
ram_brand VARCHAR(30) NOT NULL,
ram_type ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
ram_frequency_in_mhz DOUBLE(6,2) NOT NULL,
ram_capacity_in_GB INT NOT NULL,
ram_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY(ram_model)
) engine=InnoDB;

CREATE TABLE GPU(
gpu_model VARCHAR(30) NOT NULL,
gpu_brand VARCHAR(30) NOT NULL,
gpu_manufacturer ENUM('AMD', 'NVIDIA'),
gpu_connections SET('DVI-D', 'DVI-I', 'VGA', 'Mini HDMI', 'HDMI', 'Display Port', 'Mini DisplayPort') NOT NULL, 
gpu_memory_capacity_in_GB INT NOT NULL,
gpu_memory_type ENUM('GDDR3', 'GDDR4', 'GDDR5') NOT NULL,
gpu_frequency_in_mhz DOUBLE(6,2) NOT NULL,
gpu_memory_frequency_in_mhz DOUBLE(6,2) NOT NULL,
gpu_pwr_consumption_in_Watt DOUBLE(6,2) NOT NULL,
gpu_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY(gpu_model)
) engine=InnoDB;

CREATE TABLE PSU(
psu_model VARCHAR(30) NOT NULL,
psu_brand VARCHAR(30) NOT NULL,
psu_pwr_in_Watt INT NOT NULL,
psu_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY (psu_model)
) engine=InnoDB;

CREATE TABLE `Case`(
case_model VARCHAR(30) NOT NULL,
case_brand VARCHAR(30) NOT NULL,
case_price DOUBLE(6,2) NOT NULL,
case_size ENUM('Midi', 'Mini', 'Full Tower', 'Ultra Tower', 'Micro') NOT NULL,
case_form_factor SET('uATX/Micro ATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
PRIMARY KEY (case_model)
) engine=InnoDB;

CREATE TABLE HD(
hd_model VARCHAR(30) NOT NULL,
hd_brand VARCHAR(30) NOT NULL,
hd_capacity_in_GB INT NOT NULL,
hd_connection VARCHAR(30) NOT NULL,
hd_type VARCHAR(30) NOT NULL,
hd_form_factor ENUM('2,5"', '3.5"', 'mSATA') NOT NULL,
hd_price DOUBLE(6,2) NOT NULL,
PRIMARY KEY (hd_model)
) engine=InnoDB;

CREATE TABLE SSD(
ssd_model VARCHAR(30) NOT NULL,
ssd_connection VARCHAR(30) NOT NULL,
ssd_wspeed_in_MBs INT NOT NULL,
ssd_rspeed_in_MBs INT NOT NULL,
PRIMARY KEY (ssd_model),
CONSTRAINT SSDS 
FOREIGN KEY (ssd_model) REFERENCES HD(hd_model)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE HDD(
hdd_model VARCHAR(30) NOT NULL,
hdd_connection VARCHAR(30) NOT NULL,
hdd_cache_in_MB INT NOT NULL,
hdd_RPM INT NOT NULL,
PRIMARY KEY (hdd_model),
CONSTRAINT HDDS
FOREIGN KEY (hdd_model) REFERENCES HD(hd_model)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE extHD(
extHD_model VARCHAR(30) NOT NULL,
extHD_connection VARCHAR(30) NOT NULL,
extHD_PSU ENUM('Yes', 'No'),
PRIMARY KEY (extHD_model),
CONSTRAINT EXTHDS
FOREIGN KEY (extHD_model) REFERENCES HD(hd_model)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

/*2.2*/

CREATE TABLE Customer(
customer_id INT NOT NULL AUTO_INCREMENT,
customer_name VARCHAR(30) NOT NULL,
customer_surname VARCHAR(30) NOT NULL,
customer_email VARCHAR(30) NOT NULL,
customer_tel VARCHAR(30) NOT NULL, 
customer_sub TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (customer_id)
) engine=InnoDB;

CREATE TABLE Card(
customer_card_id INT NOT NULL,
card_id INT NOT NULL AUTO_INCREMENT,
card_points INT DEFAULT 0,
card_used_points INT DEFAULT 0,
PRIMARY KEY(card_id),
CONSTRAINT CARDSSS
FOREIGN KEY (customer_card_id) REFERENCES Customer(customer_id)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE `Order`(
customer_id_order INT NOT NULL,
order_code INT NOT NULL AUTO_INCREMENT,
order_cpu VARCHAR(30),
order_mobo VARCHAR(30),
order_ram VARCHAR(30),
order_gpu VARCHAR(30),
order_psu VARCHAR(30),
order_case VARCHAR(30),
order_hd VARCHAR(30),
order_used_sbs ENUM('Yes', 'No') NOT NULL,
order_sum DOUBLE(6,2) DEFAULT 0,
PRIMARY KEY(order_code),
CONSTRAINT ORDERS
FOREIGN KEY (customer_id_order) REFERENCES Customer(customer_id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSS
FOREIGN KEY (order_cpu) REFERENCES CPU(cpu_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSS
FOREIGN KEY (order_mobo) REFERENCES Motherboard(mobo_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSSS
FOREIGN KEY (order_gpu) REFERENCES GPU(gpu_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSSSS
FOREIGN KEY (order_psu) REFERENCES PSU(psu_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSSSSS
FOREIGN KEY (order_case) REFERENCES `Case`(case_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSSSSSS
FOREIGN KEY (order_hd) REFERENCES HD(hd_model)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT ORDERSSSSSSSSSSSSS
FOREIGN KEY (order_ram) REFERENCES RAM(ram_model)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE `Admin`(
admin_id INT NOT NULL AUTO_INCREMENT,
admin_name VARCHAR(30) NOT NULL,
admin_surname VARCHAR(30) NOT NULL,
admin_email VARCHAR(30) NOT NULL,
admin_CV TINYTEXT NOT NULL,
admin_ranking ENUM('Senior', 'Junior') NOT NULL,
admin_supervised_by INT,
PRIMARY KEY (admin_id),
CONSTRAINT ADMINSUPSS
FOREIGN KEY (admin_supervised_by) REFERENCES `Admin`(admin_id)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;



CREATE TABLE Salary(
admin_salary INT NOT NULL,
salary_id INT NOT NULL AUTO_INCREMENT,
s_month INT(2) NOT NULL,
s_year INT(4) NOT NULL,
monthly_wage DOUBLE(6,2) NOT NULL,
PRIMARY KEY(salary_id),
CONSTRAINT SALARIESSSS
FOREIGN KEY (admin_salary) REFERENCES `Admin`(admin_id)
ON DELETE CASCADE ON UPDATE CASCADE
) engine=InnoDB;

/*3.1*/

INSERT INTO CPU VALUES
('Ryzen 5 1600', 'AMD', 3.20, 6, 12, 'AM4', 16, 65.00, 189.38),
('Ryzen 7 1700', 'AMD', 3.00, 8, 16, 'AM4', 32, 65.00, 276.76),
('Ryzen 3 1200', 'AMD', 3.10, 4, 4, 'AM4', 16, 65.00, 106.71),
('Pentium Dual Core G4560', 'Intel', 3.50, 2, 4, 'LGA 1151', 16, 54.00, 68.13),
('Core i7-7700K', 'Intel', 4.20, 4, 8, 'LGA 1151', 32, 91.00, 302.62),
('Ryzen 5 1400', 'AMD', 3.20, 4, 8, 'AM4', 16, 65.00, 148.44),
('Core i7-8700K', 'Intel', 3.70, 6, 12, 'LGA 1151', 64, 95.00, 398.83),
('Core i7-7600K', 'Intel', 3.80, 4, 4, 'LGA 1151', 32, 91.00, 213.85),
('Core i7-6700K', 'Intel', 4.00, 4, 8, 'LGA 1151', 32, 91.00, 299.99),
('Core i5-7500', 'Intel', 3.40, 4, 4, 'LGA 1151', 32, 65.00, 184.56);


INSERT INTO Motherboard VALUES
('AB350M Pro 4', 'Asrock', 'AM4', 3200.00, 4, 'DDR4', 'uATX/Micro ATX', 74.74),
('Rog Strix B350', 'Asus', 'AM4', 3200.00, 4, 'DDR4', 'ATX', 123.21),
('Prime B350', 'Asus', 'AM4', 3200.00, 4, 'DDR4', 'ATX', 100.23),
('B250M-DS3H', 'Gigabyte', 'AM4', 3200.00, 4, 'DDR4', 'uATX/Micro ATX', 70.00),
('Prime H110M-K', 'Asus', 'AM4', 3200.00, 2, 'DDR4', 'uATX/Micro ATX', 92.98),
('Z170-A', 'Asus', 'LGA 1151', 3200.00, 4, 'DDR4', 'ATX', 92.98),
('Prime X370 Pro', 'Asus', 'AM4', 3200.00, 4, 'DDR4', 'ATX', 161.98),
('AX370-Gaming K5', 'Gigabyte', 'AM4', 3200.00, 4, 'DDR4', 'ATX', 157.73),
('AB350-Gaming 3', 'Gigabyte', 'AM4', 3200.00, 4, 'DDR4', 'ATX', 107.98),
('970A-DS3P FX', 'Gigabyte', 'AM3+', 3200.00, 4, 'DDR3', 'ATX', 97.25);

INSERT INTO RAM VALUES
('Value Select', 'Corsair', 'DDR4', 2133.00, 8, 90.00),
('Ripjaws V', 'G.Skill', 'DDR4', 3200.00, 16, 202.00),
('Fury', 'Hyper X', 'DDR4', 2400.00, 8, 95.00),
('Aegis', 'G.Skill', 'DDR4', 3000.00, 8, 98.98),
('Vengeance', 'Corsair', 'DDR4', 2400.00, 16, 184.98),
('TridentZ', 'G.Skill', 'DDR4', 3200.00, 8, 70.00),
('CT102464BF160B', 'Crucial', 'DDR3 SO-DIMM', 1600.00, 8, 65.00),
('Fury Blue', 'Hyper X', 'DDR4', 1600.00, 4, 37.13),
('Ballistix Sport LT', 'Crucial', 'DDR4', 2400.00, 8, 88.46),
('ValueRAM', 'Kingston', 'DDR4', 1600.00, 4, 32.85); 

INSERT INTO GPU VALUES
('GTX 1050Ti Windforce', 'Gigabyte', 'NVIDIA', 'HDMI,DVI-I,DVI-D', 4, 'GDDR5', 800.00, 7008.00, 100.00, 192.90),
('GTX 1060', 'Gigabyte', 'NVIDIA', 'HDMI,DVI-I,DVI-D', 3, 'GDDR5', 1050.00, 8008.00, 120.00, 247.21),
('GTX 1050Ti G1', 'Gigabyte', 'NVIDIA', 'HDMI,DVI-I,DVI-D,Display Port', 4, 'GDDR5', 800.00, 7008.00, 100.00, 190.27),
('GTX 1080', 'MSI', 'NVIDIA', 'HDMI,DVI-I,DVI-D,Display Port', 8, 'GDDR5',  2500.00, 6008.00, 200.00, 699.90),
('GTX 1050Ti', 'Gigabyte', 'NVIDIA', 'HDMI,DVI-I,DVI-D,Display Port', 4, 'GDDR5', 800.00, 7008.00, 120.00, 172.58),
('HD6450', 'Sapphire', 'AMD', 'HDMI,VGA', 2, 'GDDR3', 600.00, 1334.00, 200.00, 44.00),
('GT710', 'Zotac', 'NVIDIA', 'HDMI,VGA', 1, 'GDDR4', 650.00, 1600.00, 150.00, 33.00),
('R5 230', 'Sapphire', 'NVIDIA', 'HDMI,VGA', 2, 'GDDR4', 700.00, 1334.00, 160.00, 45.00),
('210', 'Asus', 'NVIDIA', 'HDMI', 1, 'GDDR3', 680.00, 1200.00, 100.00, 37.20),
('GT 730', 'Asus', 'NVIDIA', 'HDMI', 1, 'GDDR4', 650.00, 900.00, 110.00, 52.81);

INSERT INTO PSU VALUES
('RMx 750x', 'Corsair', 750, 144.45),
('CX 450M', 'Corsair', 450, 54.21),
('RMx 650x', 'Corsair', 650, 100.93),
('VS450', 'Corsair', 450, 36.90),
('MasterWatt Lite 600W', 'CoolerMaster', 600, 61.88),
('600W', 'EVGA', 600, 60.42),
('M12II-520', 'Seasonic', 520, 66.56),
('500W Lite B01', 'Approx', 500, 17.50),
('Supernova 750 G3', 'EVGA', 750, 134.79),
('CX650M', 'Corsair', 650, 72.72);

INSERT INTO `Case` VALUES
('S340 Elite', 'NZXT', 96.84, 'Midi', 'ATX,MiniITX'),
('Source 340', 'NZXT', 75.00, 'Midi', 'ATX,MiniITX'),
('Aero-500', 'Aerocool', 45.00, 'Midi', 'ATX,MiniITX'),
('Eclipse P400', 'Phanteks', 84.82, 'Midi', 'ATX,MiniITX'),
('Panzer Max', 'Cougar', 118.55, 'Midi', 'ATX,MiniITX,ExtendedATX'),
('Carbide Spec-Alpha', 'Corsair', 74.56, 'Midi', 'ATX,MiniITX'),
('MasterBox Lite 5', 'CoolerMaster', 59.90, 'Midi','ATX,MiniITX'),
('Enthoo Pro', 'Phanteks', 113.46, 'Midi', 'ATX,MiniITX,ExtendedATX'),
('H440 V2', 'NZXT', 121.79, 'Midi', 'ATX,MiniITX'),
('Gaming 988', 'LC-Power', 61.98, 'Midi', 'ATX,MiniITX');

INSERT INTO HD VALUES
('DT01ACA100', 'Toshiba', 1024, 'SATA III (6 Gbit/s)', 'HDD', '3.5"', 38.48),
('Caviar Blue', 'Western Digital', 1024, 'SATA III (6 Gbit/s)', 'HDD', '3.5"', 42.67),
('Travelstar 7K1000', 'Hitachi', 1024, 'SATA III (6 Gbit/s)', 'HDD', '2,5"', 51.71),
('Red NAS', 'Western Digital', 4096 , 'SATA III (6 Gbit/s)', 'HDD', '3.5"', 126.97),
('M3 Portable', 'Maxtor', 500 , 'USB 3.0', 'extHD', '2,5"', 40.34),
('Memory Station', 'Intenso', 500 , 'USB 3.0', 'extHD', '2,5"', 48.00),
('850 Evo', 'Samsung', 500, 'SATA III (6 Gbit/s)', 'SSD', '2,5"', 150.60),
('A400', 'Kingston', 120, 'SATA III (6 Gbit/s)', 'SSD', '2,5"',  44.27),
('Trion 150', 'OCZ', 240, 'SATA III (6 Gbit/s)', 'SSD', '2,5"', 108.00),
('Force Series LS B', 'Corsair', 120, 'SATA III (6 Gbit/s)', 'SSD', '2,5"', 73.40 );

INSERT INTO SSD VALUES
('Force Series LS B', 'SATA III (6 Gbit/s)', 450, 540),
('Trion 150', 'SATA III (6 Gbit/s)', 520, 550),
('A400', 'SATA III (6 Gbit/s)', 520, 540),
('850 Evo', 'SATA III (6 Gbit/s)', 320, 500);

INSERT INTO HDD VALUES
('DT01ACA100', 'SATA III (6 Gbit/s)', 32,  7200 ),
('Caviar Blue', 'SATA III (6 Gbit/s)', 64,  7200 ),
('Travelstar 7K1000', 'SATA III (6 Gbit/s)', 32,  7200 ),
('Red NAS', 'SATA III (6 Gbit/s)', 64,  5400 );

INSERT INTO extHD VALUES
('M3 Portable', 'USB 3.0', 'No'),
('Memory Station', 'USB 3.0', 'No');

INSERT INTO Customer VALUES
(null,'KOSTAS', 'PAPADOPOULOS', 'konpap@gmail.com', '2109876234', null),
(null, 'TASOS', 'PAPPAS', 'tasos.pappas@gmail.com', '6984554123', null),
(null, 'ANNA', 'SARRI', 'anna_s@gmail.com','6973562114', null),
(null, 'DIMITRIOS','ALEXIOU', 'jim-alexiou@gmail.com','2115478999' , null ),
(null, 'ANASTASIA', 'GIOUSEF', 'an.giousef@hotmail.com', '6939985561', null),
(null, 'GIANNIS', 'GIOTIS', 'johnny.yo@yahoo.com', '2610000589', null),
(null, 'ALEXIA', 'GKOTSI', 'al.gko@gmail.com', '6958855412', null),
(null,'KALIA', 'PANTOU', 'kalia.92@gmail.com', '2310978362', null),
(null, 'ARTEMIS','SORRAS', 'exo.to.xrima@gmail.com', '2610000000', null ),
(null, 'ANTONIS', 'VARDIS', 'business_acc@gmail.com','6908712323', null);

INSERT INTO Card VALUES
(1, null, null, null),
(2, null,null, 90),
(3, null,20,10),
(4, null,45,null),
(5, null,58,134),
(6, null,98, 99),
(7, null,23,9000),
(8, null,39, null),
(9, null,null,87),
(10, null,null,null);

INSERT INTO `Order` VALUES
(1, null, 'Ryzen 5 1600', 'AB350M Pro 4', 'Value Select', 'GTX 1050Ti Windforce', 'RMx 750x', 'S340 Elite', 'DT01ACA100', 'Yes', 2699.90),
(2, null, 'Ryzen 7 1700', 'Rog Strix B350', 'Ripjaws V', 'GTX 1060', 'CX 450M', 'Source 340', 'Caviar Blue', 'Yes', 50.00),
(3, null, 'Ryzen 3 1200', 'Prime B350', 'Fury', 'GTX 1050Ti G1', 'RMx 650x', 'Aero-500', 'Travelstar 7K1000', 'No', null),
(4, null, 'Pentium Dual Core G4560', 'B250M-DS3H', 'Aegis', 'GTX 1080', 'VS450', 'Eclipse P400', 'Red NAS', 'No', null),
(5, null, 'Core i7-7700K', 'Prime H110M-K', 'Vengeance', 'GTX 1050Ti', 'MasterWatt Lite 600W', 'Panzer Max', 'M3 Portable', 'No', 20.00),
(6, null, 'Ryzen 5 1400', 'Z170-A', 'TridentZ', 'HD6450', '600W', 'Carbide Spec-Alpha', 'Memory Station',  'Yes', 19.99),
(7, null, 'Core i7-8700K', 'Prime X370 Pro', 'CT102464BF160B', 'GT710', 'M12II-520', 'MasterBox Lite 5', '850 Evo', 'No', 18.98),
(8, null, 'Core i7-7600K', 'AX370-Gaming K5', 'Fury Blue', 'R5 230', '500W Lite B01', 'Enthoo Pro', 'A400', 'No', 1050.97),
(9, null, 'Core i7-6700K', 'AB350-Gaming 3', 'Ballistix Sport LT', '210', 'Supernova 750 G3', 'H440 V2', 'Trion 150','Yes', 316.13),
(10, null, 'Core i5-7500', '970A-DS3P FX', 'ValueRAM', 'GT 730', 'CX650M', 'Gaming 988', 'Force Series LS B', 'Yes', 509.32);

INSERT INTO `Admin` VALUES
(null, 'PANAGIOTIS', 'ANDRIANOS', 'andrianos@gmail.com', 'skroutz.gr CEO', 'Senior', null),
(null, 'ALEXANDROS', 'OIKONOMOU', 'alex.los.94', 'worked at ksaplopoulos a.e.', 'Senior', null),
(null, 'MARIA', 'ANDIANOPOULOU', 'marryjane@hotmail.com', 'diploma of engineering', 'Junior', 2),
(null, 'ANESTIS', 'KONSTANTINOU', 'anestimelene@gmail.com', 'ex apple CEO', 'Senior', null),
(null, 'NIKO', 'MPELIS', 'nick_bel@gmail.com', 'used to be a gang member', 'Junior', 4),
(null, 'MINA', 'ARNAOUTI', 'minaxxl@gmail.com', 'worked at studio 24', 'Senior', null),
(null, 'PANTELIS', 'PANTELIDIS', 'pp@yahoo.gr', 'currently dead', 'Junior', 4),
(null, 'KOSTAS', 'KARAFOTIS', 'karafo@hotmail.com', 'singer 1999-2018', 'Junior', 6),
(null, 'THOMAS', 'MPINAS', 'tom.b@gmail.com', 'civil engineer computers enthousiast', 'Junior', 6),
(null, 'MARINA', 'ANASTOPOULOU', 'marina@gmail.com', 'black belt karate instructor phd biology ', 'Junior', 6);

INSERT INTO Salary VALUES
(1, null, 07, 2012, 1100.62),
(2, null, 09, 2017, 680.00),
(3, null, 08, 2017, 750.20),
(4, null, 11, 2017, 990.18),
(5, null, 12, 2010, 2050.00),
(6, null, 01, 2014, 1220.50),
(7, null, 03, 2015, 798.00),
(8, null, 09, 2016, 455.33),
(9, null, 10, 2011, 880.00),
(10, null, 05, 2013, 660.90)

