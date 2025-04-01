const express = require('express');
const https = require('https'); // Para solicitudes HTTPS seguras

const app = express();
const port = 3000;

const apiUrl = 'https://your-api.com/inventory'; // Reemplazar con la URL de API real

app.get('/inventory', (req, res) => {
  https.get(apiUrl, (apiRes) => {
    let inventoryData = '';
    apiRes.on('data', (chunk) => {
      inventoryData += chunk;
    });

    apiRes.on('end', () => {
      //Procesar y formatear la respuesta API (inventoryData) según sea necesario
      const formattedData = processInventoryData(inventoryData); // Replace with your logic

      res.json(formattedData); // Enviar los datos formateados de vuelta al cliente.
    });
    });
  }).on('error', (err) => {
    console.error('API error:', err);
    res.status(500).send('Error retrieving inventory data'); // Maneje los errores de API con elegancia
  });

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

// Función para procesar y formatear la respuesta API (reemplazar con su lógica específica)
function processInventoryData(data) {
  // Analizar los datos (por ejemplo, JSON) y extraer información relevante.
  // ...
  return formattedInventoryData; // Devolver los datos procesados ​​y formateados.
}
