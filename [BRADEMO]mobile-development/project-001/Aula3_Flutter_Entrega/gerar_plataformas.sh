#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
for project in exercicio_01_theme_azul exercicio_02_theme_sobrescrito exercicio_03_login_navegacao; do
  echo "Gerando plataformas para ${project}..."
  (cd "${ROOT_DIR}/${project}" && flutter create . --platforms=android,ios,web)
done

echo "Concluído. Agora execute 'flutter pub get' na pasta de cada projeto."
