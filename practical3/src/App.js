import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [date, setDate] = useState(new Date());

  useEffect(() => {
    const timerID = setInterval(() => tick(), 1000);

    return function cleanup() {
      clearInterval(timerID);
    };
  });

  function tick() {
    setDate(new Date());
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to our page!</h1>
        <h2>It is {date.toLocaleTimeString()}.</h2>
        <h3>Today's date is {date.toLocaleDateString()}.</h3>
      </header>
    </div>
  );
}

export default App;