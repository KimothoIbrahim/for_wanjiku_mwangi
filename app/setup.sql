CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  password VARCHAR(255) NOT NULL,

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS property_areas (
  id INT AUTO_INCREMENT,
  name VARCHAR(25) NOT NULL UNIQUE,
  description VARCHAR(255) NOT NULL,
  images VARCHAR(255) NOT NULL,

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS property (
  id INT AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE,
  description TEXT NOT NULL,
  listing_type VARCHAR(50),
  price DECIMAL(12,2),
  currency VARCHAR(10) DEFAULT 'KES',
  negotiable BOOLEAN,
  status VARCHAR(50),
  is_featured BOOLEAN DEFAULT FALSE,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS location (
  id INT AUTO_INCREMENT,
  location_id INT NOT NULL,
  city VARCHAR(50) DEFAULT 'NAIROBI',
  area VARCHAR(50) NOT NULL,
  address VARCHAR(255),
  latitude DECIMAL,
  longitude DECIMAL,

  PRIMARY KEY (id),
  FOREIGN KEY (location_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS details (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  bedrooms INT NOT NULL,
  bathrooms INT NOT NULL,
  toilets INT,
  size_ INT,
  size_units VARCHAR(10),
  floor_ INT,
  total_floors INT,
  year_built INT,
  property_condition VARCHAR(20),
  parking_spaces INT,

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS amenities (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS media (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  cover_image VARCHAR(255),
  images VARCHAR(500),
  videos VARCHAR(255),
  virtual_tour VARCHAR(255),

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS agent (
  id INT AUTO_INCREMENT,
  name VARCHAR(50) UNIQUE NOT NULL DEFAULT 'Ortho26 REALTY',
  phone VARCHAR(15) NOT NULL DEFAULT '+254742146033',
  email VARCHAR(50),
  is_verified BOOLEAN DEFAULT FALSE,
  company VARCHAR(50) DEFAULT 'Ortho26 Company Limited',

  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pricing (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  rent_frequency VARCHAR(20),
  deposit INT,
  service_charge INT,
  minimum_lease_months INT,

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS stats (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  views INT,
  favorites INT,
  inquiries INT,

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);

CREATE TABLE IF NOT EXISTS payment (
  id INT AUTO_INCREMENT,
  property_id INT NOT NULL,
  listing_fee_paid BOOLEAN DEFAULT FALSE,
  boosted_until VARCHAR(50),

  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES property (id)
);
