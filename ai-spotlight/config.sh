#!/bin/bash
# MODEL_PROVIDER: filter models by provider prefix in 'opencode models' output.
# Examples: "github-copilot", "google", "openai", "" (empty = show all models)
# Set to "" to show all available models regardless of provider.
export MODEL_PROVIDER="github-copilot"

# DEFAULT_MODEL: the model selected by default when the widget opens.
# Must be a valid model ID from 'opencode models' output.
# Examples for non-Copilot users: "openai/gpt-4o", "google/gemini-2.0-flash"
export DEFAULT_MODEL="github-copilot/gpt-5-mini"
