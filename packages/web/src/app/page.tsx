"use client";

import { useState } from "react";

export default function Home() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Login:", { email, password });
  };

  return (
    <div style={{
      minHeight: "100vh",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      background: "#000",
      fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
      padding: "20px",
    }}>
      {/* Logo */}
      <div style={{
        fontSize: "32px",
        fontWeight: 600,
        color: "#fff",
        marginBottom: "48px",
        letterSpacing: "-0.5px",
      }}>
        tubbr
      </div>

      {/* Login Card */}
      <div style={{
        width: "100%",
        maxWidth: "340px",
        background: "rgba(255, 255, 255, 0.05)",
        borderRadius: "20px",
        padding: "40px 32px",
        backdropFilter: "blur(20px)",
        WebkitBackdropFilter: "blur(20px)",
      }}>
        <h2 style={{
          color: "#fff",
          fontSize: "24px",
          fontWeight: 600,
          marginBottom: "8px",
          textAlign: "center",
        }}>
          Sign In
        </h2>
        <p style={{
          color: "rgba(255, 255, 255, 0.5)",
          fontSize: "14px",
          marginBottom: "32px",
          textAlign: "center",
        }}>
          Enter your credentials to continue
        </p>

        <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
            style={{
              width: "100%",
              padding: "14px 16px",
              background: "rgba(255, 255, 255, 0.08)",
              border: "1px solid rgba(255, 255, 255, 0.1)",
              borderRadius: "12px",
              color: "#fff",
              fontSize: "15px",
              outline: "none",
              transition: "all 0.2s ease",
              boxSizing: "border-box",
            }}
          />
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password"
            style={{
              width: "100%",
              padding: "14px 16px",
              background: "rgba(255, 255, 255, 0.08)",
              border: "1px solid rgba(255, 255, 255, 0.1)",
              borderRadius: "12px",
              color: "#fff",
              fontSize: "15px",
              outline: "none",
              transition: "all 0.2s ease",
              boxSizing: "border-box",
            }}
          />
          <button
            type="submit"
            style={{
              width: "100%",
              padding: "14px",
              background: "#fff",
              color: "#000",
              border: "none",
              borderRadius: "12px",
              fontSize: "15px",
              fontWeight: 600,
              cursor: "pointer",
              transition: "all 0.2s ease",
              marginTop: "8px",
            }}
          >
            Sign In
          </button>
        </form>

        {/* Divider */}
        <div style={{
          display: "flex",
          alignItems: "center",
          margin: "28px 0",
        }}>
          <div style={{ flex: 1, height: "1px", background: "rgba(255, 255, 255, 0.1)" }} />
          <span style={{ color: "rgba(255, 255, 255, 0.3)", fontSize: "12px", padding: "0 16px" }}>
            or
          </span>
          <div style={{ flex: 1, height: "1px", background: "rgba(255, 255, 255, 0.1)" }} />
        </div>

        {/* Sign Up Link */}
        <p style={{
          color: "rgba(255, 255, 255, 0.5)",
          fontSize: "13px",
          textAlign: "center",
        }}>
          Don&apos;t have an account?{" "}
          <a href="#" style={{ color: "#fff", textDecoration: "none", fontWeight: 500 }}>
            Sign up
          </a>
        </p>
      </div>

      {/* Footer */}
      <div style={{
        position: "absolute",
        bottom: "32px",
        color: "rgba(255, 255, 255, 0.3)",
        fontSize: "12px",
      }}>
        © 2026 tubbr. All rights reserved.
      </div>
    </div>
  );
}
