var express = require('express');
/*******************************************
 * @brief Session Management
 * https://github.com/expressjs/serve-favicon
 *********************************************/
var session = require('express-session')

/*******************************************
 * @brief DB backend for session storage
 * https://github.com/expressjs/serve-favicon
 *********************************************/
var MongoDBStore = require('connect-mongodb-session')(session);

/*******************************************
 * @brief The path module provides utilities for working with file and directory paths.
 * Wird von Express Framework benutzt um nach Files zu schauen. Im spezielen für die Views (Jade Dateien)
 * https://github.com/expressjs/serve-favicon
 *********************************************/
var path = require('path');

/*******************************************
 * @brief Wird aktuell nicht genutzt
 * https://github.com/expressjs/serve-favicon
 *********************************************/
//var favicon = require('serve-favicon');

/*******************************************
 * @brief Wird aktuell nicht genutzt
 * https://github.com/expressjs/morgan
 *********************************************/
//var logger = require('morgan');

/*******************************************
 * @brief Wird aktuell nicht benutzt, Sessions bringen ihren eigenen Parser mit
 *********************************************/
//var cookieParser = require('cookie-parser');

/*******************************************
 *@brief Parse incoming request bodies in a middleware before your handlers, available under the req.body property.
 *https://github.com/expressjs/body-parser
 *******************************************/
var bodyParser = require('body-parser');

/*******************************************
 *@brief This module implements ICMP Echo (ping) support for Node.js.
 *https://github.com/stephenwvickers/node-net-ping
 *******************************************/
var ping = require("net-ping");

/*******************************************
 *@brief A cron-like and not-cron-like job scheduler for Node.
 *https://github.com/node-schedule/node-schedule
 *******************************************/
var schedule = require('node-schedule');

/*******************************************
 *@brief Database engine used from the Remoteview.
 *https://github.com/expressjs/body-parser
 *******************************************/
var mongo = require('mongodb');

/*******************************************
 *@brief
 *
 *******************************************/
var monk = require('monk');

/*******************************************
 *@brief ldapjs is a pure JavaScript, from-scratch framework for implementing LDAP clients and servers in Node.js.
 * It is intended for developers used to interacting with HTTP services in node and restify..
 *http://ldapjs.org/
 *******************************************/
var ldap = require('ldapjs');

/*******************************************
 *@brief simple to use, blazing fast and thoroughly tested websocket client, server and console for node.js, up-to-date against RFC-6455.
 * Besonderheit hierbei ist das es mit QT Sockets zusammenarbeitet und keine weitere Anpassungen notwendig sind.
 *https://www.npmjs.com/package/ws
 *******************************************/
var WebSocketServer = require('ws');

/*******************************************
 *@brief FEATURING THE FASTEST AND MOST RELIABLE REAL-TIME ENGINE
 *http://socket.io/
 *******************************************/
var io = require('socket.io')(http);

/*******************************************
 *@brief The HTTP interfaces in Node.js are designed to support many features of the protocol which have been traditionally difficult to use.
 * In particular, large, possibly chunk-encoded, messages.
 * The interface is careful to never buffer entire requests or responses--the user is able to stream data..
 * Wird vorallem für Socket IO benötigt!!
 *https://nodejs.org/api/http.html
 *******************************************/
var http = require('http').Server(app);


const dns = require('dns')

/**
 *@brief Global app obeject. All "communication" with the express framework will be handled with this object.
 */
var app = express();

//Die entsprechenden Routen bzw. weiteren Controller files werden geladen
var routes = require('./routes/index');
var users = require('./routes/users');

/*Monk*/
var db = monk('localhost:27017/remoteWorkstation');

/* Testcode ... brauch das SocketIO ????*/
http.listen(3010, function () {
    console.log('listening on *:3010');
});

/*Setup refresh logic for permanent reqeusting of the RemoteWorkstations.*/
var onlineListe = [];
var remoteCol = db.get('remoteWorkstations');
if (remoteCol == null)
    console.log("Error: RemoteWorkstationsCollection nicht vorhanden");
else {
    var session = ping.createSession();
    //Schedule Regel festlegen
    var rule = new schedule.RecurrenceRule();
    rule.second = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];

    //Job ausführen
    var j = schedule.scheduleJob(rule, function () {
        //Alle RemoteWorkstations in der Datenbank abfragen
        remoteCol.find({}, {}, function (e, remoteWorkstation) {
            //Durch die Liste alle RemoteWorkstations iterieren
            for (var i = 0; i < remoteWorkstation.length; i++) {
                var remote = remoteWorkstation[i];
                if (remote.state == "Defect" || remote.state == "Maintaince") {
                    console.log("continue");
                    continue;
                }
                dns.lookup(remote.a_number, function (err, result) {
                    if (err) {
                        onlineListe.push([err.hostname,"Offline"]);
                    }
                    else {
                        dns.reverse(result, function (err, hostnames) {
                            if (err) {
                                console.log(err.stack);
                            }
                            else {
                                session.pingHost(result.toString(), function (error, target) {
                                    if (error instanceof ping.RequestTimedOutError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else if (error instanceof ping.DestinationUnreachableError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else if (error instanceof ping.ParameterProblemError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else if (error instanceof ping.TimeExceededError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else if (error instanceof ping.SourceQuenchError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else if (error instanceof ping.PacketTooBigError) {
                                        onlineListe.push([err.hostname,"Offline"]);
                                    }
                                    else {
                                        onlineListe.push([err.hostname,"On"]);
                                    }
                                });

                            }


                        })
                    }
                })
            }
        });
    });
}
/*********************************************************************************
        _                                  _                       _
       (_)                                (_)                     | |
 __   ___  _____      __   ___ _ __   __ _ _ _ __   ___   ___  ___| |_ _   _ _ __
 \ \ / / |/ _ \ \ /\ / /  / _ \ '_ \ / _` | | '_ \ / _ \ / __|/ _ \ __| | | | '_ \
  \ V /| |  __/\ V  V /  |  __/ | | | (_| | | | | |  __/ \__ \  __/ |_| |_| | |_) |
   \_/ |_|\___| \_/\_/    \___|_| |_|\__, |_|_| |_|\___| |___/\___|\__|\__,_| .__/
                                      __/ |                                 | |
                                     |___/                                  |_|
 *********************************************************************************/
 // view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');


// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
/*Morgan logger*/
//app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
/*CookieParser*/
//app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Make our db accessible to our router
app.use(function (req, res, next) {
    req.db = db;
    req.ldap = ldap;
    req.ws = WebSocketServer;
    next();
});

app.use('/', routes);
app.use('/daimler', routes);
app.use('/remote', routes);
app.use('/users', users);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function (err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});


module.exports = app;


/*var WebSocketServer = require('ws').Server
 var wss = new WebSocketServer({ server: http })
 wss.on('connection', function connection(ws) {
 console.log("Verbunden");
 ws.on('message', function incoming(message) {
 console.log('received: %s', message);
 });

 ws.send('something');
 });*/

/*
 io.on('connection', function(socket){
 console.log('a user connected');
 });
 */
