CREATE DATABASE IF NOT EXISTS glowstore_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE glowstore_db;

CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(60) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS produk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(150) NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    merek VARCHAR(100) NOT NULL DEFAULT '',
    harga DECIMAL(12,2) NOT NULL DEFAULT 0,
    stok INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pelanggan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(150) NOT NULL,
    telepon VARCHAR(30) DEFAULT '',
    email VARCHAR(150) DEFAULT '',
    alamat TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_transaksi VARCHAR(40) NOT NULL UNIQUE,
    pelanggan_id INT NULL,
    tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    bayar DECIMAL(12,2) NOT NULL DEFAULT 0,
    kembalian DECIMAL(12,2) NOT NULL DEFAULT 0,
    metode_pembayaran VARCHAR(30) NOT NULL DEFAULT 'Tunai',
    admin_id INT NULL,
    CONSTRAINT fk_transaksi_pelanggan FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id) ON DELETE SET NULL,
    CONSTRAINT fk_transaksi_admin FOREIGN KEY (admin_id) REFERENCES admin(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS detail_transaksi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaksi_id INT NOT NULL,
    produk_id INT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(12,2) NOT NULL,
    jumlah INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_detail_transaksi FOREIGN KEY (transaksi_id) REFERENCES transaksi(id) ON DELETE CASCADE,
    CONSTRAINT fk_detail_produk FOREIGN KEY (produk_id) REFERENCES produk(id) ON DELETE SET NULL
);

INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Facial Wash Gentle', 'Cleanser', 'GlowSkin', 45000, 30
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Facial Wash Gentle');
INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Hydrating Toner', 'Toner', 'PureBloom', 58000, 24
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Hydrating Toner');
INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Niacinamide Serum', 'Serum', 'GlowSkin', 89000, 18
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Niacinamide Serum');
INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Moisturizer Gel', 'Moisturizer', 'DewDaily', 72000, 20
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Moisturizer Gel');
INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Sunscreen SPF 50', 'Sunscreen', 'SunAura', 95000, 25
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Sunscreen SPF 50');
INSERT INTO produk (nama, kategori, merek, harga, stok)
SELECT 'Cleansing Balm', 'Cleanser', 'PureBloom', 78000, 12
WHERE NOT EXISTS (SELECT 1 FROM produk WHERE nama = 'Cleansing Balm');
