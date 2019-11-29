const express = require('express')

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const database	= express.Router()

const limit 		= 15
const host			= 'localhost'
const port			= 3306
const user			= 'root'
const password	= ''
const name			= 'skeelo'

module.exports = {
	limit,
	host,
	port,
	user,
	password,
	name
}