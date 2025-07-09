const cityCoordinates = {
  "new york": { lat: 40.7128, lon: -74.0060 },
  "london": { lat: 51.5072, lon: -0.1276 },
  "paris": { lat: 48.8566, lon: 2.3522 },
  "tokyo": { lat: 35.6895, lon: 139.6917 },
  "delhi": { lat: 28.7041, lon: 77.1025 },
  "mumbai": { lat: 19.0760, lon: 72.8777 }
};

// Capitalize helper for prettier output
function capitalize(text) {
  return text.charAt(0).toUpperCase() + text.slice(1);
}

document.addEventListener("DOMContentLoaded", () => {
  const cityInput = document.getElementById("cityInput");
  const getWeatherBtn = document.getElementById("getWeatherBtn");
  const resultDiv = document.getElementById("result");

  getWeatherBtn.addEventListener("click", async () => {
    const city = cityInput.value.trim().toLowerCase();

    // Basic validation
    if (!city) {
      resultDiv.textContent = "Please enter a city name.";
      return;
    }

    // Check if we have coordinates for the requested city
    const coords = cityCoordinates[city];
    if (!coords) {
      resultDiv.textContent = "Coordinates not found for this city.";
      return;
    }

    // Build the Open-Meteo API URL
    const { lat, lon } = coords;
    const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current=temperature_2m`;

    resultDiv.textContent = "Fetching weather...";

    try {
      const response = await fetch(url);
      if (!response.ok) throw new Error("Network response was not ok");
      const data = await response.json();

      const temp = data?.current?.temperature_2m;
      if (temp === undefined) {
        throw new Error("Temperature data unavailable.");
      }

      resultDiv.textContent = `${capitalize(city)}: ${temp}°C`;
    } catch (err) {
      console.error(err);
      resultDiv.textContent = "Failed to fetch weather data. Please try again later.";
    }
  });
});
