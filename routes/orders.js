const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const orders 			= express.Router()
const db_limit 			= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password		= ''
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

orders.get('/orders', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all orders")

	const connection = getConnection()
	const queryString = "SELECT * FROM orders ORDER BY order_date DESC"

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


/////////////////////
// get order by id //
/////////////////////

orders.get('/orders/id/:id', (req, res) => {
	const orderId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting order with id: " + orderId)

	const connection = getConnection()
	const queryString = "SELECT * FROM orders WHERE order_id = ?"
	var order_store;

	connection.query(queryString, [orderId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for orders: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for orders")
		responseOrder = rows[0]
		order_store = rows[0].order_store

		const queryStringStore = "SELECT * FROM stores WHERE store_id = ?"
		connection.query(queryStringStore, [order_store], (err, rows, fields) => {
			if(err) {
				console.log("[" + getTimestamp() + "][server] failed to query for stores inner orders: " + JSON.stringify(err, undefined, 2))
				res.sendStatus(500)
				return
			}
	
			console.log("[" + getTimestamp() + "][server] succeeded to query for stores")
			responseStores = rows[0]
			response = responseOrder
			response.order_store = responseStores
		})

		const queryStringItems = "SELECT orderitems_item, orderitems_quantity FROM orderitems WHERE orderitems_order = ?"
		connection.query(queryStringItems, [orderId], (err, rows, fields) => {
			if(err) {
				console.log("[" + getTimestamp() + "][server] failed to query for items inner orders: " + JSON.stringify(err, undefined, 2))
				res.sendStatus(500)
				return
			}
	
			console.log("[" + getTimestamp() + "][server] succeeded to query for items")
			responseItems = rows
			response = responseOrder
			response.order_orderitems = responseItems
			res.json(response)
		})
	})
})


///////////////////////
// get order by user //
///////////////////////

orders.get('/orders/user/:user', (req, res) => {
	const userId = req.params.user
	console.log("[" + getTimestamp() + "][server] getting orders by user_id: " + userId)

	const connection = getConnection()
	const queryString = "SELECT * FROM orders WHERE order_owner = ? ORDER BY order_date DESC"

	connection.query(queryString, [userId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for orders: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for orders by user_id")
		res.json(rows)
	})
})


/////////////////////
// create an order //
/////////////////////

orders.post('/orders/create', (req, res) => {
	const orderId					= req.body.order_id
	const orderOwner 			= req.body.order_owner
	const orderStore 			= req.body.order_store
	const orderDate				= req.body.order_date
	const orderPrice			= req.body.order_price
	const orderItems 			= req.body.order_items
	const orderProgress		= 0

	const queryArray = [
		orderId,
		orderOwner,
		orderStore,
		orderDate,
		orderPrice,
		orderItems,
		orderProgress
	]

	const queryString = "INSERT INTO orders (order_id, order_owner, order_store, order_date, order_price, order_items, order_progress) VALUES \
	(?, ?, ?, ?, ?, ?, ?)"
	const connection = getConnection()

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into orders: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.status(201).send("201")
		console.log("[" + getTimestamp() + "][server] succeeded to insert into orders")
	})
})


////////////////////////
// update order by id //
////////////////////////

orders.put('/orders/update/:id', (req, res) => {
	const orderId = req.params.id
	console.log("[" + getTimestamp() + "][server] updating order with id: " + orderId)

	const orderProgress = req.body.order_progress;

	const queryArray = [
		orderProgress,
		orderId
	]

	const connection = getConnection()
	const queryString = "UPDATE orders SET order_progress = ? WHERE order_id = ?"
	
	connection.query(queryString, queryArray, (err, rows, fields) => {
		// console.log(queryString)
		// console.log(queryArray)
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update order: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to update order")
	})
})


////////////////////////
// delete order by id //
////////////////////////

orders.delete('/orders/delete/:id', (req, res) => {
	const orderId = req.params.id
	console.log("[" + getTimestamp() + "][server] deleting order with id: " + orderId)

	const connection = getConnection()
	const queryString = "DELETE FROM orders WHERE order_id = ?"

	connection.query(queryString, [orderId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from orders: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from orders")
	})
})


module.exports = orders