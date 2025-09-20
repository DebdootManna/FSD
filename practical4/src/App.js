import React, { useState } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');

  const increment = () => {
    setCount(count + 1);
  };

  const decrement = () => {
    setCount(count - 1);
  };

  const reset = () => {
    setCount(0);
  };

  const incrementFive = () => {
    setCount(count + 5);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Counter App</h1>
        <h2>{count}</h2>
        <div className="button-container">
          <button onClick={increment}>Increment</button>
          <button onClick={decrement}>Decrement</button>
          <button onClick={reset}>Reset</button>
          <button onClick={incrementFive}>Increment Five</button>
        </div>
        <div className="name-container">
          <input
            type="text"
            placeholder="First Name"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
          />
          <input
            type="text"
            placeholder="Last Name"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
          />
          {firstName && lastName && (
            <p>
              Full Name: {firstName} {lastName}
            </p>
          )}
        </div>
      </header>
    </div>
  );
}

export default App;