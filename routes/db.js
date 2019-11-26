const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const orders 			= express.Router()
const db_limit 		= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password	= ''
const db_name			= 'skeelo'

orders.use(express.json());

function getTimestamp() {
	var today = new Date();
	var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
	var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	var dateTime = date+' '+time;
	return dateTime
}


////////////////
// connection //
////////////////
// database connection is made here
// a conexão com o banco de dados é feita aqui

const pool = mysql.createPool({
  connectionLimit : db_limit, 
	host						: db_host,
	port						: db_port,
	user						: db_user,
	password				: db_password,
	database				: db_name
})

function getConnection() {
	return pool
}


////////////////////
// get all orders //
////////////////////

orders.get('/db', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all orders")

	const connection = getConnection()
	const queryString = "DROP TABLE IF EXISTS `categories`; SET character_set_client = utf8mb4 ; CREATE TABLE `categories` (`category_id` int(11) NOT NULL COMMENT 'STOREID + CATEGORYID', `category_name` varchar(45) NOT NULL, `category_description` tinytext, `category_store` int(11) NOT NULL, PRIMARY KEY (`category_id`), KEY `category_store_idx` (`category_store`), CONSTRAINT `category_store` FOREIGN KEY (`category_store`) REFERENCES `stores` (`store_id`) ON DELETE NO ACTION ON UPDATE NO ACTION) ENGINE=InnoDB DEFAULT CHARSET=utf8;"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for orders: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for orders")
		res.json(rows)
	})
})

module.exports = orders