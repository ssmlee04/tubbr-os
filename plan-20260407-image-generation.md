{
  "project": "Tubbr-OS Character Image Generation",
  "created_at": "2026-04-07",
  "objective": "Build /dashboard/characters/:id/images page with Phoenix channel for real-time image generation",

  "context": {
    "background": "The tubbr-os project is a new backend replacing tubbr's functionality. The images page needs to allow users to generate images for their characters. We want real-time updates via Phoenix channels similar to how tubbr does it.",
    "requirements": [
      "User can select provider and model from available options",
      "User can specify generation params (prompt, etc.)",
      "Generation happens on backend with real-time progress updates",
      "Generated images are saved to character_images table",
      "No cost checking/deduction (simplified from tubbr)"
    ],
    "key_files": {
      "tubbr_reference": {
        "generation_params_api": "/tubbr/packages/scriptor/lib/scriptor_web/controllers/asset_generation_params_controller.ex",
        "channel_interface": "/tubbr/packages/web/src/components/ChannelChatInterface.tsx",
        "generation_form": "/tubbr/packages/web/src/components/GenerationForm.tsx",
        "image_handler": "/tubbr/packages/scriptor/lib/scriptor_web/handlers/generation/image_generation_handler.ex",
        "provider_models": "/tubbr/packages/scriptor/lib/scriptor/providers_and_models/provider_and_models.ex"
      },
      "tubbr_os_existing": {
        "characters_page": "packages/web/src/app/dashboard/characters/[character_id]/images/page.tsx",
        "character_schema": "packages/backend/lib/tubbr/backend/characters/character.ex",
        "images_table": "packages/backend/priv/repo/migrations/202604070004_create_images.exs",
        "character_images_table": "packages/backend/priv/repo/migrations/202604070006_create_character_images.exs",
        "image_schema": "packages/backend/lib/tubbr/backend/image.ex",
        "character_image_schema": "packages/backend/lib/tubbr/backend/characters/character_image.ex"
      }
    },
    "api_endpoints_to_create": [
      "GET /api/generation-params - returns available providers and models",
      "Phoenix channel: join with user token, handle generate_image event"
    ]
  },

  "steps": [
    {
      "id": 1,
      "description": "Create generation params API endpoint returning available providers/models",
      "file": "packages/backend/lib/tubbr_backend_web/controllers/generation_params_controller.ex",
      "type": "new",
      "dependencies": [],
      "status": "pending",
      "notes": "Hardcode providers initially (Replicate FLUX, etc.). Can call tubbr API later if needed."
    },
    {
      "id": 2,
      "description": "Add GET /api/generation-params route to router",
      "file": "packages/backend/lib/tubbr_backend_web/router.ex",
      "type": "update",
      "dependencies": [1],
      "status": "pending"
    },
    {
      "id": 3,
      "description": "Create Phoenix channel for generation with handle_event for generate_image",
      "file": "packages/backend/lib/tubbr_backend_web/channels/generation_channel.ex",
      "type": "new",
      "dependencies": [],
      "status": "pending",
      "notes": "Join with JWT auth. Handle generate_image event, push progress/status updates. Reuse patterns from tubbr user_channel.ex"
    },
    {
      "id": 4,
      "description": "Add channel route to router for /api/socket",
      "file": "packages/backend/lib/tubbr_backend_web/router.ex",
      "type": "update",
      "dependencies": [3],
      "status": "pending"
    },
    {
      "id": 5,
      "description": "Update images page to fetch generation params on mount",
      "file": "packages/web/src/app/dashboard/characters/[character_id]/images/page.tsx",
      "type": "update",
      "dependencies": [1],
      "status": "pending",
      "notes": "Fetch from GET /api/generation-params, store in React state"
    },
    {
      "id": 6,
      "description": "Add Phoenix channel connection to images page",
      "file": "packages/web/src/app/dashboard/characters/[character_id]/images/page.tsx",
      "type": "update",
      "dependencies": [3, 5],
      "status": "pending",
      "notes": "Use socket.io-client or Phoenix channels client. Similar to ChannelChatInterface.tsx in tubbr"
    },
    {
      "id": 7,
      "description": "Add provider/model selection form to images page",
      "file": "packages/web/src/app/dashboard/characters/[character_id]/images/page.tsx",
      "type": "update",
      "dependencies": [5],
      "status": "pending",
      "notes": "Dropdown for provider, then model. Then dynamic form fields based on model params"
    },
    {
      "id": 8,
      "description": "Handle channel events for progress/status updates",
      "file": "packages/web/src/app/dashboard/characters/[character_id]/images/page.tsx",
      "type": "update",
      "dependencies": [6],
      "status": "pending",
      "notes": "Listen for 'progress', 'completed', 'error' events. Display status to user"
    },
    {
      "id": 9,
      "description": "Test end-to-end: fetch params, submit generation, receive updates",
      "file": "manual test",
      "type": "verify",
      "dependencies": [2, 4, 7, 8],
      "status": "pending"
    }
  ],

  "total_steps": 9,
  "estimated_complexity": "medium"
}
