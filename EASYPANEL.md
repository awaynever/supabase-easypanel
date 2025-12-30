# Configuração do Supabase para Easypanel

## Instruções de Deploy

### Opção 1: Usando Dockerfile (Docker-in-Docker)

1. No Easypanel, crie uma nova aplicação
2. Selecione "Build from Source" ou "Custom Dockerfile"
3. Aponte para este repositório
4. Configure as seguintes portas:
   - **3000** → Supabase Studio (Dashboard)
   - **8000** → API Gateway (Kong)
   - **5432** → PostgreSQL Database
   - **6543** → Connection Pooler

5. Adicione as variáveis de ambiente do arquivo `.env`

### Opção 2: Usando Docker Compose (Recomendado)

O Easypanel suporta docker-compose nativamente:

1. No Easypanel, crie uma nova aplicação
2. Selecione "Docker Compose"
3. Cole o conteúdo de `docker-compose.yml`
4. Configure as variáveis do arquivo `.env`

### Portas Expostas

- `3000` - Supabase Studio (Dashboard Web)
- `8000` - Kong API Gateway (HTTP)
- `8443` - Kong API Gateway (HTTPS)
- `5432` - PostgreSQL Database
- `6543` - Supavisor (Connection Pooler)
- `4000` - Analytics (Logflare)

### Variáveis de Ambiente Importantes

Certifique-se de configurar estas variáveis no Easypanel:

```bash
# Senhas e Secrets
POSTGRES_PASSWORD=a22c525a51c8a7c7cbee98e533e4fd9c
JWT_SECRET=FGfe2K0lrLhrb3bB11ml8jBEnapQPov+qWCWNebM
DASHBOARD_USERNAME=supabase
DASHBOARD_PASSWORD=20e086d7d6e29eb95f245ea2011479b1

# URLs (ajuste conforme seu domínio)
SITE_URL=https://seu-dominio.com
API_EXTERNAL_URL=https://api.seu-dominio.com
SUPABASE_PUBLIC_URL=https://api.seu-dominio.com
```

### Volumes Persistentes

Configure volumes persistentes para:
- `/app/volumes/db/data` - Dados do PostgreSQL
- `/app/volumes/storage` - Arquivos do Storage
- `/app/volumes/functions` - Edge Functions

### Build e Deploy

```bash
# Build local
docker build -t supabase-easypanel .

# Run local
docker run -d \
  -p 3000:3000 \
  -p 8000:8000 \
  -p 5432:5432 \
  --privileged \
  --name supabase \
  supabase-easypanel
```

### Notas Importantes

1. **Modo Privilegiado**: O container precisa rodar em modo privilegiado para usar Docker-in-Docker
2. **Recursos**: Recomendado mínimo de 2GB RAM e 2 CPU cores
3. **Storage**: Necessário pelo menos 10GB de espaço em disco
4. **Segurança**: Altere TODAS as senhas antes de colocar em produção

### Troubleshooting

Se os serviços não iniciarem:
```bash
# Acesse o container
docker exec -it supabase bash

# Verifique os logs
docker-compose logs

# Reinicie os serviços
docker-compose restart
```

### Acesso após Deploy

- **Studio**: http://seu-dominio:3000
- **API**: http://seu-dominio:8000
- **Credenciais**: 
  - Usuário: `supabase`
  - Senha: `20e086d7d6e29eb95f245ea2011479b1`
