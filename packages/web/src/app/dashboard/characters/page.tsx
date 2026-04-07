"use client";

import { useState, useEffect } from "react";
import { DashboardSidebar } from "../DashboardSidebar";
import { useAuth } from "@/hooks/useAuth";

interface Character {
  id: number;
  name: string;
  description: string;
  created_at: string;
}

export default function CharactersPage() {
  useAuth();

  const [characters, setCharacters] = useState<Character[]>([]);
  const [loading, setLoading] = useState(true);
  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [formData, setFormData] = useState({ name: "", description: "" });

  const API_URL = "http://localhost:4000/api/characters";

  const fetchCharacters = async () => {
    try {
      const res = await fetch(API_URL);
      const data = await res.json();
      setCharacters(data.data || []);
    } catch (error) {
      console.error("Failed to fetch characters:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCharacters();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      const res = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ character: formData }),
      });

      if (res.ok) {
        setFormData({ name: "", description: "" });
        setShowForm(false);
        fetchCharacters();
      }
    } catch (error) {
      console.error("Failed to create character:", error);
    }
  };

  const handleUpdate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingId) return;

    try {
      const res = await fetch(`${API_URL}/${editingId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ character: formData }),
      });

      if (res.ok) {
        setFormData({ name: "", description: "" });
        setEditingId(null);
        fetchCharacters();
      }
    } catch (error) {
      console.error("Failed to update character:", error);
    }
  };

  const handleDelete = async (id: number) => {
    if (!confirm("Are you sure you want to delete this character?")) return;

    try {
      await fetch(`${API_URL}/${id}`, { method: "DELETE" });
      fetchCharacters();
    } catch (error) {
      console.error("Failed to delete character:", error);
    }
  };

  const startEdit = (character: Character) => {
    setFormData({ name: character.name, description: character.description });
    setEditingId(character.id);
    setShowForm(true);
  };

  return (
    <div style={{ display: "flex", minHeight: "100vh", background: "#000" }}>
      <DashboardSidebar />
      <main style={{ flex: 1, padding: "40px 20px" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <div>
            <h1 style={{ fontSize: "28px", fontWeight: 600, color: "#fff" }}>Characters</h1>
            <p style={{ color: "rgba(255,255,255,0.5)", marginTop: "8px" }}>
              Manage your characters here.
            </p>
          </div>
          <button
            onClick={() => {
              setShowForm(true);
              setEditingId(null);
              setFormData({ name: "", description: "" });
            }}
            style={{
              background: "#3b82f6",
              color: "#fff",
              border: "none",
              padding: "10px 20px",
              borderRadius: "8px",
              cursor: "pointer",
              fontSize: "14px",
              fontWeight: 500,
            }}
          >
            + Add Character
          </button>
        </div>

        {showForm && (
          <div
            style={{
              position: "fixed",
              inset: 0,
              background: "rgba(0,0,0,0.8)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              zIndex: 50,
            }}
            onClick={() => {
              setShowForm(false);
              setEditingId(null);
            }}
          >
            <form
              onClick={(e) => e.stopPropagation()}
              onSubmit={editingId ? handleUpdate : handleSubmit}
              style={{
                background: "#1a1a1a",
                padding: "32px",
                borderRadius: "12px",
                width: "400px",
                border: "1px solid #333",
              }}
            >
              <h2 style={{ color: "#fff", fontSize: "20px", marginBottom: "24px" }}>
                {editingId ? "Edit Character" : "New Character"}
              </h2>
              <input
                type="text"
                placeholder="Character name"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                required
                style={{
                  width: "100%",
                  padding: "12px",
                  background: "#0a0a0a",
                  border: "1px solid #333",
                  borderRadius: "8px",
                  color: "#fff",
                  marginBottom: "16px",
                  fontSize: "14px",
                }}
              />
              <textarea
                placeholder="Description"
                value={formData.description}
                onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                rows={4}
                style={{
                  width: "100%",
                  padding: "12px",
                  background: "#0a0a0a",
                  border: "1px solid #333",
                  borderRadius: "8px",
                  color: "#fff",
                  marginBottom: "24px",
                  fontSize: "14px",
                  resize: "vertical",
                }}
              />
              <div style={{ display: "flex", gap: "12px" }}>
                <button
                  type="submit"
                  style={{
                    flex: 1,
                    background: "#3b82f6",
                    color: "#fff",
                    border: "none",
                    padding: "12px",
                    borderRadius: "8px",
                    cursor: "pointer",
                    fontSize: "14px",
                    fontWeight: 500,
                  }}
                >
                  {editingId ? "Update" : "Create"}
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setShowForm(false);
                    setEditingId(null);
                  }}
                  style={{
                    flex: 1,
                    background: "#333",
                    color: "#fff",
                    border: "none",
                    padding: "12px",
                    borderRadius: "8px",
                    cursor: "pointer",
                    fontSize: "14px",
                  }}
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        )}

        {loading ? (
          <p style={{ color: "rgba(255,255,255,0.5)", marginTop: "40px" }}>Loading...</p>
        ) : characters.length === 0 ? (
          <p style={{ color: "rgba(255,255,255,0.5)", marginTop: "40px" }}>
            No characters yet. Create your first character!
          </p>
        ) : (
          <div
            style={{
              display: "grid",
              gridTemplateColumns: "repeat(auto-fill, minmax(280px, 1fr))",
              gap: "20px",
              marginTop: "32px",
            }}
          >
            {characters.map((character) => (
              <div
                key={character.id}
                style={{
                  background: "#1a1a1a",
                  border: "1px solid #333",
                  borderRadius: "12px",
                  padding: "20px",
                }}
              >
                <h3 style={{ color: "#fff", fontSize: "18px", fontWeight: 600 }}>{character.name}</h3>
                <p style={{ color: "rgba(255,255,255,0.6)", marginTop: "8px", fontSize: "14px" }}>
                  {character.description || "No description"}
                </p>
                <div style={{ display: "flex", gap: "12px", marginTop: "20px" }}>
                  <button
                    onClick={() => startEdit(character)}
                    style={{
                      flex: 1,
                      background: "#333",
                      color: "#fff",
                      border: "none",
                      padding: "8px",
                      borderRadius: "6px",
                      cursor: "pointer",
                      fontSize: "13px",
                    }}
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDelete(character.id)}
                    style={{
                      flex: 1,
                      background: "#7f1d1d",
                      color: "#fff",
                      border: "none",
                      padding: "8px",
                      borderRadius: "6px",
                      cursor: "pointer",
                      fontSize: "13px",
                    }}
                  >
                    Delete
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </main>
    </div>
  );
}
