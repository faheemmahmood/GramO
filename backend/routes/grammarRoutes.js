const express = require('express');
const router = express.Router();
const { checkGrammar } = require('../controllers/grammarController');

router.post('/check', checkGrammar);

module.exports = router;
