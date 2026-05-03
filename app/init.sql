CREATE USER 'houses'@'localhost' IDENTIFIED BY 'MuzikiniPoa#1_';
CREATE DATABASE IF NOT EXISTS wma_houses_db;
GRANT ALL PRIVILEGES ON wma_houses_db.* TO 'houses'@'localhost';

FLUSH PRIVILEGES;
