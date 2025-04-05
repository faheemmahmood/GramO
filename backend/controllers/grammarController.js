const axios = require('axios');

const checkGrammar = async (req, res) => {
  const { text } = req.body;

  try {
    const response = await axios.post(
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash-8b:generateContent?key=AIzaSyCsu5Kt8BoFoVNXBmMpBa1-f7sMWSitiRE',
      {
        contents: [
          {
            parts: [
              {
                text: `Please check the following sentence for grammar mistakes carefully and suggest corrections only:\n\n"${text}"`
              }
            ]
          }
        ]
      },
      {
        headers: {
          'Content-Type': 'application/json',
        }
      }
    );

    const suggestion = response.data.candidates?.[0]?.content?.parts?.[0]?.text || "No suggestions.";
    res.json({ suggestion });
  } catch (error) {
    console.error('Gemini Grammar Check Error:', error?.response?.data || error.message);
    res.status(500).json({ error: 'Failed to check grammar' });
  }
};

module.exports = { checkGrammar };
