import { Hono } from 'hono';
import { serve } from '@hono/node-server';
import bcrypt from 'bcryptjs';
import { getUserByUsername } from './db.js';

const app = new Hono();

app.get('/', (c) => c.text('OK', 200));

app.post('/login', async (c) => {
  const { username, password } = await c.req.json();

  if (!username || !password) {
    return c.json({ error: 'Username and password required' }, 400);
  }

  const user = await getUserByUsername(username);
  if (!user) {
    return c.json({ error: 'Invalid credentials' }, 401);
  }

  const isValid = await bcrypt.compare(password, user.hashed_password);
  if (!isValid) {
    return c.json({ error: 'Invalid credentials' }, 401);
  }

  return c.json({ id: user.id, username: user.username });
});

const port = parseInt(process.env.PORT || '3000');

serve({
  fetch: app.fetch,
  port,
});

console.log(`Server running on port ${port}`);