import pg from 'pg';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const { Pool } = pg;

const pool = new Pool({
  host: process.env.POSTGRES_HOST || 'postgres',
  port: parseInt(process.env.POSTGRES_PORT || '5432'),
  user: process.env.POSTGRES_USER || 'tubbr',
  password: process.env.POSTGRES_PASSWORD || 'tubbr',
  database: process.env.POSTGRES_DB || 'tubbr',
});

export async function runMigrations() {
  const client = await pool.connect();
  try {
    const migrationsDir = join(__dirname, '..', 'migrations');
    const files = ['001-schema.sql', '002-seed.sql'];

    for (const file of files) {
      const sql = readFileSync(join(migrationsDir, file), 'utf-8');
      await client.query(sql);
      console.log(`Ran migration: ${file}`);
    }
  } finally {
    client.release();
  }
}

export async function getUserByUsername(username) {
  const result = await pool.query(
    'SELECT id, username, salt, hashed_password FROM users WHERE username = $1',
    [username]
  );
  return result.rows[0];
}

export default pool;