# Guia Rápido - Easypanel

## Arquivos Necessários
✅ Dockerfile
✅ docker-compose.yml  
✅ .env
✅ volumes/
✅ dev/
✅ utils/

## Deploy no Easypanel

### Passo 1: Criar App
```
New Application → Deploy from Dockerfile
```

### Passo 2: Configurar
```
✅ Privileged Mode: ON
✅ CPU: 2 cores
✅ RAM: 2GB  
✅ Disco: 10GB
```

### Passo 3: Portas
```
3000 → Studio (Principal)
8000 → API Gateway
```

### Passo 4: Variáveis (.env)
Copie TODAS as variáveis do arquivo .env
Atualize as URLs para seu domínio.

### Passo 5: Deploy
```
Deploy → Aguarde 3-5 minutos
```

## Acessos
- Studio: https://seu-app:3000
- User: supabase
- Pass: 20e086d7d6e29eb95f245ea2011479b1

## Teste Local
```bash
./build-easypanel.sh
docker run -d -p 3000:3000 -p 8000:8000 --privileged --name supabase supabase-easypanel
docker logs -f supabase
```

## Checklist Produção
- [ ] Mudar todas as senhas
- [ ] Configurar domínio próprio  
- [ ] Ativar SSL/HTTPS
- [ ] Configurar SMTP real
- [ ] Backup dos volumes
