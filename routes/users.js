const express = require('express')
const mysql 	= require('mysql')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const users 			= express.Router()
const db_limit 			= 15
const db_host			= 'localhost'
const db_port			= 3306
const db_user			= 'root'
const db_password		= ''
const db_name			= 'skeelo'

users.use(express.json());

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
// get all users //
///////////////////

users.get('/users', (req, res) => {
	console.log("[" + getTimestamp() + "][server] getting all users")

	const connection = getConnection()
	const queryString = "SELECT * FROM users"

	connection.query(queryString, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


////////////////////
// get user by id //
////////////////////

users.get('/users/id/:id', (req, res) => {
	const userId = req.params.id
	console.log("[" + getTimestamp() + "][server] getting user(s) with id: " + userId)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_id IN (?)"

	var sqlParam = userId.split(',');

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


//////////////////////
// get user by name //
//////////////////////

users.get('/users/name/:name', (req, res) => {
	const userName = req.params.name
	console.log("[" + getTimestamp() + "][server] getting user with name: " + userName)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_name LIKE (?)"

	var sqlParam = "%" + userName + "%";

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


///////////////////////
// get user by email //
///////////////////////

users.get('/users/email/:email', (req, res) => {
	const userEmail = req.params.email
	console.log("[" + getTimestamp() + "][server] getting user with email: " + userEmail)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_email LIKE (?)"

	var sqlParam = "%" + userEmail + "%";

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


////////////////////////////
// get users by birthdate //
////////////////////////////

users.get('/users/birthdate/:birthdate', (req, res) => {
	const userBirthdate = req.params.birthdate
	console.log("[" + getTimestamp() + "][server] getting all users born in: " + userBirthdate)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_birthdate = ?"

	connection.query(queryString, [userBirthdate], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


//////////////////////////
// get users by country //
//////////////////////////

users.get('/users/country/:country', (req, res) => {
	const userCountry = req.params.country
	console.log("[" + getTimestamp() + "][server] getting all users in country: " + userCountry)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_country = ?"

	connection.query(queryString, [userCountry], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


/////////////////////
// get user by cpf //
/////////////////////

users.get('/users/cpf/:cpf', (req, res) => {
	const userCpf = req.params.cpf
	console.log("[" + getTimestamp() + "][server] getting user with cpf: " + userCpf)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_cpf = ?"

	connection.query(queryString, [userCpf], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


///////////////////////////
// get user by telephone //
///////////////////////////

users.get('/users/phone/:phone', (req, res) => {
	const userPhone = req.params.phone
	console.log("[" + getTimestamp() + "][server] getting user with telephone: " + userPhone)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_phone = ?"

	connection.query(queryString, [userPhone], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


//////////////////////////
// get user by zip code //
//////////////////////////

users.get('/users/zip/:zip', (req, res) => {
	const userZip = req.params.zip
	console.log("[" + getTimestamp() + "][server] getting users with zip Code: " + userZip)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_zip = ?"

	connection.query(queryString, [userZip], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


////////////////////////////////////////
// get user by zip code (starts with) //
////////////////////////////////////////

users.get('/users/zip/starts/:zip', (req, res) => {
	const userZip = req.params.zip
	console.log("[" + getTimestamp() + "][server] getting users with zip Code: " + userZip)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_zip LIKE (?)"

	var sqlParam = userZip + "%";

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


/////////////////////////////////////
// get user by zip code (contains) //
/////////////////////////////////////

users.get('/users/zip/contains/:zip', (req, res) => {
	const userZip = req.params.zip
	console.log("[" + getTimestamp() + "][server] getting users with zip Code: " + userZip)

	const connection = getConnection()
	const queryString = "SELECT * FROM users WHERE user_zip LIKE (?)"

	var sqlParam = "%" + userZip + "%";

	connection.query(queryString, [sqlParam], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to query for users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		console.log("[" + getTimestamp() + "][server] succeeded to query for users")
		res.json(rows)
	})
})


////////////////////
// create an user //
////////////////////

users.post('/users/create', (req, res) => {
	const userName 			= req.body.user_name
	const userEmail 		= req.body.user_email
	const userPassword 		= req.body.user_password
	const userBirthdate 	= req.body.user_birthdate
	const userCountry 		= req.body.user_country
	const userPhone 		= req.body.user_phone
	const userCpf 			= req.body.user_cpf
	const userZip 			= req.body.user_zip

	const queryArray = [
		userName,
		userEmail,
		userPassword,
		userBirthdate,
		userCountry,
		userPhone,
		userCpf,
		userZip
	]

	/* INPUT MODEL */
	/*

{
	"user_name":"",
	"user_email":"",
	"user_password":"",
	"user_birthdate":"",
	"user_country":"",
	"user_phone":"",
	"user_cpf":"",
	"user_zip":""
}

	*/

	const queryString = "INSERT INTO users (user_name, user_email, user_password, user_birthdate, user_country, user_phone, user_cpf, user_zip) VALUES \
	(?, ?, ?, ?, ?, ?, ?, ?)"
	const connection = getConnection()

	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to insert into users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}

		res.status(201).send("201")
		console.log("[" + getTimestamp() + "][server] succeeded to insert into users")
	})
})


///////////////////////
// update user by id //
///////////////////////

users.put('/users/update/:id', (req, res) => {
	const userId = req.params.id
	console.log("[" + getTimestamp() + "][server] updating user with id: " + userId)

	const userName 			= req.body.user_name
	const userEmail 		= req.body.user_email
	const userPassword 		= req.body.user_password
	const userCountry 		= req.body.user_country
	const userZip 			= req.body.user_zip

	const queryArray = [
		userName,
		userEmail,
		userPassword,
		userZip,
		userId
	]

	const queryString = "UPDATE users SET user_name = ?, user_email = ?, user_password = ?, user_zip = ? WHERE user_id = ?"
	const connection = getConnection()
	
	connection.query(queryString, queryArray, (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to update user: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500) 
			return
		}
		
		res.status(201).send("201")
		console.log("[" + getTimestamp() + "][server] succeeded to update users")
	})
})


///////////////////////
// delete user by id //
///////////////////////

users.delete('/users/delete/:id', (req, res) => {
	const userId = req.params.id
	console.log("[" + getTimestamp() + "][server] deleting user with id: " + userId)

	const connection = getConnection()
	const queryString = "DELETE FROM users WHERE user_id = ?"

	connection.query(queryString, [userId], (err, rows, fields) => {
		if(err) {
			console.log("[" + getTimestamp() + "][server] failed to delete from users: " + JSON.stringify(err, undefined, 2))
			res.sendStatus(500)
			return
		}
		
		res.sendStatus(200)
		console.log("[" + getTimestamp() + "][server] succeeded to delete from users")
	})
})

module.exports = users