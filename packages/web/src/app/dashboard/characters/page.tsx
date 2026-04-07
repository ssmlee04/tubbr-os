"use client";

import { useAuth } from "@/hooks/useAuth";

export default function CharactersPage() {
  useAuth();

  return (
    <div style={{
      minHeight: "100vh",
      background: "#000",
      color: "#fff",
      fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
      padding: "40px 20px",
    }}>
      <h1 style={{ fontSize: "28px", fontWeight: 600 }}>Characters</h1>
      <p style={{ color: "rgba(255,255,255,0.5)", marginTop: "8px" }}>
        Manage your characters here.
      </p>
    </div>
  );
}
