const database 	= require('./db')
const express 	= require('express')
const mysql 		= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const orderitems		= express.Router()
const db_limit 		= database.limit
const db_host			= database.host
const db_port			= database.port
const db_user			= database.user
const db_password	= database.password
const db_name			= database.name

orderitems.use(express.json());

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
// get all orderitems //
////////////////////////

orderitems.get('/orderitems', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all orderitems")

	const connection = getConnection()
	const queryString = "SELECT * FROM orderitems"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for orderitems: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for orderitems")
		res.json(rows)
	})
})


////////////////////////////////
// get orderitems by order id //
////////////////////////////////

orderitems.get('/orderitems/order/:id', (req, res) => {
	const orderId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting orderitems with order id: " + orderId)

	const connection = getConnection()
	const queryString = "SELECT * FROM orderitems WHERE orderitems_order = ?"

	connection.query(queryString, orderId, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for orderitems: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for orderitems")
		res.json(rows)
	})
})


//////////////////////////
// create an orderitems //
//////////////////////////

orderitems.post('/orderitems/create', (req, res) => {
	const orderitemsOrder			= req.body.orderitems_order
	const orderitemsItem 			= req.body.orderitems_item
	const orderitemsQuantity	= req.body.orderitems_quantity
	
	const queryArray = [
		orderitemsOrder,
		orderitemsItem,
		orderitemsQuantity
	]

	/* INPUT MODEL */
	/*

{
	"orderitems_order":"",
	"orderitems_item":"",
	"orderitems_quantity":""
}

	*/

	const queryString = "INSERT INTO orderitems (orderitems_order, orderitems_item, orderitems_quantity) VALUES (?, ?, ?)"
	const connection = getConnection()

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into orderitems: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.status(201).send("201")
		console.log("[" + getTimestamp() + "][server] succeeded to insert into orderitems")
	})
})

module.exports = orderitems