#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
command -v flutter >/dev/null 2>&1 || { echo "Erro: Flutter SDK não encontrado no PATH." >&2; exit 1; }
for project in "$ROOT"/exercicio_*; do
  [ -d "$project" ] || continue
  name="$(basename "$project")"
  temp_root="$(mktemp -d)"
  echo "Gerando plataformas para $name..."
  flutter create --project-name "$name" --platforms=android,ios,macos,windows,linux "$temp_root/$name"
  for platform in android ios macos windows linux; do
    if [ -d "$temp_root/$name/$platform" ]; then
      rm -rf "$project/$platform"
      cp -R "$temp_root/$name/$platform" "$project/$platform"
    fi
  done
  if [ -f "$temp_root/$name/.metadata" ]; then cp "$temp_root/$name/.metadata" "$project/.metadata"; fi
  rm -rf "$temp_root"
done
echo "Plataformas criadas. Rode flutter pub get em cada projeto."
