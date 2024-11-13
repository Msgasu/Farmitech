-- Create Database
Drop DATABASE IF EXISTS farmitech;
CREATE DATABASE farmitech;
USE farmitech;

-- Create Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    number VARCHAR(15) NOT NULL,
    picture VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    confirm_password VARCHAR(255) NOT NULL
);

-- Create Roles Table
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Insert roles into roles table
INSERT INTO roles (role_name) VALUES 
('admin'), 
('customer'), 
('superadmin');

-- Create Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2),
    stock INT
);

-- Create Videos Table
CREATE TABLE videos (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    video_url VARCHAR(255) NOT NULL,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Images Table
CREATE TABLE images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create User Roles Relationship
CREATE TABLE user_roles (
    user_id INT,
    role_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    PRIMARY KEY (user_id, role_id)
);

-- Verifiable ID --
CREATE TABLE IF NOT EXISTS VerifiablePins (
    pin_id INT AUTO_INCREMENT PRIMARY KEY,
    pin VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);