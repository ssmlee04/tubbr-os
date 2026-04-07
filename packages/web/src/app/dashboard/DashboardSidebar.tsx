"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const navItems = [
  { href: "/dashboard/characters", label: "Characters" },
  { href: "/dashboard/scripts", label: "Scripts" },
];

export function DashboardSidebar() {
  const pathname = usePathname();

  return (
    <aside style={{
      width: "240px",
      minHeight: "100vh",
      background: "#111",
      borderRight: "1px solid #222",
      padding: "20px 0",
    }}>
      <div style={{
        padding: "0 20px 30px",
        borderBottom: "1px solid #222",
        marginBottom: "20px",
      }}>
        <h2 style={{ fontSize: "18px", fontWeight: 600, color: "#fff" }}>Tubbr</h2>
      </div>
      <nav>
        {navItems.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.href}
              href={item.href}
              style={{
                display: "block",
                padding: "12px 20px",
                color: isActive ? "#fff" : "rgba(255,255,255,0.6)",
                background: isActive ? "rgba(255,255,255,0.1)" : "transparent",
                fontSize: "14px",
                fontWeight: isActive ? 500 : 400,
              }}
            >
              {item.label}
            </Link>
          );
        })}
      </nav>
    </aside>
  );
}