# tubbr-os

An open source tool for generating scripts and videos using your keywords.

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

## Usage

Generate video scripts from keywords:
```
/script-gen-ideas <your keyword>
```

Convert a script to JSON storyboard:
```
/script-gen-json
```

Generate video from storyboard:
```
/script-gen-video-replicate-kling
```

Generate scene images:
```
/script-gen-image
```

Generate narration audio:
```
/script-gen-audio
```

Generate thumbnail:
```
/script-gen-thumbnail
```

## Getting Started

1. Provide a keyword to generate video topic ideas
2. Convert your chosen script to JSON format
3. Generate images, audio, and video assets
4. Create a thumbnail for your YouTube video

## License

MIT