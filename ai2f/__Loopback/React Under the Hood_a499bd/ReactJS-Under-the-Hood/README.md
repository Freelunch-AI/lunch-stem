# React.JS: Under the Hood

---
>This is a script to support the following slide deck: 
>
>https://slides.com/clayton_m12/react-under-the-hood/


## Introduction

Our goal with the Anvil Developer Network is not just putting a focus on learning how to use development tools properly, but also to gain a better understanding of how these tools are built. So in the spirit of that goal, today, we'll be learning how to build our own version of React, a library that often gets credited for having a lot of "magic" going on beind the scenes.

This talk has a github repo to support it, which contains the final code and a README that walks through each slide and has many setup scripts that you can copy and paste to make setup easier.

## Pre-reqs

Some prereqs to fully understand the material in this workshop are Javascript, React, the npm ecosystem, and the document api. If you aren't super familiar with some of these you will likely still be able to follow if you ASK QUESTIONS!

## What do we know about React

Ok so let's begin by going over what we know about react. Well we know that React is a front-end library that helps us build reusable user interfaces. Getting more specific, React lets us write javascript classes/functions that return a HTML elements that can be rendered to a webpage. This is a good starting piont, but isn't totally correct and we'll see why very soon.

## Key Elements of React

Let's establish what we'll be building today:

The two most important things React provides us are...

1. a way to declare ui elements
2. a way to render these elements to a webpage.

By the end of this talk we will have written enough react support to do both of these things! (and maybe more if time allows)

## Demystifying JSX

To start, let's focus on creating UI elements. But before we do we need to understand what that HTML syntax really is that we use in React. It's not HTML, it's actually a syntax called JSX and it's totally separate from React. A big misconception to newer users of React is that JSX is baked into React but that isn't true. You can use everything React has to offer without ever writing html-like tags.

JSX is very often used with React - and is very beneficial to use, but it does cause a lot of confusion.

JSX is just an HTML-like syntax that can be compiled to plain JS. This compilation can be done by many tools, but the most common JSX compiler is called, Babel. 

Inisde the babel repl:

Input:

```javascript
// JSX

<div style={{color: "red"}}>
  Hello, world
  <button>Click Me</button>
</div>
```

Output:

```javascript
// Javascript

React.createElement("div", {
  style: {
    color: "red"
  }
}, "Hello, world", React.createElement("button", null, "Click Me"));
```

This is what JSX turns into after building our react projects. Each tag gets translated into a function invocation of `React.createElement`. Taking a closer look we can see that the tag name, props, and all children of our component are being passed into the `React.createElement` function.

Our first task in building React will be setting up the compilation of JSX to JS because writing multiple nested function calls to React.createElement is a pain.

Then we'll implement our own version of that `createElement` function.

## Setup Specs

Alright let's do some setup and start building. We need the following things to pull this off...

* node v9
* npm v6
* Babel JSX transpiler

(The specified versions may not be necessary. These are just the versions I will be using throughout the demo)

## Project Setup

#### File Structure Setup

`mkdir react`

`cd react && npm init`

`mkdir src/`

`touch src/index.js`

#### Installing Babel

`npm install --save-dev @babel/core @babel/cli @babel/plugin-transform-react-jsx`


#### Configuring Babel

`touch .babelrc`

Inside `.babelrc` copy and paste the following:

```
{
  "plugins": [["@babel/plugin-transform-react-jsx"]]
}
```

#### Project Build Script

By adding the following to `scripts` in your package.json we will be able to quickly run our `src` folder files through the babel compiler and see the output in a `lib` folder.

`"build": "babel src -d lib"`

#### Testing our Babel Setup

Type the following into `src/index.js`

```javascript
const Card = ({ title, text }) => (
  <div>
    <h2>{title}</h2>
    {text}
  </div>
);

const App = () => (
  <div>
    <Card title="Card One" text="this is card one!" />
  </div>
);
```

Next, we want to try using babel to compile our JSX code into plain Javascript inside a new folder called `lib`. This is what our build script is in charge of.

Run:
`npm run build`

Open the `lib/` folder to find the compiled version of our `src` folder files

#### Quick fixup

The JSX tags are currently being transpiled to a function call to React.createElement, but we're just going to call our function createElement. To change this we will add a pragma spec to our jsx babel plugin. Update your `.babelrc` to look like this...

```
{
  "plugins": [
    [
      "@babel/plugin-transform-react-jsx",
      {
	    "pragma": "createElement"
      }
    ]
  ]
}
```

## Webpage setup (using our lib/index.js file)

`touch index.html`

Add the following to your `index.html` file

```html
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8" />
    <title>react</title>
  </head>
  <body></body>
  <!-- USE OUR lib/index.js SCRIPT -->
  <script type="text/javascript" src="lib/index.js"></script>
</html>
```

## createElement Usage & Implementation

Inside `lib/index.js`:

```javascript
var Card = function Card(_ref) {
  var title = _ref.title,
      text = _ref.text;
  return React.createElement("div", null, React.createElement("h2", null, title), text);
};

var App = function App() {
  return React.createElement("div", null, React.createElement(Card, {
    title: "Card One",
    text: "this is card one!"
  }));
};
```

First, let's look at how createElement is being used before we try building it. We see the first argument is the name of an HTML represented as a string, or in the case of using our own self-written component, a function. 

The second argument is an object of the props passed to
the element. And all remaining arguments are the children of the UI
element.

With this info we can start scaffolding out our `createElement` function

```javascript
const createElement = (
	nodeName,
	props,
	child1,
	child2,
	...,
	childX
) => {
	// TODO: create virtual DOM
}
```

## What is createElement Actually Creating?

What are we actually creating in this function? All we really want in return from calling createElement is an object that contains specifications on what our UI element should look like. You may have seen this referred to as a virtual DOM by React documentation.

Unfamiliar with the DOM? 

> The DOM or document object model is a javascript object that is used to represent the current webpage. It's the object your browser uses to properly render the page and you can access it using the global `document` variable. We're going to manually change the DOM based on what our virtual DOM looks like.

To give you a better idea of what this may look like...

[Refering to slide with full UI creation pipeline]

**Step 1:** Declare a UI element using JSX syntax

**Step 2:** JSX is compiled to calls to `createElement`

**Step 3:** `createElement` returns a plain JS object representing all the characteristics of our UI element (which we'll use to render an actual DOM element)

## First implementation of createElement

Our function accepts the nodeName, props, and a list of children. I'm using a [spread operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax) here on children. All that does is store all arugments after props inside an array called, "children".


Then I'm just returning those things inside a plain js object. This is creating our virtual DOM.

## What's left? (Render Intro)

So, what's left to do? We have our UI element "created" (virtual DOM)...we just need to render it to the webpage (by updating the DOM).

We're going to write our own version of `ReactDOM.render` which will complete the core functionality of react.

## Render Boilerplating

Ok so here is some boilerplate for what our render function will do. The only argument to our render function will be a virtual DOM node retuned from a call to createElement.

First, we need to create an actual DOM node using the document api. You may recognize the document object from using something like `document.getElementById()`. This document object offers a lot more functionality that you can find [here](https://developer.mozilla.org/en-US/docs/Web/API/Document).

Next, well assigning our components props as HTML attributes on the new DOM node we've created.

Then we need to recursively render any children the component has and append the child nodes to our current node.

Lastly, we can just return the node.

## Render Special Cases

This looks good, but we have a couple of issues.

**1.)** This doesn't handle a specific case for rendering children.

JSX:

```html
<div>
	Hello, world
</div>
```

Javascript Output:

```javascript
createElement("div", null, "Hello, world");
```

Virtual DOM returned from createElement:

```javascript
{
	nodeName: "div",
	props: null,
	children: ["Hello, world"]
}
```

Imagine the case when our child element is just plain text. If we look inside our existing render function we see that we recursively call render on each child, so the child being passed to render may just be a string (in this case "Hello, world"). We can't treat this as a regular virtual DOM object and instead will handle this case by just creating a textNode and returning it.

**2.)** We aren't accounting for function components
In the case that we're using a function component, our vnode.nodeName will be of type function (`document.createElement` only works for HTML tag names). So, we need to call that function by passing it the vnode's props and children and render the return value.

## Rendering our Previous Example

```javascript
const Card = ({ title, text }) => (
  <div>
    <h2>{title}</h2>
    <p>{text}</p>
  </div>
);

const App = () => (
  <div>
    <Card title="Card One" text="this is card one!" />
  </div>
);

// render app to the document body
document.body.appendChild(render(<App />));
```

We've implemented a way to define UI elements, and a way to render them. Now let's use them to display "React" components. Just using the components we wrote previously, we can call our render function on our root component (`App`) and then append that to the document body.

### Issue with using React children

We do have an issue on our hands when we try rendering children

```javascript
const Card = ({ children }) => <div>{children}</div>;

const App = () => <Card>Hello, world</Card>;
```

Error walkthrough:

When transpiled this will translate our `Card` component into

```javascript
createElement("div", null, ["Hello, world"])
```

this call returns us the following

```javascript
{
nodeName: "div",
props: null
children: [["Hello, world"]] // <-- this is the issue
}
```

Because of the nested array we'll eventually try to render
the inner array as if it were a node. One possible solution to fix this is to change our createElement a bit...

```javascript
const createElement = (
  nodeName, // String / Function
  props, // Object
  ...children
) => {
  return {
    nodeName,
    props,
    children: children.flat() // <-- the fix
  };
};
```

Array.flat() compresses inner arrays by a single level

Example:

```javascript
[1, [2, 3]].flat();
// => [1, 2, 3]
```

## Pokedex Application

Our element creation and rendering are both working as expected. Now, we can write a more useful application.

```javascript
const starters = [
  {
    name: "bulbasaur",
    img:
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
  },
  {
    name: "charmander",
    img:
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"
  },
  {
    name: "squirtle",
    img:
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"
  }
];

const Box = ({ children }) => {
	return (
		<div>{children}</div>
	);
}

const TitleBox = ({ title, children }) => {
	return (
	  <div style={`padding: 2em;`}>
	    <h3>{title}</h3>
	    <Box>{children}</Box>
	  </div>
	);
}

const App = () => {
	return (
	  <div style={"text-align: center;"}>
	    <TitleBox title={"Pokemon"}>
	      {starters.map(({ name, img }) => (
	        <div>
	          <img src={img} />
	          <p>{name}</p>
	        </div>
	      ))}
	    </TitleBox>
	  </div>
	);
}

document.body.appendChild(render(<App />))
```

## Implementing (a wildly inefficient) application state manager

Another important feature of any UI library is state management. We're going to build a quick example of global state management for our version of react. Anytime the state is updated we will completely re-render our page.

```javascript
let state = {}

function setState(newState) {
	state = newState

	/* remove existing child nodes in body */
	let body = document.body
	while (body.firstChild) {
    	body.removeChild(body.firstChild);
  	}

  	document.body.appendChild(render(<App />))
}
```

## Making a counter application

```javascript
let state = {};

const setState = updatedState => {
  state = updatedState;

  /* Remove previously rendered component */
  const body = document.body;
  while (body.firstChild) {
    body.removeChild(body.firstChild);
  }

  document.body.appendChild(render(<App />));
};

const decCount = () => {
  setState({ count: state.count - 1 });
};

const incCount = () => {
  setState({ count: state.count + 1 });
};

const Box = ({ children }) => <div>{children}</div>;

const TitleBox = ({ title, children }) => (
  <div style={`padding: 2em;`}>
    <h3>{title}</h3>
    <Box>{children}</Box>
  </div>
);

const Counter = () => {
  return (
    <TitleBox title={"Counter"}>
      <div>
        <code>{state.count.toString()}</code>
      </div>
      <button onclick={"decCount()"}>-</button>
      <button onclick={"incCount()"}>+</button>
    </TitleBox>
  );
};

const App = () => (
  <div style={"text-align: center;"}>
    <Counter />
  </div>
);

const initialState = {
  count: 0
};

// Initial render.
setState(initialState);
```
