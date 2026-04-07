"use client";

import { useRouter, useParams } from "next/navigation";
import { DashboardSidebar } from "../../../DashboardSidebar";
import { useAuth } from "@/hooks/useAuth";

export default function CharacterImagesPage() {
  useAuth();

  const router = useRouter();
  const params = useParams();
  const characterId = params.character_id as string;

  return (
    <div style={{ display: "flex", minHeight: "100vh", background: "#000" }}>
      <DashboardSidebar />
      <main style={{ flex: 1, padding: "40px 20px" }}>
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

        <h1 style={{ fontSize: "28px", fontWeight: 600, color: "#fff", marginBottom: "16px" }}>
          Generate Images
        </h1>
        <p style={{ color: "rgba(255,255,255,0.5)" }}>
          Character ID: {characterId}
        </p>
      </main>
    </div>
  );
}
