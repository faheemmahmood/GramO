const axios = require("axios");

const checkGrammar = async (req, res) => {
  const { text } = req.body;

  try {
    // Log the text being checked to confirm the request is coming through correctly
    console.log('Text to check:', text);

    const response = await axios.post(
      `https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash-8b:generateContent?key=${process.env.GEMINI_API_KEY}`, // Use the key from .env
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
        headers: { 'Content-Type': 'application/json' }
      }
    );

    // Log the full response from the API to check what is being returned
    console.log('API Response:', response.data);

    const suggestion = response.data.candidates?.[0]?.content?.parts?.[0]?.text || "No suggestions.";
    res.json({ suggestion });
  } catch (error) {
    // Log the full error to get more details
    console.error("Gemini Grammar Check Error:", error.response ? error.response.data : error.message);
    res.status(500).json({ error: "Failed to check grammar" });
  }
};

module.exports = { checkGrammar };
