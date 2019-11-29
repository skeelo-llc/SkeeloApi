const database 	= require('./db')
const express 	= require('express')
const mysql 		= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const categories		= express.Router()
const db_limit 		= database.limit
const db_host			= database.host
const db_port			= database.port
const db_user			= database.user
const db_password	= database.password
const db_name			= database.name

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
	console.log("[" + getTimestamp() + "][server] getting all categories")

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
	console.log("[" + getTimestamp() + "][server] getting category with id: " + categoryId)

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


////////////////////////
// create an category //
////////////////////////

categories.post('/categories/create', (req, res) => {
	const categoryName 				= req.body.category_name
	const categoryDescription = req.body.category_description

	const querryArray = [
		categoryName,
		categoryDescription
	]

	const connection = getConnection()
	const queryString = "INSERT INTO categories (category_name, category_description) VALUES (?, ?)"

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into categories: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.sendStatus(201)
		console.log("[" + getTimestamp() + "][server] succeeded to insert into categories")
	})
})


///////////////////////////
// update category by id //
///////////////////////////

categories.put('/categories/update/:id', (req, res) => {
	const categoryId = req.params.id
	console.log("[" + getTimestamp() + "][server] updating category with id: " + categoryId)

	const categoryName 				= req.body.category_name
	const categoryDescription = req.body.category_description

	const queryArray = [
		categoryName,
		categoryDescription
	]

	const queryString = "UPDATE categories SET category_name = ?, category_description = ? WHERE category_id = ?"
	const connection = getConnection()

	connection.query(queryString, queryArray, (err, rows, fields) => {
		console.log(queryString)
		console.log(queryArray)
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update category: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to update category")
	})
})


///////////////////////////
// delete category by id //
///////////////////////////

categories.delete('/categories/delete/:id', (req, res) => {
	const categoryId = req.params.id
	console.log("[" + getTimestamp() + "][server] deleting category with id: " + categoryId)

	const connection = getConnection()
	const queryString = "DELETE FROM categories WHERE category_id = ?"

	connection.query(queryString, [categoryId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from categories: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from categories")
	})
})


module.exports = categories