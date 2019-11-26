const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const locations		= express.Router()
const db_limit 		= 15
const db_host			= 'mysql.devisate.com.br'
const db_port			= 3306
const db_user			= 'devisate04'
const db_password	= 'v1z3h0b3k1'
const db_name			= 'devisate04'

locations.use(express.json());

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


///////////////////////
// get all locations //
///////////////////////

locations.get('/locations', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all locations")

	const connection = getConnection()
	const queryString = "SELECT * FROM locations"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			res.send("[" + getTimestamp() + "][server] failed to query for locations: " + JSON.stringify(err, undefined, 2))
			console.log("[" + getTimestamp() + "][server] failed to query for locations: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for locations")
		res.json(rows)
	})
})


//////////////////////////
// get location by cnpj //
//////////////////////////

locations.get('/locations/id/:cnpj', (req, res) => {
	const locationCnpj = req.params.cnpj
	console.log("[" + getTimestamp() + "][server] getting location with cnpj: " + locationCnpj)

	const connection = getConnection()
	const queryString = "SELECT * FROM locations WHERE location_cnpj = ?"

	connection.query(queryString, [locationCnpj], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for location: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for location")
		res.json(rows)
	})
})


////////////////////////
// create an location //
////////////////////////

locations.post('/locations/create', (req, res) => {
	const locationCnpj 					= req.body.location_cnpj
	const locationZip 					= req.body.location_zip
	const locationAddress 			= req.body.location_address
	const locationNumber			 	= req.body.location_number
	const locationNeighbourhood = req.body.location_neighbourhood
	const locationCity				 	= req.body.location_city
	const locationProvince 			= req.body.location_province
	const locationCountry 			= req.body.location_country
	const locationLat 					= req.body.location_lat
	const locationLng						= req.body.location_lng

	const queryArray = [
		locationCnpj,
		locationZip,
		locationAddress,
		locationNumber,
		locationNeighbourhood,
		locationCity,
		locationProvince,
		locationCountry,
		locationLat,
		locationLng
	]

	const connection = getConnection()
	const queryString = "INSERT INTO locations (location_cnpj, location_zip, location_address, location_number, location_neighbourhood, location_city, location_province, location_country, location_lat, location_lng) VALUES \
	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into locations: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.status(201).send("201")
		console.log("[" + getTimestamp() + "][server] succeeded to insert into locations")
	})
})


/////////////////////////////
// update location by cnpj //
/////////////////////////////

locations.put('/locations/update/:cnpj', (req, res) => {
	const locationCnpj = req.params.cnpj
	console.log("[" + getTimestamp() + "][server] updating location with cnpj: " + locationCnpj)

	const locationZip 					= req.body.location_zip
	const locationAddress 			= req.body.location_address
	const locationNumber			 	= req.body.location_number
	const locationNeighbourhood = req.body.location_neighbourhood
	const locationCity				 	= req.body.location_city
	const locationProvince 			= req.body.location_province
	const locationCountry 			= req.body.location_country
	const locationLat 					= req.body.location_lat
	const locationLng						= req.body.location_lng

	const queryArray = [
		locationCnpj,
		locationZip,
		locationAddress,
		locationNumber,
		locationNeighbourhood,
		locationCity,
		locationProvince,
		locationCountry,
		locationLat,
		locationLng,
		locationCpnj
	]

	const queryString = "UPDATE locations SET (location_zip = ?, location_address = ?, location_number = ?, location_neighbourhood = ?, location_city = ?, location_province = ?, location_country = ?, location_lat = ?, location_lng = ?) \
		WHERE location_cnpj = ?"
	const connection = getConnection()
	
	connection.query(queryString, queryArray, (err, rows, fields) => {
		console.log(queryString)
		console.log(queryArray)
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update location: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to update location")
	})
})


/////////////////////////////
// delete location by cnpj //
/////////////////////////////

locations.delete('/locations/delete/:cnpj', (req, res) => {
	const locationCnpj = req.params.cnpj
	console.log("[" + getTimestamp() + "][server] deleting location with cnpj: " + locationCnpj)

	const connection = getConnection()
	const queryString = "DELETE FROM locations WHERE location_cnpj = ?"

	connection.query(queryString, [locationCnpj], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from locations: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from locations.")
	})
})


module.exports = locations