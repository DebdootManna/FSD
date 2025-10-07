import React, { useState } from 'react';
import './App.css';

function App() {
  const [tasks, setTasks] = useState([]);
  const [task, setTask] = useState('');

  const addTask = () => {
    if (task.trim()) {
      setTasks([...tasks, { text: task, completed: false }]);
      setTask('');
    }
  };

  const removeTask = (index) => {
    const newTasks = tasks.filter((_, i) => i !== index);
    setTasks(newTasks);
  };

  const toggleTaskCompletion = (index) => {
    const newTasks = tasks.map((t, i) => {
      if (i === index) {
        return { ...t, completed: !t.completed };
      }
      return t;
    });
    setTasks(newTasks);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>To-Do List</h1>
        <div className="task-input">
          <input
            type="text"
            value={task}
            onChange={(e) => setTask(e.target.value)}
            placeholder="Enter a new task"
          />
          <button onClick={addTask}>Add Task</button>
        </div>
        <ul>
          {tasks.map((t, index) => (
            <li key={index} className={t.completed ? 'completed' : ''}>
              <span onClick={() => toggleTaskCompletion(index)}>{t.text}</span>
              <button onClick={() => removeTask(index)}>Delete</button>
            </li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;