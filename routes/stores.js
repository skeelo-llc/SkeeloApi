const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const stores			= express.Router()
const db_limit 			= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password		= ''
const db_name			= 'skeelo'

stores.use(express.json());

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
// get all stores //
////////////////////

stores.get('/stores', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all stores")

	const connection = getConnection()
	const queryString = "SELECT * FROM stores"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for stores: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for stores")
		res.json(rows)
	})
})


/////////////////////
// get store by id //
/////////////////////

stores.get('/stores/id/:id', (req, res) => {
	const storeId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting store with id: " + storeId)

	const connection = getConnection()
	const queryString = "SELECT * FROM stores WHERE store_id LIKE (?)"

	var sqlParam = "%" + storeId + "%";

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for store: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for store")
		res.json(rows)
	})
})


///////////////////////
// get store by name //
///////////////////////

stores.get('/stores/:id', (req, res) => {
	const storeId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting store with id: " + storeId)

	const connection = getConnection()
	const queryString = "SELECT * FROM stores WHERE store_id = ?"

	connection.query(queryString, [storeId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for store: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for store")
		res.json(rows)
	})
})


/////////////////////
// create an store //
/////////////////////

stores.post('/stores/create', (req, res) => {
	const storeName 			= req.body.store_name
	const storeDisplay  	= req.body.store_displayname
	const storeCnpj  			= req.body.store_cnpj
	const storePhone 			= req.body.store_phone
	const storeImg				= req.body.store_imageurl
	const storeOwner			= req.body.store_owner
	const storeLocation	 	= req.body.store_location
	const storeTax				= req.body.store_deliverytax
	
	const queryArray = [
		storeName,
		storeDisplay,
		storeCnpj,
		storePhone,
		storeImg,
		storeOwner,
		storeLocation,
		storeTax
	]
	

	/* INPUT MODEL */
	/*
	
{
	"store_name": "",
	"store_displayname": "",
	"store_cnpj":"",
	"store_phone":"",
	"store_imageurl": "",
	"store_owner":"",
	"store_location":""
	"store_deliverytax": ""
}
	
	*/


	const connection = getConnection()
	const queryString = "INSERT INTO stores (store_name, store_displayname, store_cnpj, store_phone, store_imageurl, store_owner, store_location, store_deliverytax) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into stores: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.sendStatus(201)
		console.log("[" + getTimestamp() + "][server] succeeded to insert into stores")
	})
})


////////////////////////
// update store by id //
////////////////////////

stores.put('/stores/update/:id', (req, res) => {
	const storeId = req.params.id
	console.log("[" + getTimestamp() + "][server] updating store with id: " + storeId)

	const storeName 		= req.body.store_name
	const storeDisplay	= req.body.store_displayname
	const storeCnpj  		= req.body.store_cnpj
	const storePhone 		= req.body.store_phone
	const storeOwner		= req.body.store_owner
	const storeLocation = req.body.store_location
	
	const queryArray = [
		storeName,
		storeDisplay,
		storeCnpj,
		storePhone,
		storeOwner,
		storeLocation,
		storeId
	]

	const queryString = "UPDATE stores SET store_name = ?, store_displayname = ?, store_cnpj = ?, store_phone = ?, store_owner = ?, store_location = ? WHERE store_id = ?"
	const connection = getConnection()
	
	connection.query(queryString, queryArray, (err, rows, fields) => {
		console.log(queryString)
		console.log(queryArray)
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update store: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to update store")
	})
})


////////////////////////
// delete store by id //
////////////////////////

stores.delete('/stores/delete/:id', (req, res) => {
	const storeId = req.params.id
	console.log("[" + getTimestamp() + "][server] deleting store  with id: " + storeId)

	const connection = getConnection()
	const queryString = "DELETE FROM stores WHERE store_id = ?"

	connection.query(queryString, [storeId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from stores: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from stores.")
	})
})


module.exports = stores