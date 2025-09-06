# Hands-on Golang CRUD API

Powered by [ECS Digital](https://ecs.co.uk/digital-engineering/) and [DevOps Playground](https://www.meetup.com/DevOpsPlayground/)

Quick and straight to the point - let's build a quick CRUD API using Go!

Cheat sheet -> [HERE](https://gist.github.com/youshy/a92020e228ef5a164a75be4733650ad7)

---

# DISCLAIMER

If you're following our playground, switch to `diy` branch.

---

<a name="top">

# Table Of Content

* [Intro](#intro)
* [What is Go](#go-intro)
* [Why Go?](#go-why)
* [My setup](#my-setup)
* [Small catch](#catch)
* [Initial app setup](#initial-app-setup)
* [Setup entrypoint](#entrypoint)
* [Initial server](#initial-server)
* [Broker](#broker)
* [Update server](#update-server)
* [Handlers](#handlers)
* [More handlers](#more-handlers)
* [Finish server](#finish-server)
* [Test the server](#test-server)
* [Dockerfile](#dockerfile)
* [How to improve](#improve)
* [Word from the author](#author)

[^Top](#top)

<a name="intro"/>

## Intro

Hello and welcome to our second, fully virtual DevOps playground! Hope you all well and prepared for a little bit over an hour of fun!

Depending on your preference, you can either:

* Fork/copy this repository locally and just follow along as we go - code in this repo is fully finished app
* Get one of our ready-to-Go instances and code along

This playground assumes that you know nothing about Go and will explain a lot of stuff to some detail - if you want to learn more, I recommend [A Tour of Go](https://tour.golang.org) and [The Go Programming Language](https://www.amazon.co.uk/Programming-Language-Addison-Wesley-Professional-Computing/dp/0134190440) by A. Donovan and B. Kernighan.

What we'll do - we will build a simple, ready to deploy Go CRUD (Create-Read-Update-Delete) API that will deal with Posts. So, think about it as a small blogging backend!

Let's go!

[^Top](#top)

(From this point the README assumes that you're using our Go instance. If you want to follow the instructions locally, go to [golang.org](https://golang.org) and download a build for your machine.)

<a name="go-intro"/>

## What Is Go

**Go** (or known also as **golang** because of it's domain) is a statically typed, compiled programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson. Mr Pike and Mr Thompson designed, developed and implemented the original Unix system; Mr Griesemer was working on Chrome's V8 JavaScript engine. And that's just a tip of the iceberg of their collective experience.

Nowadays Go is a backbone of multitude of DevOps tools - from Docker, to Terraform or Vault to Kubernetes. Also Prometheus, Helm, Loki, Grafana... The list goes on and on.

[^Top](#top)

<a name="go-why"/>

## Why Go?

Every tech person should know at least one programming language that allows them a total freedom in tech world. In DevOps world, most of the time it's Python; some of us know Ruby or JavaScript.

Go gives you the type safety, allows you for low-level programming, allows you to cut corners in production-friendly way; the best example would be, that you can create a load balancer system from ground up using Go in-built concurrency support.

The thing that would be the most interesting to us now is that Go is the perfect candidate for high-performance web servers - it can run as one straight out of the box, but today we'll use some extra packages to take our code to the next level.

Also, the very good thing about go is it's documentation. If there's something you won't understand after our playground, then go to [golang.org](https://golang.org) and go over the documentation for a package. Answers will be there!

[^Top](#top)

<a name="my-setup"/>

## My Setup

I'm using Vim exclusively; you can try using amazing GoLand IDE by JetBrains. 

For syntax highlight, automatic imports and autoformatting I'm using [vim-go](https://github.com/fatih/vim-go) plugin for Vim but I'll do my best to import everything manually!

[^Top](#top)

<a name="catch"/>

## Small catch

This API will most definitely show some of my preferences in writing code - which are neither bad or good. If there's anything that I do out of preference, it'll be highlighted in this README.

Also, the app will be written without any tests and won't follow TDD practices - because we don't want to run this playground till dawn.

[^Top](#top)

<a name="initial-app-setup"/>

## Initial App Setup

Let's create a new folder for our app and enter it:

```
mkdir go-crud-api && cd go-crud-api
```

For our app to work we need to initialize **Go Modules**. Go Modules is the way how Go manages it's dependencies. 

In your terminal type:

```
go modules init go-crud-api
```

This will create new file `go.mod` in our folder. That's the last thing we'll have to do ANYTHING with our dependencies.

If you have any problems here, do this:

```
export GO111MODULE=on
```

To ensure that your app will use Go Modules.

Our app will use four environmental variables for connecting to Amazon RDS PostgreSQL* instance:

* `PG_USERNAME` - username for our database
* `PG_PASSWORD` - password
* `PG_DB_NAME` - name of our database
* `PG_DB_HOST` - database host

That's all we have to do in our initial setup!

> * Our instance is predefined with dev_ops_playground database. If you're using your own, make sure that your Postgres instance has dev_ops_playground database within.

[^Top](#top)

<a name="entrypoint"/>

## Setup entrypoint

Each Go application requires `main.go` file to run. `main.go` is our entrypoint for the app - whenever we'll run it or compile it, `main.go` has to have all the logic we need for the app to start. Let's write our first Go code!

Create a file called `main.go` and add below:

**main.go**
```go
package main

import (
  "log"
  "os"
)

func main() {
  a := App{}
  a.Initialize()
  a.Run(":9000")
}
```

So, line by line:

**main.go**
```go
package main
```

If we're building executable program, we need to use `main` as our package name. `main` tells the Go compiler that the package should compile as an executable instead of a shared library. If we'd be building a microservices mesh, we might use different names for packages to decouple the code and use it all as a library.

**main.go**
```go
import (
  "log"
  "os"
)
```

`import` statement imports necessary packages to our code. Here we're importing `log` and `os` from standard library - these are the libraries included in Go.

**main.go**
```go
func main() {
```

`func` is the way we define functions in Go. `func main()` is our entry point for the application - anything that is needed for the app to run has to go here. Let's take a look at what we have:

**main.go**
```go
func main() {
  a := App{}
  a.Initialize()
  a.Run(":9000")
}
```

Line by line:

**main.go**
```go
a := App{}
```

`a` is the name of our variable. `:=` is the way we initialize variable and assign the value of right-hand statement. `App{}` is our struct (object) that we'll create in the `server.go`.

**main.go**
```go
a.Initialize()
```

Remember when I've told you that there might be some preferences here? `a.Initialize()` is a method from our `App{}` struct that will perform all the logic before the server runs - establish handlers and connect to PostgreSQL instance.

This could be easily done in `main()` but I prefer keeping my entry function as clean as possible and abstract any extra logic outside.

**main.go**
```go
a.Run(":9000")
```

And last, but not least `a.Run()` method will start the server. The parameter we use here is the port we'll use for the app. This can be changed to anything or even exported as an environmental variable.

About these variables - we have them, but we don't know if they exist before we run the app. We need to check that. In our `main.go` let's add:

**main.go**
```go
func init() {
	if ok := os.Getenv("PG_USERNAME"); ok == "" {
		log.Fatalln("PG_USERNAME not specified")
	}
	if ok := os.Getenv("PG_PASSWORD"); ok == "" {
		log.Fatalln("PG_PASSWORD not specified")
	}
	if ok := os.Getenv("PG_DB_NAME"); ok == "" {
		log.Fatalln("PG_DB_NAME not specified")
	}
	if ok := os.Getenv("PG_DB_HOST"); ok == "" {
		log.Fatalln("PG_DB_HOST_ not specified")
	}
}
```

Woah, a lot of code. Don't panic, we'll get through it.

`func init()` is a in-built function that runs before `main()` runs. It's a perfect candidate for our app to check if our necessary environmental variables exists. As you can see, we repeat the whole thing four times, so let's take one of these statements and inspect it:

**main.go**
```go
if ok := os.Getenv("PG_PASSWORD"); ok == "" {
  log.Fatalln("PG_PASSWORD not specified")
}
```

`if` is the classic **if** statement we know from any other programming language. We'll see a lot of it in Go. So, what we have here:

* `if ok :=` starts the statement, creates a variable `ok` and assigns the value of
* `os.Getenv("PG_PASSWORD");` - `os.Getenv` is a function from `os` package that checks for an env variable named `PG_PASSWORD`
* `ok == ""` - we could easily spread the whole line into:

**main.go**
```go
ok := os.Getenv("PG_PASSWORD")
if ok == "" {
```

But in our case, it's makes way more sense to keep it as a one-liner. Here we check if the `ok` variable is an empty string. `os.Getenv` always return a string - if the variable exists if will be something; if not, then it'll be an empty string - `""`.

If the variable is an empty string then:

**main.go**
```go
log.Fatalln("PG_PASSWORD not specified")
```

`log.Fatalln` is a function from `log` package that prints something to `stdout` and is followed by a call to `os.Exit(1)`. So, in other terms - it prints our error and then exits the program.

Huh, we've done a lot! Our `main.go` file should look like this now:

**main.go**
```go
package main

import (
	"log"
	"os"
)

func main() {
	a := App{}
	a.Initialize()
	a.Run(":9000")
}

func init() {
	if ok := os.Getenv("PG_USERNAME"); ok == "" {
		log.Fatalln("PG_USERNAME not specified")
	}
	if ok := os.Getenv("PG_PASSWORD"); ok == "" {
		log.Fatalln("PG_PASSWORD not specified")
	}
	if ok := os.Getenv("PG_DB_NAME"); ok == "" {
		log.Fatalln("PG_DB_NAME not specified")
	}
	if ok := os.Getenv("PG_DB_HOST"); ok == "" {
		log.Fatalln("PG_DB_HOST_ not specified")
	}
}
```

[^Top](#top)

<a name="initial-server"/>

## Initial server

Ok, we've got the `main.go` file done. Let's move to a new file called `server.go` and create logic for `App{}`, `Initialize()` and `Run()`:

**server.go**
```go
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
)

type App struct {
	Router *mux.Router
	Broker Broker
}

func (a *App) Initialize() {

}

func (a *App) Run(addr string) {

}
```

Some new things here:

In import you can see `github.com/gorilla/mux` and `github.com/rs/cors` - that means that we'll use 3rd party library for some of our application.
[Mux](https://github.com/gorilla/mux) is one of the nicest HTTP routers for Go with insanely good documentation. 
[Cors](https://github.com/rs/cors) is a handler implementing `Cross Origin Resource Sharing W3 specification` - in short, this is what we need to give this API to our FrontEnd developers and to make the whole API more secure.

Also, we have a definition of struct:

**server.go**
```go
type App struct {
  Router *mux.Router
  Broker Broker
}
```

**Structs** in Go are the way we deal with Object-Oriented code. It's not entirely the same way as we'd have in any other language - for example, Go doesn't have classes. Keyword `type` defines that whatever will follow, will be taken as type (this will make way more sense in the next chapter of our workshop).

Our `App` struct has two fields - `Router` and `Broker`. Without getting too much into computer science theory, `Router` is of a type of `*mux.Router` which means it's a pointer to `Router` type in `mux` package. In other words - there's a `mux.Router` type somewhere in memory, and we want our `Router` to reference it.

Second field is way easier - `Broker` will be of a type `Broker` which we'll define in a sec.

Let's add some more code to `initialize()` and `run()`:

**server.go**
```go
func (a *App) Initialize() {

  router := mux.NewRouter()

  prefix := "/api"

  a.Router = router
}

func (a *App) Run(addr string) {
  handler := cors.Default().Handler(a.Router)
  log.Printf("Server is listening on %v", addr)
  http.ListenAndServe(addr, handler)
}
```

Now we can talk about that `func (a *App)` thing here. As I've said earlier, Go deals with OOP a bit different that other languages. Both `Initialize` and `Run` are methods of `App` struct. The `(a *App)` denotes, that these methods will use the memory from `App`. If we'd lose the `*`, then these methods would create a new copy of `App` every time we'd call them.

In `Initialize()` now we have `router` which will hold all handlers for our api. We have `prefix` - this is my preference - which we could use for versioning later in our application. Heck, we could even export it as a environmental variable and have different versions per each docker container if we'd want to. Last, we assign `router` to `a.Router` - which is `Router` within `App` struct.

In `Run` we've added full code for the API to run, we've defined default cors support ([cors](https://github.com/rs/cors) documentation defines what that is) and we call `http.ListenAndServe()` function to make the whole thing alive. 

[^Top](#top)

<a name="broker"/>

## Broker

Probably you've been wondering "what is that Broker thingy?" - Broker is my way of defining logic required for DB connection. This `broker` is very much stripped-down version of the one I use as a package im my code.

Without further ado, create a file `broker.go` and add below:

**broker.go**
```go
package main

import (
	"fmt"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

type Broker struct {
	postgresDBSetup pgSetup
	postgresDB      *gorm.DB
}

func NewBroker() Broker {
	b := Broker{}
	return b
}

type pgSetup struct {
	username string
	password string
	dbName   string
	dbHost   string
}

type Post struct {
	Id        uuid.UUID `gorm:"type:uuid"`
	Title     string    `json:"title"`
	Content   string    `json:"content"`
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (b *Broker) InitializeBroker() error {
	err := b.setPostgres()
	if err != nil {
		return err
	}

	return nil
}

func (b *Broker) GetPostgres() *gorm.DB {
	return b.postgresDB
}

func (b *Broker) SetPostgresConfig(username, password, dbName, dbHost string) {
	pgs := pgSetup{
		username: username,
		password: password,
		dbName:   dbName,
		dbHost:   dbHost,
	}
	b.postgresDBSetup = pgs
}

func (b *Broker) setPostgres() error {
	dbUri := fmt.Sprintf("host=%s user=%s dbname=%s sslmode=disable password=%s", b.postgresDBSetup.dbHost, b.postgresDBSetup.username, b.postgresDBSetup.dbName, b.postgresDBSetup.password)
	conn, err := gorm.Open("postgres", dbUri)
	if err != nil {
		return err
	}
	b.postgresDB = conn
	b.postgresDB.LogMode(true)
	b.postgresDB.Debug().AutoMigrate(
		&Post{},
	)
	return nil
}
```

Break it apart:

**broker.go**
```go
import (
	"fmt"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

type Broker struct {
	postgresDBSetup pgSetup
	postgresDB      *gorm.DB
}

func NewBroker() Broker {
	b := Broker{}
	return b
}
```

There's a few interesting things here:

* `_ "github.com/jinzhu/gorm/dialects/postgres"` is something called "import with blank identifier" (explained well [here](https://www.calhoun.io/why-we-import-sql-drivers-with-the-blank-identifier/)), that allows our code to understand the database dialect;
* finally we can see how `Broker` type looks
* there's `func NewBroker()` function that returns `Broker`. We could get away with calling in `server.go` something like:

```go
b := Broker{}
```

But in this case, I think, it makes it more readable. And if we'd have to do any setup for our broker, we can do it here.

**broker.go**
```go
type Post struct {
	Id        uuid.UUID `gorm:"type:uuid"`
	Title     string    `json:"title"`
	Content   string    `json:"content"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
```

`Post` struct will be our main struct holding data for our posts. Few interesting things:

* what's `uuid.UUID`? It's a type of `UUID` from the [uuid](https://github.com/gofrs/uuid) package, that will give us a [uuid v4](https://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_(random)), which is a fully random identifier;
* those `gorm:"type:uuid"` and `json:"title"` fields are helpers for the database to understand what's the type of the field and for Go JSON Marshal mechanism to know what's the name of the key in JSON payload.

In **Structs** there's one thing you should be aware of - if keys of your type are capitalized, then they'll be exported/used to encode/decode to JSON. If we'd have something like:

```go
type Post struct {
	Id        uuid.UUID `gorm:"type:uuid"`
	title     string    `json:"title"`
	content   string    `json:"content"`
	CreatedAt time.Time
	UpdatedAt time.Time
}
```

Then no matter however hard we've tried, Go won't decode/encode those fields.

**broker.go**
```go
func (b *Broker) GetPostgres() *gorm.DB {
	return b.postgresDB
}
```

I like to have `b.postgresDB` as a small Get wrapper - we'll use this function a lot in our handlers code.

**broker.go**
```go
func (b *Broker) setPostgres() error {
	dbUri := fmt.Sprintf("host=%s user=%s dbname=%s sslmode=disable password=%s", b.postgresDBSetup.dbHost, b.postgresDBSetup.username, b.postgresDBSetup.dbName, b.postgresDBSetup.password)
	conn, err := gorm.Open("postgres", dbUri)
	if err != nil {
		return err
	}
	b.postgresDB = conn
	b.postgresDB.LogMode(true)
	b.postgresDB.Debug().AutoMigrate(
		&Post{},
	)
	return nil
}
```

And this is the meat and bones of our `broker`:

* dbUri - again, my preference - we create a connection string to use with `gorm.Open`. That string holds all the values we need to connect to Postgres;
* `b.postgresDB.LogMode(true)` - this line allows us to see the queries the engine makes to postgres

```go
b.postgresDB.Debug().AutoMigrate(
  &Post{},
)
```

This is my favourite part of the broker - thanks to `AutoMigrate` function, we can migrate the schema automatically to postgres! Schema is created from `Post` struct, that's why we have `&Post{}`. `&` returns the address of a variable (again, pointers!) - without that, the engine would panic and break.

Once we have `broker.go` done, let's go back to `server.go` and update everything we need for connecting to the db.

[^Top](#top)

<a name="update-server"/>

## Update server

In `server.go`, just after `Initialize()` let's add:

**server.go**
```go
a.Broker = NewBroker()
PgUsername := os.Getenv("PG_USERNAME")
PgPassword := os.Getenv("PG_PASSWORD")
PgDbName := os.Getenv("PG_DB_NAME")
PgDbHost := os.Getenv("PG_DB_HOST")
a.Broker.SetPostgresConfig(PgUsername, PgPassword, PgDbName, PgDbHost)
if err := a.Broker.InitializeBroker(); err != nil {
  log.Fatalf("Error initializing postgres connection: %v", err)
}
```

This will, again, create the broker, get all the necessary environmental variables and initialize the `broker`. If the process breaks, `log.Fatal` will print the exact error and then exit the application.

After that, our `initialize()` function will look like this:

**server.go**
```go
func (a *App) Initialize() {
  a.Broker = NewBroker()
  PgUsername := os.Getenv("PG_USERNAME")
  PgPassword := os.Getenv("PG_PASSWORD")
  PgDbName := os.Getenv("PG_DB_NAME")
  PgDbHost := os.Getenv("PG_DB_HOST")
  a.Broker.SetPostgresConfig(PgUsername, PgPassword, PgDbName, PgDbHost)
  if err := a.Broker.InitializeBroker(); err != nil {
    log.Fatalf("Error initializing postgres connection: %v", err)
  }

  router := mux.NewRouter()

  prefix := "/api"

  a.Router = router
}
```

Pretty empty, isn't it? Let's recap what we have so far:

* We have `main.go` that will be our entrypoint and will check for all environmental variables we might need
* We have `server.go` that will deal with the server initialization and running
* We have `broker.go` that will deal with database connection and schema migration

Next step - handlers. Let's handle that! (Sorry, couldn't resist)

[^Top](#top)

<a name="handlers"/>

## Handlers

Handler is a function, that will get something from our request, do some logic and then return some response to the client. So far, we've set up `router` and `prefix` for the routes. Let's add them.

In `initialize()` let's define the handlers:

**server.go**
```go
router.Handle(prefix+"/post", a.GetAllPost()).Methods(http.MethodGet)
router.Handle(prefix+"/post/{post_id}", a.GetSinglePost()).Methods(http.MethodGet)
router.Handle(prefix+"/post", a.CreatePost()).Methods(http.MethodPost)
router.Handle(prefix+"/post/{post_id}", a.UpdatePost()).Methods(http.MethodPut)
router.Handle(prefix+"/post/{post_id}", a.DeletePost()).Methods(http.MethodDelete)
```

Let's take apart one of these routes:

```go
router.Handle(prefix+"/post/{post_id}", a.GetSinglePost()).Methods(http.MethodGet)
```

* `router.Handle` - this is a method from `mux.NewRouter()` that allows us to register the handler
* `(prefix+"/post/{post_id})` - we concatenate our `prefix` with the rest of the route. `{post_id}` will be the variable which we'll use in handler's logic.
* `a.GetSinglePost()` - this will be the function we will write in next chapter. Take note on `a.` - if you remember, most of the functions so far use `App` struct to access variables across multiple components. We could get away without using that - then, we'd have to either establish connection to Postgres every time we want to use it (which is wasteful) or use global variables (which we don't want to do).
* `Methods(http.MethodGet)` - this is the logic for our router that will denote which method was used for the request. As you can see, we also have `prefix+"/post/{post_id}"` for `UpdatePost()` and `DeletePost()` - we need a way to switch between these functions. `http.MethodGet` is a constant defined in `http` package which is simply a string `"GET"`

We've got the basics, let's write the logic.

[^Top](#top)

<a name="more-handlers"/>

## More Handlers

Create new file called `handlers.go` and let's scaffold our handlers:

**handlers.go**
```go
package main

import (
  "encoding/json"
  "log"
  "net/http"

  "github.com/gofrs/uuid"
  "github.com/gorilla/mux"
)

func (a *App) GetAllPost() http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

  })
}

func (a *App) GetSinglePost() http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

  })
}

func (a *App) CreatePost() http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

  })
}

func (a *App) UpdatePost() http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

  })
}

func (a *App) DeletePost() http.Handler {
  return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

  })
}
```

Some of you might go now: 

"But why are you doing that? Why not do:

```go
func (a *App) GetAllPost(w http.ResponseWriter, r *http.Request) {

}
```
And keep the logic simple?"

What I'm using here is a **decorator pattern**. Later, when we'll add logic to the handlers, we can set up the database before the return of the function, which in a long run saves the resources and simplifies the logic a bit. Also helps us with refactoring the application once we'll be done with it.

Before writing logic for the handlers, let's add one more function in `handlers.go`:

**handlers.go**
```go
func JSONResponse(w http.ResponseWriter, code int, output interface{}) {
	response, _ := json.Marshal(output)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}
```

Another small preference of mine - with `JSONResponse` I can quickly set up the response from the API, marshal anything I need to JSON and return it to the client.

For the sake of time, code for each function and the explanation for it is within next 5 paragraphs here:

### GetAllPost
<details>
  <summary>Click to expand</summary>

  ```go
    func (a *App) GetAllPost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        posts := make([]*Post, 0)
        defer r.Body.Close()
        err := db.Table("posts").Find(&posts).Error
        if err != nil {
          log.Printf("get all posts %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, posts)
      })
    }
  ```

  This is where the decorator pattern shines - by keeping the `db` variable before `return`, it'll be initialized once until the application exits and reused by each call to `GetAllPost()`.

  We initialize `post` variable which is a slice of `Post` - in other words, it's an array of objects of type `Post`.

  `defer` is a keyword in Go, that means whenever the function exit, execute. In this case it closes the stream of `r.Body` - we could easily do nothing about it, but then it creates a problem with a memory leak from not closed stream.

  `db.Table("posts").Find(&posts).Error` is a statement from `gorm` that allows us to query the database with chaining functions instead of writing the statements ourselves. Of course, if we'd need to do so, we can!

  Then the last part is the most interesting one here:

  ```go
    if err != nil {
      log.Printf("get all posts %v", err)
      JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
      return
    }
  ```

  If you remember the call to `JSONResponse` it took three arguments:
  
  * `w` of type ` http.ResponseWriter`
  * `code` of type `int`
  * `output` of type `interface{}`
  
  `interface{}` type in Go is a quite interesting one. In Layman's terms it's an in-built type that it kind of a wildcard - any type satisfies this interface, therefore it can be anything. That allows us to return `posts` in the last line as a JSON array and to return an error in `if err != nil` statement.

  If you look at `map[string]interface{}` you can understand it as a key-value pair that has a key of type `string` and a value of type `interface`.

</details>

### GetSinglePost
<details>
  <summary>Click to expand</summary>

  ```go
    func (a *App) GetSinglePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        var post Post
        defer r.Body.Close()
        err := db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
        if err != nil {
          log.Printf("get single post %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, post)
      })
    }
  ```
  
  The only difference from `GetAllPost` here is different variable to which we will write data - `var post Post` and different query to the database.

</details>

### CreatePost
<details>
  <summary>Click to expand</summary>

  ```go
    func (a *App) CreatePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        var post Post
        decoder := json.NewDecoder(r.Body)
        decoder.DisallowUnknownFields()
        err := decoder.Decode(&post)
        if err != nil {
          JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
          return
        }
        defer r.Body.Close()

        uid, _ := uuid.NewV4()
        post.Id = uid
        err = db.Create(&post).Error
        if err != nil {
          log.Printf("create post error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusCreated, nil)
      })
    }
  ```
  
  Let's take out the interesting bits:

  * `decoder` - as `CreatePost` will require a payload to create the post, we need to decode it somehow. Remember `Post` struct?
  
  ```go
    type Post struct {
      Id        uuid.UUID `gorm:"type:uuid"`
      Title     string    `json:"title"`
      Content   string    `json:"content"`
      CreatedAt time.Time
      UpdatedAt time.Time
    }
  ```

  As we can see, this type will require `title` and `content` in the payload. So `decoder` will decode the JSON payload into Go type which we can use.

  * `decoder.DisallowUnknownFields()` is a method that will return error if the payload contains any keys that we don't allow

  * `uid, _ := uuid.NewV4()` - creates a new `UUID`

  * `db.Create(&post).Error` - creates a new post in `posts` table - gorm is smart enough to know which struct is assigned to which table!

</details>

### UpdatePost
<details>
  <summary>Click to expand</summary>

  ```go
    func (a *App) UpdatePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        var post Post
        var newPost Post
        decoder := json.NewDecoder(r.Body)
        decoder.DisallowUnknownFields()
        err := decoder.Decode(&newPost)
        if err != nil {
          JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
          return
        }
        defer r.Body.Close()

        err = db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
        if err != nil {
          log.Printf("update post fetch error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        post.Content = newPost.Content
        db.Save(&post)
        JSONResponse(w, http.StatusNoContent, nil)
      })
    }
  ```

  Compared to `CreatePost` the only difference here is that we fetch the already existing post, change it's values from the payload and then save the updated one. Easy-peasy!
  
</details>

### DeletePost
<details>
  <summary>Click to expand</summary>

  ```go
    func (a *App) DeletePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        defer r.Body.Close()
        err := db.Where("id = ?", vars["post_id"]).Delete(&Post{}).Error
        if err != nil {
          log.Printf("delete post etch error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, nil)
      })
    }
  ```

  Simplest one of all and the best moment to mention `vars := mux.Vars(r)`. In `DeletePost` handler we have `{post_id}` variable. This will be fetched by `mux.Vars()` and used in the query as `vars["post_id"]` to find the correct record in the database and delete it.
  
</details>

This is how the full file should look now:

**handlers.go**
```go
package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/gofrs/uuid"
	"github.com/gorilla/mux"
)

func (a *App) GetAllPost() http.Handler {
	db := a.Broker.GetPostgres()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		posts := make([]*Post, 0)
		defer r.Body.Close()
		err := db.Table("posts").Find(&posts).Error
		if err != nil {
			log.Printf("get all posts %v", err)
			JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
			return
		}

		JSONResponse(w, http.StatusOK, posts)
	})
}

func (a *App) GetSinglePost() http.Handler {
	db := a.Broker.GetPostgres()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		var post Post
		defer r.Body.Close()
		err := db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
		if err != nil {
			log.Printf("get single post %v", err)
			JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
			return
		}

		JSONResponse(w, http.StatusOK, post)
	})
}

func (a *App) CreatePost() http.Handler {
	db := a.Broker.GetPostgres()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var post Post
		decoder := json.NewDecoder(r.Body)
		decoder.DisallowUnknownFields()
		err := decoder.Decode(&post)
		if err != nil {
			JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
			return
		}
		defer r.Body.Close()

		uid, _ := uuid.NewV4()
		post.Id = uid
		err = db.Create(&post).Error
		if err != nil {
			log.Printf("create post error %v", err)
			JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
			return
		}

		JSONResponse(w, http.StatusCreated, nil)
	})
}

func (a *App) UpdatePost() http.Handler {
	db := a.Broker.GetPostgres()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		var post Post
		var newPost Post
		decoder := json.NewDecoder(r.Body)
		decoder.DisallowUnknownFields()
		err := decoder.Decode(&newPost)
		if err != nil {
			JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
			return
		}
		defer r.Body.Close()

		err = db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
		if err != nil {
			log.Printf("update post fetch error %v", err)
			JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
			return
		}

		post.Content = newPost.Content
		db.Save(&post)
		JSONResponse(w, http.StatusNoContent, nil)
	})
}

func (a *App) DeletePost() http.Handler {
	db := a.Broker.GetPostgres()
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		defer r.Body.Close()
		err := db.Where("id = ?", vars["post_id"]).Delete(&Post{}).Error
		if err != nil {
			log.Printf("delete post etch error %v", err)
			JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
			return
		}

		JSONResponse(w, http.StatusOK, nil)
	})
}

func JSONResponse(w http.ResponseWriter, code int, output interface{}) {
	response, _ := json.Marshal(output)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}
```

[^Top](#top)

<a name="finish-server"/>

## Finish server

We're almost there! One last thing left for us - another preference of mine - let's print out all the available routes in our app. In `server.go` in `Intialize()` add:

**server.go**
```go
log.Printf("Available routes:\n")
	router.Walk(func(route *mux.Route, router *mux.Router, ancestors []*mux.Route) error {
		t, err := route.GetPathTemplate()
		if err != nil {
			return err
		}
		m, err := route.GetMethods()
		if err != nil {
			return err
		}
		fmt.Printf("%s\t%s\n", m, t)
		return nil
	})
```

This will print our routes in a nice fashion as Method - Path.

If you need to cross-reference your code, take a peek into below paragraphs:

## main.go

<details>
  <summary>Click to expand</summary>

  ```go
    package main

    import (
      "log"
      "os"
    )

    func main() {
      a := App{}
      a.Initialize()
      a.Run(":9000")
    }

    func init() {
      if ok := os.Getenv("PG_USERNAME"); ok == "" {
        log.Fatalln("PG_USERNAME not specified")
      }
      if ok := os.Getenv("PG_PASSWORD"); ok == "" {
        log.Fatalln("PG_PASSWORD not specified")
      }
      if ok := os.Getenv("PG_DB_NAME"); ok == "" {
        log.Fatalln("PG_DB_NAME not specified")
      }
      if ok := os.Getenv("PG_DB_HOST"); ok == "" {
        log.Fatalln("PG_DB_HOST_ not specified")
      }
    }
  ```

</details>

## server.go

<details>
  <summary>Click to expand</summary>

  ```go
    package main

    import (
      "fmt"
      "log"
      "net/http"
      "os"

      "github.com/gorilla/mux"
      "github.com/rs/cors"
    )

    type App struct {
      Router *mux.Router
      Broker Broker
    }

    func (a *App) Initialize() {
      a.Broker = NewBroker()
      PgUsername := os.Getenv("PG_USERNAME")
      PgPassword := os.Getenv("PG_PASSWORD")
      PgDbName := os.Getenv("PG_DB_NAME")
      PgDbHost := os.Getenv("PG_DB_HOST")
      a.Broker.SetPostgresConfig(PgUsername, PgPassword, PgDbName, PgDbHost)
      if err := a.Broker.InitializeBroker(); err != nil {
        log.Fatalf("Error initializing postgres connection: %v", err)
      }

      router := mux.NewRouter()

      prefix := "/api"

      router.Handle(prefix+"/post", a.GetAllPost()).Methods(http.MethodGet)
      router.Handle(prefix+"/post/{post_id}", a.GetSinglePost()).Methods(http.MethodGet)
      router.Handle(prefix+"/post", a.CreatePost()).Methods(http.MethodPost)
      router.Handle(prefix+"/post/{post_id}", a.UpdatePost()).Methods(http.MethodPut)
      router.Handle(prefix+"/post/{post_id}", a.DeletePost()).Methods(http.MethodDelete)

      log.Printf("Available routes:\n")
      router.Walk(func(route *mux.Route, router *mux.Router, ancestors []*mux.Route) error {
        t, err := route.GetPathTemplate()
        if err != nil {
          return err
        }
        m, err := route.GetMethods()
        if err != nil {
          return err
        }
        fmt.Printf("%s\t%s\n", m, t)
        return nil
      })
      a.Router = router
    }

    func (a *App) Run(addr string) {
      handler := cors.Default().Handler(a.Router)
      log.Printf("Server is listening on %v", addr)
      http.ListenAndServe(addr, handler)
    }
  ```

</details>

## broker.go

<details>
  <summary>Click to expand</summary>

  ```go
    package main

    import (
      "fmt"
      "time"

      "github.com/gofrs/uuid"
      "github.com/jinzhu/gorm"
      _ "github.com/jinzhu/gorm/dialects/postgres"
    )

    type Broker struct {
      postgresDBSetup pgSetup
      postgresDB      *gorm.DB
    }

    func NewBroker() Broker {
      b := Broker{}
      return b
    }

    type pgSetup struct {
      username string
      password string
      dbName   string
      dbHost   string
    }

    type Post struct {
      Id        uuid.UUID `gorm:"type:uuid"`
      Title     string    `json:"title"`
      Content   string    `json:"content"`
      CreatedAt time.Time
      UpdatedAt time.Time
    }

    func (b *Broker) InitializeBroker() error {
      err := b.setPostgres()
      if err != nil {
        return err
      }

      return nil
    }

    func (b *Broker) GetPostgres() *gorm.DB {
      return b.postgresDB
    }

    func (b *Broker) SetPostgresConfig(username, password, dbName, dbHost string) {
      pgs := pgSetup{
        username: username,
        password: password,
        dbName:   dbName,
        dbHost:   dbHost,
      }
      b.postgresDBSetup = pgs
    }

    func (b *Broker) setPostgres() error {
      dbUri := fmt.Sprintf("host=%s user=%s dbname=%s sslmode=disable password=%s", b.postgresDBSetup.dbHost, b.postgresDBSetup.username, b.postgresDBSetup.dbName, b.postgresDBSetup.password)
      conn, err := gorm.Open("postgres", dbUri)
      if err != nil {
        return err
      }
      b.postgresDB = conn
      b.postgresDB.LogMode(true)
      b.postgresDB.Debug().AutoMigrate(
        &Post{},
      )
      return nil
    }
  ```

</details>

## handlers.go

<details>
  <summary>Click to expand</summary>

  ```go
    package main

    import (
      "encoding/json"
      "log"
      "net/http"

      "github.com/gofrs/uuid"
      "github.com/gorilla/mux"
    )

    func (a *App) GetAllPost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        posts := make([]*Post, 0)
        defer r.Body.Close()
        err := db.Table("posts").Find(&posts).Error
        if err != nil {
          log.Printf("get all posts %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, posts)
      })
    }

    func (a *App) GetSinglePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        var post Post
        defer r.Body.Close()
        err := db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
        if err != nil {
          log.Printf("get single post %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, post)
      })
    }

    func (a *App) CreatePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        var post Post
        decoder := json.NewDecoder(r.Body)
        decoder.DisallowUnknownFields()
        err := decoder.Decode(&post)
        if err != nil {
          JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
          return
        }
        defer r.Body.Close()

        uid, _ := uuid.NewV4()
        post.Id = uid
        err = db.Create(&post).Error
        if err != nil {
          log.Printf("create post error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusCreated, nil)
      })
    }

    func (a *App) UpdatePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        var post Post
        var newPost Post
        decoder := json.NewDecoder(r.Body)
        decoder.DisallowUnknownFields()
        err := decoder.Decode(&newPost)
        if err != nil {
          JSONResponse(w, http.StatusBadRequest, map[string]interface{}{"error": err.Error()})
          return
        }
        defer r.Body.Close()

        err = db.Table("posts").Where("id = ?", vars["post_id"]).First(&post).Error
        if err != nil {
          log.Printf("update post fetch error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        post.Content = newPost.Content
        db.Save(&post)
        JSONResponse(w, http.StatusNoContent, nil)
      })
    }

    func (a *App) DeletePost() http.Handler {
      db := a.Broker.GetPostgres()
      return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        vars := mux.Vars(r)
        defer r.Body.Close()
        err := db.Where("id = ?", vars["post_id"]).Delete(&Post{}).Error
        if err != nil {
          log.Printf("delete post etch error %v", err)
          JSONResponse(w, http.StatusInternalServerError, map[string]interface{}{"error": err.Error()})
          return
        }

        JSONResponse(w, http.StatusOK, nil)
      })
    }

    func JSONResponse(w http.ResponseWriter, code int, output interface{}) {
      response, _ := json.Marshal(output)
      w.Header().Set("Content-Type", "application/json")
      w.WriteHeader(code)
      w.Write(response)
    }
  ```

</details>

[^Top](#top)

<a name="test-server"/>

## Test the server

In the main directory of our app type `go run .`. This is what you should see:

```
2020/05/18 12:54:20 Available routes:
[GET]	/api/post
[GET]	/api/post/{post_id}
[POST]	/api/post
[PUT]	/api/post/{post_id}
[DELETE]	/api/post/{post_id}
2020/05/18 12:54:20 Server is listening on :9000
```

`go run .` is a command that compiles and runs the named main Go package. But let's kill the process (ctrl+C) and build the executable by typing `go build -o crud-api`. `-o` flag names the executable.

So now, we can do `./crud-api` and we should get the same output!

Now, let's run another terminal and test all the routes:

(bear in mind - your id's will be way different than mine)

### Get Posts
`curl localhost:9000/api/post`

### Get Single Post
`curl localhost:9000/api/post/{id}`

### Create New Post
`curl -X POST -d '{"title":"my new post", "content": "such a good writer"}' localhost:9000/api/post`

### Modify Post
`curl -X PUT -d '{"content": "this is better"}' localhost:9000/api/post/{id}`

### Delete Post
`curl -X DELETE localhost:9000/api/post/{id}`

[^Top](#top)

<a name="dockerfile"/>

## Dockerfile

I've promised we'll make the API deployable so let's add the dockerfile:

```dockerfile
FROM golang
ENV GO111MODULE=on
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o crud-api
EXPOSE 9000
ENTRYPOINT ["./crud-api"]
```

[^Top](#top)

<a name="improve"/>

## How To Improve

There's a few things to improve in our app:

* The logic for DB actions could be abstracted from the handlers
* Handlers could have more robust checks
* There's no tests written for the API (apart from our simple `curl` commands)
* Postgres might be abstracted into an interface - so we could quickly plug another database engine
* Graceful shutdown

Of course there's more than this, but as an API written from ground up in a few hours I think it's better than ok!

[^Top](#top)

<a name="author"/>

## Word from the author

Hope you've learned something about Go in the process and I was able to showcase the strengths and small quirks of writing in Go!

If you have any questions or problems, catch me on [LinkedIn](https://www.linkedin.com/in/arturkondas/), [Twitter](https://twitter.com/arturkondas) or [Github](https://github.com/youshy)

Read more about me, my stories and thoughts and find other Go tutorials @ [akondas.com](https://akondas.com)

[^Top](#top)
