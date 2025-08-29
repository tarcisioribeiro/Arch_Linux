#!/bin/bash
curl -fsSL https://ollama.com/install.sh | sh
sleep 2
ollama run llama3
sleep 2
sudo cpupower frequency-set -g performance
cd /run/media/tarcisio/Seagate/Programas/Dockerfiles/
sleep 2
docker stack deploy -c portainer-agent-stack.yml portainer
sleep 2
docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main
