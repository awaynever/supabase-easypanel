#!/bin/bash

echo "=================================="
echo "Supabase - Build para Easypanel"
echo "=================================="
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker não está rodando. Inicie o Docker primeiro."
    exit 1
fi

echo "✅ Docker está rodando"
echo ""

# Build the image
echo "🔨 Construindo imagem Docker..."
docker build -t supabase-easypanel:latest .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Imagem construída com sucesso!"
    echo ""
    echo "📦 Nome: supabase-easypanel:latest"
    echo ""
    echo "🧪 Testar localmente:"
    echo "   docker run -d -p 3000:3000 -p 8000:8000 --privileged --name supabase supabase-easypanel:latest"
    echo ""
    echo "📋 Logs:"
    echo "   docker logs -f supabase"
    echo ""
    echo "🚀 No Easypanel:"
    echo "   1. Crie nova aplicação → Deploy from Dockerfile"
    echo "   2. ATIVE 'Privileged Mode'"
    echo "   3. Configure portas: 3000 e 8000"
    echo "   4. Adicione variáveis do .env"
    echo "   5. Recursos mínimos: 2GB RAM, 2 CPU"
    echo ""
else
    echo ""
    echo "❌ Erro ao construir a imagem"
    exit 1
fi
