
Expressor Generator
npm install express-generator -g


$ express -h

  Usage: express [options][dir]

  Options:

    -h, --help          output usage information
    -V, --version       output the version number
    -e, --ejs           add ejs engine support (defaults to jade)
        --hbs           add handlebars engine support
    -H, --hogan         add hogan.js engine support
    -c, --css <engine>  add stylesheet <engine> support (less|stylus|compass|sass) (defaults to plain css)
        --git           add .gitignore
    -f, --force         force on non-empty directory


The following command creates:
$ express myapp

   create : myapp
   create : myapp/package.json
   create : myapp/app.js
   create : myapp/public
   create : myapp/public/javascripts
   create : myapp/public/images
   create : myapp/routes
   create : myapp/routes/index.js
   create : myapp/routes/users.js
   create : myapp/public/stylesheets
   create : myapp/public/stylesheets/style.css
   create : myapp/views
   create : myapp/views/index.jade
   create : myapp/views/layout.jade
   create : myapp/views/error.jade
   create : myapp/bin
   create : myapp/bin/www

Install the dependecies
$ cd myapp
$ npm install

Starten
set DEBUG=myapp:* & npm start


******************************
Mongo DB
******************************
https://www.youtube.com/watch?v=Do_Hsb_Hs3c

Use: 
MongoDb Path + -dbpath + path to the databasefolder
"C:\Program Files\MongoDB\Server\3.2\bin\mongod.exe" -dbpath C:\Projekte\NodeJsTestServer\remoteview\data


Mongodbclient

Mongo Client
sc.exe create MongoDB binPath= "C:\Program Files\MongoDB\Server\3.2\bin\mongod.exe --service --config=C:\Projekte\NodeJsTestServer\remoteview\cfg\mongod.cfg" DisplayName="MongoDB" start="auto"