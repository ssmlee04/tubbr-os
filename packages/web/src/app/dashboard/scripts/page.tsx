"use client";

import { DashboardSidebar } from "../DashboardSidebar";
import { useAuth } from "@/hooks/useAuth";

export default function ScriptsPage() {
  useAuth();

  return (
    <div style={{ display: "flex", minHeight: "100vh", background: "#000" }}>
      <DashboardSidebar />
      <main style={{ flex: 1, padding: "40px 20px" }}>
        <h1 style={{ fontSize: "28px", fontWeight: 600, color: "#fff" }}>Scripts</h1>
        <p style={{ color: "rgba(255,255,255,0.5)", marginTop: "8px" }}>
          Manage your scripts here.
        </p>
      </main>
    </div>
  );
}