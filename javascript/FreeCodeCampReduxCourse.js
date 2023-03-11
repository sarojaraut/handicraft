// The Redux store is an object which holds and manages application state.
// There is a method called createStore() on the Redux object, which you use to create the Redux store.
// This method takes a reducer function as a required argument.

// reducer simply takes state as an argument and returns state
const reducer = (state = 5) => {
    return state;
    }
const store = Redux.createStore(reducer);

// Get State from the Redux Store
const currentState = store.getState();

// Define a Redux Action

// An action is simply a JavaScript object that contains information about an action event that has occurred.
// The Redux store receives these action objects, then updates its state accordingly.
// Sometimes a Redux action also carries some data. For example, the action carries a username after a user logs in.
// While the data is optional, actions must carry a type property that specifies the 'type' of action that occurred.

// Think of Redux actions as messengers that deliver information about events happening in your app to the Redux store.
// The store then conducts the business of updating state based on the action that occurred.

// Define an action here:

const action = {
    type: 'LOGIN'
}

// Define an Action Creator


// After creating an action, the next step is sending the action to the Redux store so it can update its state. In Redux, you define action creators to accomplish this.
// An action creator is simply a JavaScript function that returns an action. In other words, action creators create objects that represent action events.

const action = {
    type: 'LOGIN'
}
  // Define an action creator here:

function actionCreator(){
    return action;
}

// Dispatch an Action Event
// dispatch method is what you use to dispatch actions to the Redux store. Calling store.dispatch() and passing the value returned from an action creator sends an action back to the store.

// Based on the previous challenge's example, the following lines are equivalent, and both dispatch the action of type LOGIN:
store.dispatch(actionCreator());
store.dispatch({ type: 'LOGIN' });

// Excercise

const store = Redux.createStore(
    (state = {login: false}) => state
);

const loginAction = () => {
    return {
        type: 'LOGIN'
    }
};

// Dispatch the action here:
store.dispatch(loginAction());

//---- Handle an Action in the Store
// After an action is created and dispatched, the Redux store needs to know how to respond to that action.
// This is the job of a reducer function. Reducers in Redux are responsible for the state modifications that take place in response to actions.
// A reducer takes state and action as arguments, and it always returns a new state
// The reducer is simply a pure function that takes state and action, then returns new state.
// It is important to see that this is the only role of the reducer. It has no side effects — it never calls an API endpoint and it never has any hidden surprises.

// Another key principle in Redux is that state is read-only. In other words, the reducer function must always return a new copy of state and never modify state directly.
// Redux does not enforce state immutability, however, you are responsible for enforcing it in the code of your reducer functions.

// Fill in the body of the reducer function so that if it receives an action of type 'LOGIN' it returns a state object with login set to true.
// Otherwise, it returns the current state. Note that the current state and the dispatched action are passed to the reducer,
// so you can access the action's type directly with action.type.

const defaultState = {
    login: false
};

const reducer = (state = defaultState, action) => {
// Change code below this line
    if (action.type === "LOGIN") {
        return {
            login: true
        };
    } else {
        return state;
    }
// Change code above this line
};

const store = Redux.createStore(reducer);

const loginAction = () => {
    return {
        type: 'LOGIN'
    }
};

// Use a Switch Statement to Handle Multiple Actions

const defaultState = {
    authenticated: false
  };

  const authReducer = (state = defaultState, action) => {
    // Change code below this line

    switch (action.type){
      case 'LOGIN':
        return {
          authenticated: true
        };
      case 'LOGOUT':
        return {
          authenticated: false
        };
      default:
        return state;
    }


    // Change code above this line
  };

  const store = Redux.createStore(authReducer);

  const loginUser = () => {
    return {
      type: 'LOGIN'
    }
  };

  const logoutUser = () => {
    return {
      type: 'LOGOUT'
    }
  };

//   Use const for Action Types

// Declare LOGIN and LOGOUT as const values and assign them to the strings 'LOGIN' and 'LOGOUT', respectively. Then, edit the authReducer() and the action creators to reference these constants instead of string values.


const LOGIN= 'LOGIN';
const LOGOUT= 'LOGOUT';

const defaultState = {
  authenticated: false
};

const authReducer = (state = defaultState, action) => {

  switch (action.type) {
    case LOGIN:
      return {
        authenticated: true
      }
    case LOGOUT:
      return {
        authenticated: false
      }

    default:
      return state;

  }

};

const store = Redux.createStore(authReducer);

const loginUser = () => {
  return {
    type:LOGIN
  }
};

const logoutUser = () => {
  return {
    type: LOGOUT
  }
};


// Register a Store Listener

// Another method you have access to on the Redux store object is store.subscribe().
// This allows you to subscribe listener functions to the store, which are called whenever an action is dispatched against the store.
// store.subscribe(()=>console.log(store.getState())); you may fetch using getState from within subscribe call

const ADD = 'ADD';
const MINUS = 'MINUS';

const reducer = (state = 0, action) => {
  switch(action.type) {
    case ADD:
      return state + 1;
    default:
      return state;
  }
};

const store = Redux.createStore(reducer);
store.subscribe(()=> count++);

// Global count variable:
let count = 0;

// Change code below this line

// Change code above this line

store.dispatch({type: ADD});
console.log(count);
store.dispatch({type: ADD});
console.log(count);
store.dispatch({type: ADD});
console.log(count);

// Combine Multiple Reducers
// When the state of your app begins to grow more complex, it may be tempting to divide state into multiple pieces.
// Instead, remember the first principle of Redux: all app state is held in a single state object in the store.
// Therefore, Redux provides reducer composition as a solution for a complex state model.
// You define multiple reducers to handle different pieces of your application's state, then compose these reducers together into one root reducer.
// The root reducer is then passed into the Redux createStore() method.

// In order to let us combine multiple reducers together, Redux provides the combineReducers() method.
// This method accepts an object as an argument in which you define properties which associate keys to specific reducer functions.
// The name you give to the keys will be used by Redux as the name for the associated piece of state.

const rootReducer = Redux.combineReducers({
  auth: authenticationReducer,
  notes: notesReducer
});

// Now, the key notes will contain all of the state associated with our notes and handled by our notesReducer.
// This is how multiple reducers can be composed to manage more complex application state.
// In this example, the state held in the Redux store would then be a single object containing auth and notes properties.


const INCREMENT = 'INCREMENT';
const DECREMENT = 'DECREMENT';

const counterReducer = (state = 0, action) => {
  switch(action.type) {
    case INCREMENT:
      return state + 1;
    case DECREMENT:
      return state - 1;
    default:
      return state;
  }
};

const LOGIN = 'LOGIN';
const LOGOUT = 'LOGOUT';

const authReducer = (state = {authenticated: false}, action) => {
  switch(action.type) {
    case LOGIN:
      return {
        authenticated: true
      }
    case LOGOUT:
      return {
        authenticated: false
      }
    default:
      return state;
  }
};

const rootReducer = Redux.combineReducers({
  auth: authReducer,
  count: counterReducer
});

const store = Redux.createStore(rootReducer);

// Send Action Data to the Store

// You can also send specific data along with your actions.
// In fact, this is very common because actions usually originate from some user interaction and tend to carry some data with them.

const ADD_NOTE = "ADD_NOTE";

const notesReducer = (state = "Initial State", action) => {
  switch (action.type) {
    // change code below this line

    case ADD_NOTE:
      return action.text;

    // change code above this line
    default:
      return state;
  }
};

const addNoteText = note => {
  // change code below this line

  return {
    type: ADD_NOTE,
    text: note
  };

  // change code above this line
};

const store = Redux.createStore(notesReducer);

console.log(store.getState());
store.dispatch(addNoteText("Hello!"));
console.log(store.getState());

// Use Middleware to Handle Asynchronous Actions
// how do you call asynchronous endpoints, Here's a brief description how to use this with Redux.
// To include Redux Thunk middleware, you pass it as an argument to Redux.applyMiddleware().
// This statement is then provided as a second optional parameter to the createStore() function. T
// ake a look at the code at the bottom of the editor to see this. Then, to create an asynchronous action,
// you return a function in the action creator that takes dispatch as an argument. Within this function,
// you can dispatch actions and perform asynchronous requests.