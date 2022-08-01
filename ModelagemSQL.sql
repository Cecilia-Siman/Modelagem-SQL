CREATE DATABASE "e-roupas";

CREATE TABLE products (
	id SERIAL NOT NULL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	price BIGINT NOT NULL,
	category TEXT NOT NULL,
	"mainPicture" TEXT NOT NULL  
);

CREATE TYPE "sizeType" AS ENUM ('PP', 'P', 'M', 'G', 'GG');

CREATE TABLE sizes (
	id SERIAL NOT NULL PRIMARY KEY,
	"productId" INTEGER NOT NULL REFERENCES products(id),
	size "sizeType" NOT NULL,
	numOfItems INTEGER NOT NULL
);

CREATE TABLE "otherPictures" (
	id SERIAL NOT NULL PRIMARY KEY,
	"productId" INTEGER NOT NULL REFERENCES products(id),
	imageUrl TEXT NOT NULL
);

CREATE TABLE customers (
	id SERIAL NOT NULL PRIMARY KEY,
	name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);

CREATE TABLE adresses (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	street TEXT NOT NULL,
	number INTEGER NOT NULL,
	"postalCode" BIGINT NOT NULL,
	complement TEXT
);

CREATE TYPE "statusOfPurchase" AS ENUM ('criada', 'paga', 'entregue', 'cancelada');

CREATE TABLE purchases (
	id SERIAL NOT NULL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"adressId" INTEGER NOT NULL REFERENCES adresses(id),
	date DATE NOT NULL DEFAULT NOW(),
	status "statusOfPurchase" NOT NULL
);

CREATE TABLE "selectedItems" (
	id SERIAL NOT NULL PRIMARY KEY,
	"purchaseId" INTEGER NOT NULL REFERENCES purchases(id),
	"productId" INTEGER NOT NULL REFERENCES products(id),
	"sizeId" INTEGER NOT NULL REFERENCES sizes(id),
	"numOfItems" INTEGER NOT NULL
);
