# Deploy Supabase no Easypanel (SEM modo privilegiado)

**Use esta solução se o Easypanel não permitir modo privilegiado.**

## Opção: Docker Compose Nativo

O Easypanel suporta Docker Compose nativamente. Use o arquivo `docker-compose.yml` existente.

### Passos no Easypanel:

1. **Delete a aplicação com Dockerfile atual** (ela não funciona sem privileged mode)

2. **Crie uma nova aplicação**
   - Tipo: **"Docker Compose"** (não "Dockerfile")
   - Nome: supabase

3. **Configure o repositório**
   - URL: `https://github.com/awaynever/supabase-easypanel`
   - Branch: `main`

4. **Docker Compose File**
   - Use: `docker-compose.yml` (arquivo padrão)
   - OU se quiser versão simplificada: `docker-compose.simple.yml`

5. **Variáveis de Ambiente**
   
   Cole todas do arquivo .env:
   ```env
   POSTGRES_PASSWORD=a22c525a51c8a7c7cbee98e533e4fd9c
   JWT_SECRET=FGfe2K0lrLhrb3bB11ml8jBEnapQPov+qWCWNedM
   ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InN1cGFiYXNlIiwiaWF0IjoxNzY3MDY3MTUzLCJleHAiOjE5MjQ3NDcxNTN9.tcBkOX01KJzqPDiQnWwRDebBxT28Oe7Zq9gfK2GkpMY
   SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaXNzIjoic3VwYWJhc2UiLCJpYXQiOjE3NjcwNjcxNTMsImV4cCI6MTkyNDc0NzE1M30.3X4J502z52bfxrJVqYOQYZdy0HRNSPkcmux_Qdc0MJ8
   DASHBOARD_USERNAME=supabase
   DASHBOARD_PASSWORD=20e086d7d6e29eb95f245ea2011479b1
   SECRET_KEY_BASE=MWAEMTEKzboajvIl6WNNVEYjxR/WBeo7jBebiymss2jEAE3GluT+JQGlXaa5m7CR
   VAULT_ENC_KEY=8d9b43e5944b5f88e209e4b5fd8076df
   PG_META_CRYPTO_KEY=2vWTZLrRhEK+SnG/awRTkw78k/RtGkyQ
   
   POSTGRES_HOST=db
   POSTGRES_DB=postgres
   POSTGRES_PORT=5432
   
   POOLER_PROXY_PORT_TRANSACTION=6543
   POOLER_DEFAULT_POOL_SIZE=20
   POOLER_MAX_CLIENT_CONN=100
   POOLER_TENANT_ID=your-tenant-id
   POOLER_DB_POOL_SIZE=5
   
   KONG_HTTP_PORT=8000
   KONG_HTTPS_PORT=8443
   
   PGRST_DB_SCHEMAS=public,storage,graphql_public
   
   SITE_URL=https://seu-dominio.easypanel.host
   ADDITIONAL_REDIRECT_URLS=
   JWT_EXPIRY=3600
   DISABLE_SIGNUP=false
   API_EXTERNAL_URL=https://seu-dominio.easypanel.host
   
   MAILER_URLPATHS_CONFIRMATION=/auth/v1/verify
   MAILER_URLPATHS_INVITE=/auth/v1/verify
   MAILER_URLPATHS_RECOVERY=/auth/v1/verify
   MAILER_URLPATHS_EMAIL_CHANGE=/auth/v1/verify
   
   ENABLE_EMAIL_SIGNUP=true
   ENABLE_EMAIL_AUTOCONFIRM=false
   SMTP_ADMIN_EMAIL=admin@example.com
   SMTP_HOST=supabase-mail
   SMTP_PORT=2500
   SMTP_USER=fake_mail_user
   SMTP_PASS=fake_mail_password
   SMTP_SENDER_NAME=fake_sender
   ENABLE_ANONYMOUS_USERS=false
   
   ENABLE_PHONE_SIGNUP=true
   ENABLE_PHONE_AUTOCONFIRM=true
   
   STUDIO_DEFAULT_ORGANIZATION=Default Organization
   STUDIO_DEFAULT_PROJECT=Default Project
   SUPABASE_PUBLIC_URL=https://seu-dominio.easypanel.host
   
   IMGPROXY_ENABLE_WEBP_DETECTION=true
   OPENAI_API_KEY=
   
   FUNCTIONS_VERIFY_JWT=false
   
   LOGFLARE_PUBLIC_ACCESS_TOKEN=uoZF8HshAr44nPAUwuIwPPZA7eUJnEe7
   LOGFLARE_PRIVATE_ACCESS_TOKEN=7QSeO64f2ZRV7kJ1TwQMNM5xNDLTkiaX
   
   DOCKER_SOCKET_LOCATION=/var/run/docker.sock
   
   GOOGLE_PROJECT_ID=GOOGLE_PROJECT_ID
   GOOGLE_PROJECT_NUMBER=GOOGLE_PROJECT_NUMBER
   ```

6. **Recursos**
   - RAM: 4GB (mínimo 2GB)
   - CPU: 2 cores
   - Disco: 20GB

7. **Portas / Domínios**
   - **Studio**: expor porta 3000 (Dashboard principal)
   - **API**: expor porta 8000 (Kong Gateway)

8. **Deploy**
   - Clique em "Deploy"
   - Aguarde 3-5 minutos

## Arquivos Disponíveis:

- `docker-compose.yml` - Completo com todos os serviços
- `docker-compose.simple.yml` - Versão simplificada (apenas DB, Studio, Kong, Auth)
- `docker-compose.easypanel.yml` - Versão minimalista (apenas essenciais)

## Acesso após Deploy:

- **Studio**: https://seu-app.easypanel.host:3000
- **API**: https://seu-app.easypanel.host:8000
- **Usuário**: supabase
- **Senha**: 20e086d7d6e29eb95f245ea2011479b1

## Troubleshooting:

### Serviços não iniciam
- Verifique se todas as variáveis foram configuradas
- Aumente RAM para 4GB
- Verifique logs de cada serviço no Easypanel

### Erro de conexão
- Aguarde 5 minutos para todos os serviços iniciarem
- Verifique se o PostgreSQL está saudável primeiro
- Certifique-se que SITE_URL e SUPABASE_PUBLIC_URL apontam para seu domínio

### Banco não conecta
- Verifique se o serviço `db` está rodando
- Confirme que POSTGRES_PASSWORD está correto
- Verifique os logs do container `db`

## Volumes Persistentes (Importante!):

Configure volumes no Easypanel para não perder dados:
- `/var/lib/postgresql/data` - Dados do PostgreSQL
- `/var/lib/docker/volumes/` - Outros volumes do Docker Compose

## ⚠️ Produção:

1. Altere TODAS as senhas
2. Configure SMTP real (não use supabase-mail em produção)
3. Use domínio próprio com SSL
4. Configure backup dos volumes
5. Monitore recursos (RAM/CPU)
