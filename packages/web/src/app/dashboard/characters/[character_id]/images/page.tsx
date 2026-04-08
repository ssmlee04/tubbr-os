"use client";

import { useState, useEffect, useRef } from "react";
import { useRouter, useParams } from "next/navigation";
import { Socket, Channel } from "phoenix";
import { DashboardSidebar } from "../../../DashboardSidebar";
import { useAuth } from "@/hooks/useAuth";

function fileToBase64(file: File): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result as string);
    reader.onerror = reject;
    reader.readAsDataURL(file);
  });
}

interface Provider {
  name: string;
  models: Model[];
}

interface Model {
  id: string;
  name: string;
  params: Param[];
}

interface Param {
  name: string;
  type: string;
  label: string;
  required?: boolean;
  optional?: boolean;
  default?: any;
  options?: { key: string; value: string; preview_url?: string }[];
  multi?: boolean;
}

interface GenerationParams {
  image: { providers: Provider[] };
}

const API_URL = "http://localhost:4000";
const SOCKET_URL = "http://localhost:4000/api/socket";

export default function CharacterImagesPage() {
  useAuth();

  const router = useRouter();
  const params = useParams();
  const characterId = params.character_id as string;

  const [generationParams, setGenerationParams] = useState<GenerationParams | null>(null);
  const [loading, setLoading] = useState(true);
  const [socket, setSocket] = useState<Socket | null>(null);
  const [channel, setChannel] = useState<Channel | null>(null);
  const [connected, setConnected] = useState(false);
  const [selectedProvider, setSelectedProvider] = useState<string>("");
  const [selectedModel, setSelectedModel] = useState<string>("");
  const [formValues, setFormValues] = useState<Record<string, any>>({});
  const [generating, setGenerating] = useState(false);
  const [status, setStatus] = useState<string>("");

  const socketRef = useRef<Socket | null>(null);
  const channelRef = useRef<Channel | null>(null);

  // Fetch generation params on mount
  useEffect(() => {
    async function fetchParams() {
      try {
        const res = await fetch(`${API_URL}/api/generation-params`);
        const data = await res.json();
        setGenerationParams(data.params);

        // Select first provider/model by default
        if (data.params?.image?.providers?.length > 0) {
          const firstProvider = data.params.image.providers[0];
          setSelectedProvider(firstProvider.name);
          if (firstProvider.models?.length > 0) {
            const firstModel = firstProvider.models[0];
            setSelectedModel(firstModel.id);
            // Set default values for params
            const defaults: Record<string, any> = {};
            firstModel.params.forEach((p: Param) => {
              defaults[p.name] = p.default;
            });
            setFormValues(defaults);
          }
        }
      } catch (error) {
        console.error("Failed to fetch generation params:", error);
      } finally {
        setLoading(false);
      }
    }
    fetchParams();
  }, []);

  // Connect to Phoenix channel
  useEffect(() => {
    const token = localStorage.getItem("auth_token");
    let socket: Socket | null = null;
    let channel: Channel | null = null;

    const connect = () => {
      console.log("Phoenix connecting...");
      try {
        socket = new Socket(SOCKET_URL, {
          params: { token: token },
        });

        channel = socket.channel(`generation:${characterId}`, {});
        channelRef.current = channel;

        channel.join()
          .receive("ok", () => {
            console.log("Joined channel successfully");
            setConnected(true);
            setChannel(channel);
          })
          .receive("error", (resp: any) => {
            console.log("Unable to join channel", resp);
            setConnected(false);
          });

        // Handle progress events
        channel.on("progress", (payload: any) => {
          console.log("Progress:", payload);
          setStatus(`${payload.status}: ${payload.message}`);
          if (payload.status === "completed") {
            setGenerating(false);
          }
        });

        socket.connect();
      } catch (error) {
        console.error("Connection error:", error);
      }
    };

    connect();

    return () => {
      if (channel) {
        channel.leave();
      }
      if (socket) {
        socket.disconnect();
      }
    };
  }, [characterId]);

  const handleProviderChange = (providerName: string) => {
    setSelectedProvider(providerName);
    setSelectedModel("");
    setFormValues({});
    setStatus("");
  };

  const handleModelChange = (modelId: string) => {
    setSelectedModel(modelId);
    setFormValues({});
    setStatus("");

    // Set default values for new model
    const provider = generationParams?.image?.providers.find(p => p.name === selectedProvider);
    const model = provider?.models.find(m => m.id === modelId);
    if (model) {
      const defaults: Record<string, any> = {};
      model.params.forEach((p: Param) => {
        defaults[p.name] = p.default;
      });
      setFormValues(defaults);
    }
  };

  const handleGenerate = async () => {
    if (!channel || generating) return;

    setGenerating(true);
    setStatus("Starting generation...");

    try {
      await channel.push("generate_image", {
        provider: selectedProvider,
        model: selectedModel,
        params: formValues,
        character_id: characterId,
        request_id: crypto.randomUUID(),
      });
    } catch (error) {
      console.error("Failed to generate:", error);
      setGenerating(false);
      setStatus("Failed to generate");
    }
  };

  const currentProvider = generationParams?.image?.providers.find(p => p.name === selectedProvider);
  const currentModel = currentProvider?.models.find(m => m.id === selectedModel);

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
          Images
        </h1>

        <div style={{ display: "flex", gap: "12px", marginBottom: "24px" }}>
          <button
            onClick={() => router.push(`/dashboard/characters/${characterId}/create-image`)}
            style={{
              background: "#6366f1",
              color: "#fff",
              border: "none",
              padding: "10px 20px",
              borderRadius: "8px",
              cursor: "pointer",
              fontSize: "14px",
              fontWeight: 500,
            }}
          >
            + Generate Image
          </button>
          <button
            onClick={() => router.push(`/dashboard/characters/${characterId}/upload-image`)}
            style={{
              background: "#10b981",
              color: "#fff",
              border: "none",
              padding: "10px 20px",
              borderRadius: "8px",
              cursor: "pointer",
              fontSize: "14px",
              fontWeight: 500,
            }}
          >
            + Upload Image
          </button>
        </div>

        {loading ? (
          <p style={{ color: "rgba(255,255,255,0.5)" }}>Loading...</p>
        ) : (
          <div style={{ maxWidth: "600px" }}>
            <div style={{ marginBottom: "24px", padding: "16px", background: "#1a1a1a", borderRadius: "8px" }}>
              <h3 style={{ color: "#fff", fontSize: "16px", marginBottom: "16px" }}>Generate New Image</h3>

              <div style={{ display: "flex", gap: "12px", marginBottom: "16px" }}>
                <div style={{ flex: 1 }}>
                  <label style={{ display: "block", color: "#fff", fontSize: "14px", marginBottom: "8px" }}>
                    Provider
                  </label>
                  <select
                    value={selectedProvider}
                    onChange={(e) => handleProviderChange(e.target.value)}
                    disabled={generating}
                    style={{
                      width: "100%",
                      padding: "10px",
                      background: "#0a0a0a",
                      border: "1px solid #333",
                      borderRadius: "8px",
                      color: "#fff",
                      fontSize: "14px",
                    }}
                  >
                    {generationParams?.image?.providers.map((p) => (
                      <option key={p.name} value={p.name}>{p.name}</option>
                    ))}
                  </select>
                </div>

                <div style={{ flex: 1 }}>
                  <label style={{ display: "block", color: "#fff", fontSize: "14px", marginBottom: "8px" }}>
                    Model
                  </label>
                  <select
                    value={selectedModel}
                    onChange={(e) => handleModelChange(e.target.value)}
                    disabled={generating || !currentProvider}
                    style={{
                      width: "100%",
                      padding: "10px",
                      background: "#0a0a0a",
                      border: "1px solid #333",
                      borderRadius: "8px",
                      color: "#fff",
                      fontSize: "14px",
                    }}
                  >
                    {currentProvider?.models.map((m) => (
                      <option key={m.id} value={m.id}>{m.name}</option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Dynamic params form */}
              {currentModel?.params.map((param) => (
                <div key={param.name} style={{ marginBottom: "16px" }}>
                  <label style={{ display: "block", color: "#fff", fontSize: "14px", marginBottom: "8px" }}>
                    {param.label} {param.required && "*"}
                  </label>
                  {param.type === "file" ? (
                    <div>
                      <input
                        type="file"
                        multiple={param.multi}
                        accept="image/*"
                        onChange={async (e) => {
                          const files = e.target.files;
                          if (!files) return;

                          if (param.multi) {
                            // Multiple files: store as array of base64
                            const base64Files = await Promise.all(
                              Array.from(files).map(file => fileToBase64(file))
                            );
                            setFormValues({ ...formValues, [param.name]: base64Files });
                          } else {
                            // Single file: store as single base64
                            const base64 = await fileToBase64(files[0]);
                            setFormValues({ ...formValues, [param.name]: base64 });
                          }
                        }}
                        disabled={generating}
                        style={{
                          width: "100%",
                          padding: "10px",
                          background: "#0a0a0a",
                          border: "1px solid #333",
                          borderRadius: "8px",
                          color: "#fff",
                          fontSize: "14px",
                        }}
                      />
                      {formValues[param.name] && (
                        <div style={{ marginTop: "8px", color: "#888", fontSize: "12px" }}>
                          {Array.isArray(formValues[param.name])
                            ? `${formValues[param.name].length} file(s) selected`
                            : "1 file selected"}
                        </div>
                      )}
                    </div>
                  ) : param.type === "select" ? (
                    <select
                      value={formValues[param.name] || ""}
                      onChange={(e) => setFormValues({ ...formValues, [param.name]: e.target.value })}
                      disabled={generating}
                      style={{
                        width: "100%",
                        padding: "10px",
                        background: "#0a0a0a",
                        border: "1px solid #333",
                        borderRadius: "8px",
                        color: "#fff",
                        fontSize: "14px",
                      }}
                    >
                      {param.options?.map((opt: any) => {
                        const optKey = opt.key ?? opt;
                        const optValue = opt.value ?? opt;
                        return <option key={optKey} value={optValue}>{optKey}</option>;
                      })}
                    </select>
                  ) : param.type === "number" ? (
                    <input
                      type="number"
                      value={formValues[param.name] || ""}
                      onChange={(e) => setFormValues({ ...formValues, [param.name]: parseFloat(e.target.value) })}
                      disabled={generating}
                      style={{
                        width: "100%",
                        padding: "10px",
                        background: "#0a0a0a",
                        border: "1px solid #333",
                        borderRadius: "8px",
                        color: "#fff",
                        fontSize: "14px",
                      }}
                    />
                  ) : (
                    <textarea
                      value={formValues[param.name] || ""}
                      onChange={(e) => setFormValues({ ...formValues, [param.name]: e.target.value })}
                      disabled={generating}
                      rows={3}
                      style={{
                        width: "100%",
                        padding: "10px",
                        background: "#0a0a0a",
                        border: "1px solid #333",
                        borderRadius: "8px",
                        color: "#fff",
                        fontSize: "14px",
                        resize: "vertical",
                      }}
                    />
                  )}
                </div>
              ))}

              <button
                onClick={handleGenerate}
                disabled={generating || !selectedProvider || !selectedModel}
                style={{
                  width: "100%",
                  background: generating ? "#333" : "#6366f1",
                  color: "#fff",
                  border: "none",
                  padding: "12px",
                  borderRadius: "8px",
                  cursor: generating ? "not-allowed" : "pointer",
                  fontSize: "14px",
                  fontWeight: 500,
                }}
              >
                {generating ? "Generating..." : "Generate Image"}
              </button>

              {status && (
                <p style={{ color: "#10b981", marginTop: "12px", fontSize: "14px" }}>
                  {status}
                </p>
              )}

              <div style={{ marginTop: "12px", fontSize: "12px", color: connected ? "#10b981" : "#ef4444" }}>
                {connected ? "● Connected" : "○ Disconnected"}
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
