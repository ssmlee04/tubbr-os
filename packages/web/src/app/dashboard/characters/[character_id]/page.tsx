"use client";

import { useState, useEffect } from "react";
import { useRouter, useParams } from "next/navigation";
import { DashboardSidebar } from "../../DashboardSidebar";
import { useAuth } from "@/hooks/useAuth";

export default function CharacterEditPage() {
  useAuth();

  const router = useRouter();
  const params = useParams();
  const id = params.character_id as string;

  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  const API_URL = `http://localhost:4000/api/characters/${id}`;

  useEffect(() => {
    async function fetchCharacter() {
      try {
        const res = await fetch(API_URL);
        if (!res.ok) throw new Error("Character not found");
        const data = await res.json();
        setName(data.data.name);
        setDescription(data.data.description || "");
      } catch (err) {
        setError("Failed to load character");
      } finally {
        setLoading(false);
      }
    }
    fetchCharacter();
  }, [id]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);
    setError("");

    try {
      const res = await fetch(API_URL, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ character: { name, description } }),
      });

      if (!res.ok) throw new Error("Failed to update");

      router.push("/dashboard/characters");
    } catch (err) {
      setError("Failed to update character");
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <div style={{ display: "flex", minHeight: "100vh", background: "#000" }}>
        <DashboardSidebar />
        <main style={{ flex: 1, padding: "40px 20px" }}>
          <p style={{ color: "rgba(255,255,255,0.5)" }}>Loading...</p>
        </main>
      </div>
    );
  }

  return (
    <div style={{ display: "flex", minHeight: "100vh", background: "#000" }}>
      <DashboardSidebar />
      <main style={{ flex: 1, padding: "40px 20px", maxWidth: "600px" }}>
        <button
          onClick={() => router.push("/dashboard/characters")}
          style={{
            background: "transparent",
            border: "none",
            color: "#3b82f6",
            cursor: "pointer",
            fontSize: "14px",
            marginBottom: "24px",
            padding: 0,
          }}
        >
          ← Back to Characters
        </button>

        <h1 style={{ fontSize: "28px", fontWeight: 600, color: "#fff", marginBottom: "32px" }}>
          Edit Character
        </h1>

        {error && (
          <p style={{ color: "#ef4444", marginBottom: "16px" }}>{error}</p>
        )}

        <form onSubmit={handleSubmit}>
          <label style={{ display: "block", color: "#fff", marginBottom: "8px" }}>Name</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
            style={{
              width: "100%",
              padding: "12px",
              background: "#1a1a1a",
              border: "1px solid #333",
              borderRadius: "8px",
              color: "#fff",
              marginBottom: "24px",
              fontSize: "14px",
            }}
          />

          <label style={{ display: "block", color: "#fff", marginBottom: "8px" }}>Description</label>
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={6}
            style={{
              width: "100%",
              padding: "12px",
              background: "#1a1a1a",
              border: "1px solid #333",
              borderRadius: "8px",
              color: "#fff",
              marginBottom: "32px",
              fontSize: "14px",
              resize: "vertical",
            }}
          />

          <div style={{ display: "flex", gap: "12px" }}>
            <button
              type="submit"
              disabled={saving}
              style={{
                flex: 1,
                background: "#3b82f6",
                color: "#fff",
                border: "none",
                padding: "14px",
                borderRadius: "8px",
                cursor: saving ? "not-allowed" : "pointer",
                fontSize: "14px",
                fontWeight: 500,
                opacity: saving ? 0.7 : 1,
              }}
            >
              {saving ? "Saving..." : "Save Changes"}
            </button>
            <button
              type="button"
              onClick={() => router.push("/dashboard/characters")}
              style={{
                flex: 1,
                background: "#333",
                color: "#fff",
                border: "none",
                padding: "14px",
                borderRadius: "8px",
                cursor: "pointer",
                fontSize: "14px",
              }}
            >
              Cancel
            </button>
          </div>
        </form>
      </main>
    </div>
  );
}
