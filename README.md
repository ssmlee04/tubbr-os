# tubbr-os

An open source tool for generating scripts and videos using your keywords.

Try the full experience at [https://trytubbr.com](https://trytubbr.com) — create AI-powered videos like this:

[![Video thumbnail](https://assets.trytubbr.com/strawberry-sm.png)](https://www.youtube.com/shorts/4hYoY67NMS0)

## Quick Start

### Running the Project

```bash
docker-compose up --build
```

This starts:
- **PostgreSQL** on port 5432
- **Auth service** on port 3000
- **Web app** on port 3001

### Access the App

Open http://localhost:3001 in your browser.

### Login Credentials

- **Username:** `admin`
- **Password:** `password123`

On successful login, you'll be redirected to `/dashboard/characters`.

## License

MIT
