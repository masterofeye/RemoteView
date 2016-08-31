var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/daimler', function(req, res, next){
  var db = req.db;
  var ldap = req.ldap;

  var collection = db.get('remoteWorkstations');
  if(!collection)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }

  var collectionLogs = db.get('logs');
  if(!collectionLogs)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }

  var myres;
  //Eine gefilterte Liste erzeugen ohne Duplikate für die Projekte
  var ar = collection.distinct("project", function(err, docs) {
    myres = docs.sort();
  });

  var collectionusers = db.get('users');
  if(!collectionusers)
  {
    console.log("Fehler, User Collection konnte nicht abgefragt werden.");
  }
  collection.find({},{},function(e,docs){
    collectionLogs.find({},{},function(e,logs) {
      collectionusers.find({},{},function(e,user) {
        res.render('daimler', {
          "logs" : logs,
          "users" : user,
          "userlist": docs, /*komplete remoteworkstation Liste*/
          "unique": myres, /*nur unique Projektnamen*/
          "ldap": ldap /*für den Login*/
        });
      });
    });
  });
});

router.get('/compile', function(req, res, next){
  var db = req.db;
  var ldap = req.ldap;
  var collection = db.get('backendWorkstations');
  if(!collection)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }

  var collectionusers = db.get('users');
  if(!collectionusers)
  {
    console.log("Fehler, User Collection konnte nicht abgefragt werden.");
  }
    collection.find({},{},function(e,docs){
      collectionusers.find({},{},function(e,user) {
        res.render('compile', {
          "users" : user,
          "userlist" : docs,/*komplete remoteworkstation Liste*/
          "unique" : myres,/*nur unique Projektnamen*/
          "ldap" : ldap /*für den Login*/
      });
    });
  });
});


router.get('/remote', function(req, res, next){
  var db = req.db;
  var ldap = req.ldap;
  var ws  = req.ws;
  var collectionRemoteWorkstation = db.get('remoteWorkstations');
  if(!collectionRemoteWorkstation)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }


  var collectionHistory = db.get('flashhistory');
  if(!collectionHistory)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }

  var collectionLog = db.get('logs');
  if(!collectionLog)
  {
    console.log("Fehler, Collection konnte nicht abgefragt werden.");
  }

  var collectionusers = db.get('users');
  if(!collectionusers)
  {
    console.log("Fehler, User Collection konnte nicht abgefragt werden.");
  }

  collectionRemoteWorkstation.find({a_number : req.query.a_number},{},function(e,remote){
    collectionLog.find({ },{},function(e,logs) {
      collectionHistory.find({ },{},function(e,history) {
        collectionusers.find({},{},function(e,user) {
          req.a_number = req.query.a_number;
          res.render('remote', {
            "ws" : req.ws,
            "logs" : logs,
            "users" : user,
            "a_number" : req.query.a_number,
            "history" : history,
            "remote": remote, /*komplete remoteworkstation Liste*/
            "ldap": ldap /*für den Login*/
          });

        });
      });
    });
  });
});
/********************************************************
*@brief Checks the parameter id
*@todo Currently is no check if any id exists in the database
 ***************************************************************/

router.param('id', function(req, res, next, id) {
  req.id = id;
  console.log(id + ' was not found');
  // go to the next thing
  next();
});

/*
 *@brief Checks the parameter state
 *@todo Currently is no check if state is valid
 */
router.param('state', function(req, res, next, state) {
  req.state = state;
  console.log(state + ' was not found');
  // go to the next thing
  next();
});


router.get('/:id/:state/edit', function(req, res) {
  console.log("1");
  var collectionRemoteWorkstation = req.db.get('remoteWorkstations');
  console.log("2");
  collectionRemoteWorkstation.update({_id: req.id}, {$set: {"state": req.state}}, function (err, doc) {
    console.log("3");

  });
  res.redirect("/remote?a_number=" + req.a_number);
});

router.put("/:id/edit", function(req,res)
{
  console.log("hier war ich");
  var db = req.db;
  var collectionRemoteWorkstation = db.get('remoteWorkstations');

});



module.exports = router;
