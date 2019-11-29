const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const categories		= express.Router()
const db_limit 			= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password		= ''
const db_name			= 'skeelo'

categories.use(express.json());

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


////////////////////////
// get all categories //
////////////////////////

categories.get('/categories', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all items")

	const connection = getConnection()
	const queryString = "SELECT * FROM categories"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for categories: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for categories")
		res.json(rows)
	})
})


////////////////////////
// get category by id //
////////////////////////

categories.get('/categories/id/:id', (req, res) => {
	const categoryId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting categorie with id: " + categoryId)

	const connection = getConnection()
	const queryString = "SELECT * FROM categories WHERE category_id = ?"

	connection.query(queryString, [categoryId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for category: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for category")
		res.json(rows)
	})
})


module.exports = categories