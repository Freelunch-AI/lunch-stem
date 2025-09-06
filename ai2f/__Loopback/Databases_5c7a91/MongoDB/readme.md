# to run mongodb sheel go to path:
C:\Program Files\MongoDB\Server\{version}\bin 
and run mongod 
then run mongo

##pra sair roda exit



## analogia do sql para mongo:

table =>> collections

line =>> Documents

OBS: In sql we had to use foreign keys associated with other tables to create relationships, here we
dont have that, we just create another prperty in the document!

## pra conectar no atlas (cloud) e criar um cluster
primeiro loga, depois cria um usuario em DatabaseAcess,
depois estabelece uma conexao em Networkaccess, depois volta pra janela principal
que eh clusters e aperta em connect que ele vai te dar uma string que vc pode
rodar no cmd (cmd do mongo jah aberto) ou colocar no compass



########installation problem solved##############
This is how I solved it, You can follow step by step here:

MongoDB Steps:

Download the latest 64-bit MSI version of MongoDB for Windows.

Run the installer (.msi file)

Add it to your PATH of environment variables. it Should be from:
C:\Program Files\MongoDB\Server\3.0\bin

now Create a “\data\db” folder in C:/ which is used by mongodb to store all data. You should have this folder:

C:\data\db

Note: This is the default directory location expected by mongoDB, don’t create anywhere else

.

Finally, open command prompt and type:

>> mongod
You should see it asking for permissions (allow it) and then listen to a port. After that is done, open another command prompt, leaving the previous one running the server.

Type in the new command prompt

>> mongo
You should see it display the version and connect to a test database.

This proves successful install!=)

#################################################


CHEAT SHEET DE COMANDOS:


Show All Databases
show dbs

Show Current Database
db

Create Or Switch Database
use acme

Drop
db.dropDatabase()

Create Collection
db.createCollection('posts')

Show Collections
show collections

Insert Row
db.posts.insert({
  title: 'Post One',
  body: 'Body of post one',
  category: 'News',
  tags: ['news', 'events'],
  user: {
    name: 'John Doe',
    status: 'author'
  },
  date: Date()
})


Insert Multiple Rows
db.posts.insertMany([
  {
    title: 'Post Two',
    body: 'Body of post two',
    category: 'Technology',
    date: Date()
  },
  {
    title: 'Post Three',
    body: 'Body of post three',
    category: 'News',
    date: Date()
  },
  {
    title: 'Post Four',
    body: 'Body of post three',
    category: 'Entertainment',
    date: Date()
  }
])


Get All Rows
db.posts.find()


Get All Rows Formatted
db.find().pretty()


Find Rows
db.posts.find({ category: 'News' })


Sort Rows
# asc
db.posts.find().sort({ title: 1 }).pretty()
# desc
db.posts.find().sort({ title: -1 }).pretty()


Count Rows
db.posts.find().count()
db.posts.find({ category: 'news' }).count()


Limit Rows
db.posts.find().limit(2).pretty()


Chaining
db.posts.find().limit(2).sort({ title: 1 }).pretty()


Foreach
db.posts.find().forEach(function(doc) {
  print("Blog Post: " + doc.title)
})


Find One Row
db.posts.findOne({ category: 'News' })
Find Specific Fields
db.posts.find({ title: 'Post One' }, {
  title: 1,
  author: 1
})


Update Row
db.posts.update({ title: 'Post Two' },
{
  title: 'Post Two',
  body: 'New body for post 2',
  date: Date()
},
{
  upsert: true
})


Update Specific Field
db.posts.update({ title: 'Post Two' },
{
  $set: {
    body: 'Body for post 2',
    category: 'Technology'
  }
})


Increment Field ($inc)
db.posts.update({ title: 'Post Two' },
{
  $inc: {
    likes: 5
  }
})


Rename Field
db.posts.update({ title: 'Post Two' },
{
  $rename: {
    likes: 'views'
  }
})


Delete Row
db.posts.remove({ title: 'Post Four' })


Sub-Documents
db.posts.update({ title: 'Post One' },
{
  $set: {
    comments: [
      {
        body: 'Comment One',
        user: 'Mary Williams',
        date: Date()
      },
      {
        body: 'Comment Two',
        user: 'Harry White',
        date: Date()
      }
    ]
  }
})


Find By Element in Array ($elemMatch)
db.posts.find({
  comments: {
     $elemMatch: {
       user: 'Mary Williams'
       }
    }
  }
)


Add Index
db.posts.createIndex({ title: 'text' })

Text Search
db.posts.find({
  $text: {
    $search: "\"Post O\""
    }
})


Greater & Less Than
db.posts.find({ views: { $gt: 2 } })
db.posts.find({ views: { $gte: 7 } })
db.posts.find({ views: { $lt: 7 } })
db.posts.find({ views: { $lte: 7 } })


