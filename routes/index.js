var express = require('express');
var router = express.Router();


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'RemoteView', user: req.session.user, success: req.session.success, error: req.session.errors });
  /*All errrors must be cleared after showing*/
  req.session.errors = null;
});

router.post("/submit", function(req,res,next){

  //Check validity
  if(!req.body.password)
  {
    res.redirect("/");
    req.session.success = false;
    return;
  }

  req.check("username", "Invalid Username").isUser(req.body.password);
  req.check("password", "Invalid password").isLength({min:4});
  console.log("VILIDATE FERTIG");

  req.asyncValidationErrors().then(function() {
    var user =req.body.username;
    if(user)
    {
      req.session.user = user;
      req.session.success = true;
    }
  }).then(function()
  {
    var users = req.db.get('users');
    users.find({user : req.session.user},{}, function(e,docs){
      if(e)
      {
        req.session.role = undefined;
      }
      else
      {
        req.session.role = docs[0].role;
      }
      res.redirect("/")
    });

  }).catch(function(errors) {
    if(errors) {
      req.session.errors = errors;
      res.redirect("/")
      }
  });

});

router.get("/logout", function(req,res,next){
  req.session.success = false;
  res.redirect("/")
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
        res.render('daimler', {user: req.session.user, success: req.session.success, error: req.session.errors,
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
            user: req.session.user,
            success: req.session.success,
            error: req.session.errors,
            role: req.session.role,
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

/**********************************************
  _____      _   _   _
 / ____|    | | | | (_)
| (___   ___| |_| |_ _ _ __   __ _ ___
 \___ \ / _ \ __| __| | '_ \ / _` / __|
 ____) |  __/ |_| |_| | | | | (_| \__ \
|_____/ \___|\__|\__|_|_| |_|\__, |___/
                              __/ |
                             |___/
**************************************************/
router.get('/settings', function(req, res, next) {
  res.render('settings', { title: 'Settings', user: req.session.user, success: req.session.success, error: req.session.errors });
  /*All errrors must be cleared after showing*/
  req.session.errors = null;
});


/**********************************************
  _    _      _
 | |  | |    | |
 | |__| | ___| |_ __
 |  __  |/ _ \ | '_ \
 | |  | |  __/ | |_) |
 |_|  |_|\___|_| .__/
               | |
               |_|
 **************************************************/
router.get('/help', function(req, res, next) {
  res.render('help', { title: 'Help', user: req.session.user, success: req.session.success, error: req.session.errors });
  /*All errrors must be cleared after showing*/
  req.session.errors = null;
});


module.exports = router;
