// https://reactjs.org/tutorial/tutorial.html

// npx create-react-app my-app

// Delete all files in the src/ folder of the new project 

// create new file index.js and index.css

// add following lines to index.js

// to get rid of error Error: ENOSPC: System limit for number of file watchers reached run the below command
// this increases the amount of inotify watchers.
// echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

// Data Change with Mutation 
var player = {score: 1, name: 'Jeff'};
player.score = 2;
// Now player is {score: 2, name: 'Jeff'}

// Data Change without Mutation
var player = {score: 1, name: 'Jeff'};
var newPlayer = Object.assign({}, player, {score: 2});
// Now player is unchanged, but newPlayer is {score: 2, name: 'Jeff'}

// Or if you are using object spread syntax proposal, you can write:
// var newPlayer = {...player, score: 2};

The main benefit of immutability is that it helps you build pure components in React. Immutable data can easily determine if changes have been made, which helps to determine when a component requires re-rendering.


// Function Components

// In React, function components are a simpler way to write components that only contain a render method and don’t have their own state. Instead of defining a class which extends React.Component, we can write a function that takes props as input and returns what should be rendered. Function components are less tedious to write than classes, and many components can be expressed this way.