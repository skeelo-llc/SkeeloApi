const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const items				= express.Router()
const db_limit 			= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password		= ''
const db_name			= 'skeelo'

items.use(express.json());

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


///////////////////
// get all items //
///////////////////

items.get('/items', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all items")

	const connection = getConnection()
	const queryString = "SELECT * FROM items"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for items: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for items")
		res.json(rows)
	})
})


/////////////////////
// get items by id //
/////////////////////

items.get('/items/id/:id', (req, res) => {
	const itemId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting item with id: " + itemId)

	const connection = getConnection()
	const queryString = "SELECT * FROM items WHERE item_id = ?"

	connection.query(queryString, [itemId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for item: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for item")
		res.json(rows)
	})
})

//////////////////////////
// get items by barcode //
//////////////////////////

items.get('/items/barcode/:barcode', (req, res) => {
	const itemBarcode = req.params.barcode
	console.log("[" + getTimestamp() + "][server] getting item with barcode: " + itemBarcode)

	const connection = getConnection()
	const queryString = "SELECT * FROM items WHERE item_barcode = ?"

	connection.query(queryString, [itemBarcode], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for item: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for item")
		res.json(rows)
	})
})

////////////////////////
// get items by store //
////////////////////////

items.get('/items/store/:store', (req, res) => {
	const itemStore = req.params.store
	console.log("[" + getTimestamp() + "][server] getting item with store: " + itemStore)

	const connection = getConnection()
	const queryString = "SELECT * FROM items WHERE item_store = ?"

	connection.query(queryString, [itemStore], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for item: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for item")
		res.json(rows)
	})
})

////////////////////
// create an item //
////////////////////

items.post('/items/create', (req, res) => {
	const itemStore 					= req.body.item_store
	const itemBarcode 				= req.body.item_barcode
	const itemCategory 				= req.body.item_category
	const itemName			 			= req.body.item_name
	const itemDescription			= req.body.item_description
	const itemAmount 					= req.body.item_amount
	const itemPrice				 		= req.body.item_price
	const itemDiscount 				= req.body.item_discount
	const itemDiscountType 		= req.body.item_discounttype
	const itemDiscountPercent	= req.body.item_discountpercent
	const itemDiscountMinus		= req.body.item_discountminus

	const queryArray = [
		itemStore,
		itemBarcode,
		itemCategory,
		itemName,
		itemDescription,
		itemAmount,
		itemPrice,
		itemDiscount,
		itemDiscountType,
		itemDiscountPercent,
		itemDiscountMinus
	]

	const connection = getConnection()
	const queryString = "INSERT INTO items (item_store, item_barcode, item_category, item_name, item_description, item_amount, item_price, item_discount, item_discounttype, item_discountpercent, item_discountminus) VALUES \
	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into items: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.sendStatus(201)
		console.log("[" + getTimestamp() + "][server] succeeded to insert into items")
	})
})


///////////////////////
// update item by id //
///////////////////////

items.put('/items/update/:id', (req, res) => {
	const itemId = req.params.id
	console.log("[" + getTimestamp() + "][server] updating item with id: " + itemId)

	const itemStore 					= req.body.item_store
	const itemBarcode 				= req.body.item_barcode
	const itemCategory 				= req.body.item_category
	const itemName			 			= req.body.item_name
	const itemDescription			= req.body.item_description
	const itemAmount 					= req.body.item_amount
	const itemPrice				 		= req.body.item_price
	const itemDiscount 				= req.body.item_discount
	const itemDiscountType 		= req.body.item_discounttype
	const itemDiscountPercent	= req.body.item_discountpercent
	const itemDiscountMinus		= req.body.item_discountminus

	const queryArray = [
		itemStore,
		itemBarcode,
		itemCategory,
		itemName,
		itemDescription,
		itemAmount,
		itemPrice,
		itemDiscount,
		itemDiscountType,
		itemDiscountPercent,
		itemDiscountMinus,
		itemId
	]

	const queryString = "UPDATE items SET (item_store = ?, item_barcode = ?, item_category = ?, item_name = ?, item_description = ?, item_amount = ?, item_price = ?, item_discount = ?, item_discounttype = ?, item_discountpercent, item_discountminus) \
		WHERE item_id = ?"
	const connection = getConnection()
	
	connection.query(queryString, queryArray, (err, rows, fields) => {
		console.log(queryString)
		console.log(queryArray)
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update item: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to update item")
	})
})


///////////////////////
// delete item by id //
///////////////////////

items.delete('/items/delete/:id', (req, res) => {
	const itemId = req.params.id
	console.log("[" + getTimestamp() + "][server] deleting item with id: " + itemId)

	const connection = getConnection()
	const queryString = "DELETE FROM items WHERE item_id = ?"

	connection.query(queryString, [itemId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from items: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from items")
	})
})


module.exports = items