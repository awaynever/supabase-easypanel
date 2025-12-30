# Deploy Supabase no Easypanel

## Configuração Rápida

### 1. No Easypanel

1. **Crie uma nova aplicação**
   - Clique em "New Application"
   - Selecione "Deploy from Dockerfile"

2. **Configure o repositório**
   - Conecte seu repositório Git
   - Ou faça upload dos arquivos

3. **Configurações importantes**
   
   #### Dockerfile Path:
   ```
   Dockerfile
   ```

   #### Portas:
   - **3000** → Supabase Studio (marque como principal)
   - **8000** → API Gateway
   - **5432** → PostgreSQL (opcional, expor apenas se necessário)

   #### Modo Privilegiado:
   ```
   ✅ ATIVE "Privileged Mode"
   ```
   (Necessário para Docker-in-Docker)

   #### Recursos Mínimos:
   - **CPU**: 2 cores
   - **RAM**: 2GB
   - **Disco**: 10GB

4. **Variáveis de Ambiente**
   
   Cole todas as variáveis do arquivo `.env`:

   ```env
   POSTGRES_PASSWORD=a22c525a51c8a7c7cbee98e533e4fd9c
   JWT_SECRET=FGfe2K0lrLhrb3bB11ml8jBEnapQPov+qWCWNedM
   ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   DASHBOARD_USERNAME=supabase
   DASHBOARD_PASSWORD=20e086d7d6e29eb95f245ea2011479b1
   
   # Atualize estas URLs com seu domínio:
   SITE_URL=https://seu-app.easypanel.host
   API_EXTERNAL_URL=https://seu-app.easypanel.host
   SUPABASE_PUBLIC_URL=https://seu-app.easypanel.host
   
   # Demais variáveis do .env...
   ```

5. **Volumes Persistentes (Opcional)**
   
   Se quiser persistir dados entre deploys:
   - `/app/volumes/db` → Dados do PostgreSQL
   - `/app/volumes/storage` → Arquivos do Storage

6. **Deploy**
   
   Clique em "Deploy"
   - Primeira inicialização leva ~3-5 minutos
   - Aguarde todos os serviços ficarem saudáveis

### 2. Acesso

Após o deploy:

- **Studio**: `https://seu-app.easypanel.host:3000`
- **API**: `https://seu-app.easypanel.host:8000`

**Credenciais:**
- Usuário: `supabase`
- Senha: `20e086d7d6e29eb95f245ea2011479b1`

## Teste Local Antes

```bash
# Build
docker build -t supabase-test .

# Run
docker run -d \
  -p 3000:3000 \
  -p 8000:8000 \
  --privileged \
  --name supabase-test \
  supabase-test

# Logs
docker logs -f supabase-test

# Parar
docker stop supabase-test && docker rm supabase-test
```

## Troubleshooting

### Container não inicia
- Verifique se "Privileged Mode" está ativado
- Aumente RAM para pelo menos 2GB
- Verifique os logs no Easypanel

### Serviços não respondem
- Aguarde 3-5 minutos após deploy
- Acesse logs do container
- Verifique se as portas estão corretas

### Erro de memória
- Aumente RAM para 4GB
- Reduza `POOLER_DEFAULT_POOL_SIZE` no .env

## ⚠️ IMPORTANTE

**Antes de Produção:**
1. ✅ Altere TODAS as senhas e secrets
2. ✅ Configure backup dos volumes
3. ✅ Use domínio próprio com SSL
4. ✅ Configure SMTP real (não use supabase-mail)
5. ✅ Revise configurações de segurança

## Suporte

- Easypanel Docs: https://easypanel.io/docs
- Supabase Docs: https://supabase.com/docs
