import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
const supabaseAdmin = createClient(Deno.env.get("SUPABASE_URL"), Deno.env.get("SUPABASE_SERVICE_ROLE_KEY"));
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Max-Age": "86400"
};
Deno.serve(async (req)=>{
  let status = 500;
  try {
    if (req.method === "OPTIONS") {
      status = 200;
      return new Response("ok", {
        headers: corsHeaders
      });
    }
    if (req.method !== "POST") {
      status = 405;
      return new Response(JSON.stringify({
        error: "Method not allowed"
      }), {
        status,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    const body = await req.json();
    const { email, creatorId, tenantId, parentId } = body;
    if (!email) {
      status = 400;
      return new Response(JSON.stringify({
        error: "Email is required"
      }), {
        status,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    // Check if user already exists
    const { data: existingUsers, error: userCheckError } = await supabaseAdmin.from('users').select('id').eq('email', email);
    if (userCheckError) {
      status = 500;
      return new Response(JSON.stringify({
        error: "Failed to check user existence"
      }), {
        status,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    if (existingUsers && existingUsers.length > 0) {
      status = 409;
      return new Response(JSON.stringify({
        error: "User with this email already exists"
      }), {
        status,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    // Simple redirect URL - Supabase will handle token automatically
    const redirectTo = `${Deno.env.get("APP_URL")}/set-password`;
    // Send invite - Supabase handles everything
    const { data, error } = await supabaseAdmin.auth.admin.inviteUserByEmail(email, {
      redirectTo,
      data: {
        creatorId,
        tenantId,
        parentId
      }
    });
    if (error) {
      status = 400;
      return new Response(JSON.stringify({
        error: error.message
      }), {
        status,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    status = 200;
    return new Response(JSON.stringify({
      data,
      message: "Invite sent successfully"
    }), {
      status,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json"
      }
    });
  } catch (err) {
    status = 500;
    return new Response(JSON.stringify({
      error: err.message
    }), {
      status,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json"
      }
    });
  }
});
