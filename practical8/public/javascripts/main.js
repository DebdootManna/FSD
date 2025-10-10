document.addEventListener('DOMContentLoaded', () => {
  const countDisplay = document.getElementById('count-display');
  const increaseBtn = document.getElementById('increase-btn');
  const decreaseBtn = document.getElementById('decrease-btn');
  const resetBtn = document.getElementById('reset-btn');

  let count = localStorage.getItem('repCount') ? parseInt(localStorage.getItem('repCount')) : 0;

  const updateDisplay = () => {
    countDisplay.textContent = count;
  };

  const saveCount = () => {
    localStorage.setItem('repCount', count);
  };

  updateDisplay();

  increaseBtn.addEventListener('click', () => {
    count++;
    updateDisplay();
    saveCount();
  });

  decreaseBtn.addEventListener('click', () => {
    if (count > 0) {
      count--;
      updateDisplay();
      saveCount();
    }
  });

  resetBtn.addEventListener('click', () => {
    count = 0;
    updateDisplay();
    saveCount();
  });
});
