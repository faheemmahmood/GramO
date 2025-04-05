const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const grammarRoutes = require('./routes/grammarRoutes');
require('dotenv').config();

const app = express();
const PORT = 5000;

app.use(cors());
app.use(bodyParser.json());
app.use('/api/grammar', grammarRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
