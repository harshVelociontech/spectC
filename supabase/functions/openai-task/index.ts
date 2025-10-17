import OpenAI from "npm:openai";
import "jsr:@std/dotenv/load";
const client = new OpenAI({
  apiKey: Deno.env.get("OPENAI_API_KEY")
});
const allowedOrigins = [
  "http://localhost:8080"
];
const appContext = `
You are Ace, an AI assistant EXCLUSIVELY for MyApp, a task & project management platform.

**Your ONLY purpose is to help users with:**
- Creating, editing, and deleting tasks
- Managing task deadlines and priorities
- Organizing and managing multiple projects
- Managing PMO templates and resources in the PMO Library
- Understanding app features and functionality
- Workflow optimization within the app
- Project collaboration and team management
- Creating, editing, and managing releases

**STRICT RULES - You MUST follow these:**
1. ONLY answer questions related to task management, project management, PMO management, release management, and MyApp features
2. If a user asks about ANYTHING outside these topics (weather, cooking, general knowledge, other apps, etc.), you MUST respond with EXACTLY this text and nothing else:
   "I'm Ace, your MyApp assistant. I can only help with task and project management features within this app. Please ask me questions about managing your tasks, projects, deadlines, PMO templates, releases, or app features."
3. Do NOT provide information about unrelated topics
4. Do NOT make up features that don't exist in the app
5. Stay professional and focused on helping users be productive with their tasks and projects

**CREATION TRIGGERS - Respond EXACTLY as specified, with NO additional text.**
`;
function getCorsHeaders(origin) {
  if (origin && allowedOrigins.includes(origin)) {
    return {
      "Access-Control-Allow-Origin": origin,
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type"
    };
  }
  return {};
}
function json(body, status = 200, origin) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      "Content-Type": "application/json",
      ...getCorsHeaders(origin || null)
    }
  });
}
Deno.serve(async (req)=>{
  const origin = req.headers.get("Origin");
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: getCorsHeaders(origin)
    });
  }
  const OPENAI_KEY = Deno.env.get("OPENAI_API_KEY");
  if (!OPENAI_KEY) {
    return json({
      error: "Missing OPENAI_API_KEY"
    }, 500, origin || undefined);
  }
  try {
    const { prompt, model = "gpt-5", instructions, userContext } = await req.json();
    if (!prompt || typeof prompt !== "string") {
      return json({
        error: "prompt is required"
      }, 400, origin || undefined);
    }
    let systemMessage = appContext;
    if (userContext) systemMessage += `\n\nUser Information:\n${userContext}`;
    if (instructions) systemMessage += `\n\nAdditional Instructions:\n${instructions}`;
    const response = await client.responses.create({
      model,
      input: [
        {
          role: "system",
          content: systemMessage
        },
        {
          role: "user",
          content: prompt
        }
      ],
      temperature: 0.1,
      max_output_tokens: 500
    });
    const output = response.output_text || "";
    return json({
      text: output
    }, 200, origin || undefined);
  } catch (err) {
    console.error("[SERVER ERROR]", err);
    return json({
      error: "Server error",
      detail: String(err)
    }, 500, origin || undefined);
  }
});
