const express   = require('express')
const nodemon   = require('nodemon')
const api       = express()

/////////////////
// definitions //
/////////////////
// all important definitions are done here
// todas definições importantes são feitas aqui

const port = 3003; // port on host

function getTimestamp() {
    var today = new Date();
    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    var dateTime = date+' '+time;
    return dateTime
}


/////////////////
// cors enable //
/////////////////
// enable cross-origin resource sharing
// habilitar cross-origin resource sharing

api.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*"); // update to match the domain you will make the request from
    res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();

});


///////////////////
// port listener //
///////////////////
// server notification to the corresponding port
// notificação do servidor para a porta correspondente

api.listen(port, () => {
    console.log("[" + getTimestamp() + "][server] listening to port: " + port + ".")
})


////////////////////
// root home page //
////////////////////
// function to send a response to root page ('/')
// função para responder a página raiz ('/')

api.get('/', (req, res) => {
    console.log("[" + getTimestamp() + "][server] responding to root.")
    
    res.send("hello!")
    res.end()
})


/////////////
// routes //
/////////////
// all the routes are imported and defined here
// todas as rotas são importadas e definidas aqui

const users = require('./routes/users.js')
api.use(users)

const locations = require('./routes/locations.js')
api.use(locations)

const orders = require('./routes/orders.js')
api.use(orders)

const stores = require('./routes/stores.js')
api.use(stores)

const items = require('./routes/items.js')
api.use(items)

const orderitems = require('./routes/orderitems.js')
api.use(orderitems)