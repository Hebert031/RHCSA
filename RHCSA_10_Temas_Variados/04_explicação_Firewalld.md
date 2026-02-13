# 📘 Explicação Completa --- Exercício 04: Firewalld (RHCSA)

------------------------------------------------------------------------

## 🎯 Objetivo

Gerenciar regras do **firewalld** utilizando:

-   Regras permanentes
-   Reload correto
-   Validação de configuração
-   Remoção de regras
-   Confirmação pós-alteração

Este exercício simula cenário clássico de prova RHCSA.

------------------------------------------------------------------------

# 🔎 1️⃣ Verificar Status do Firewalld

Antes de qualquer alteração, confirme se o serviço está ativo:

``` bash
sudo systemctl status firewalld
```

Se não estiver em execução:

``` bash
sudo systemctl start firewalld
sudo systemctl enable firewalld
```

✔ `start` → inicia o serviço\
✔ `enable` → garante que inicie no boot

------------------------------------------------------------------------

# 🔓 2️⃣ Liberar portas 80 e 443 permanentemente

``` bash
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
```

### 🔎 Explicação dos parâmetros:

-   `--permanent` → salva regra na configuração persistente
-   `--add-port` → adiciona porta específica
-   `80/tcp` → porta e protocolo

⚠️ Sem `--permanent`, a regra é aplicada apenas em runtime (temporária).

------------------------------------------------------------------------

# 🔄 3️⃣ Recarregar o firewall

``` bash
sudo firewall-cmd --reload
```

O reload aplica as regras permanentes na configuração ativa.

------------------------------------------------------------------------

# 📋 4️⃣ Listar regras ativas

Listar configuração completa da zona ativa:

``` bash
sudo firewall-cmd --list-all
```

Listar apenas portas abertas:

``` bash
sudo firewall-cmd --list-ports
```

Resultado esperado:

    80/tcp 443/tcp

------------------------------------------------------------------------

# ❌ 5️⃣ Remover porta 443 permanentemente

``` bash
sudo firewall-cmd --permanent --remove-port=443/tcp
sudo firewall-cmd --reload
```

------------------------------------------------------------------------

# ✅ 6️⃣ Validar configuração final

``` bash
sudo firewall-cmd --list-ports
```

Resultado esperado:

    80/tcp

------------------------------------------------------------------------

# 🧠 Conceitos Fundamentais para RHCSA

## 🔁 Firewalld possui dois níveis de configuração:

### Runtime

-   Temporário
-   Perdido após reboot

### Permanent

-   Persistente
-   Aplicado após reload ou reboot

------------------------------------------------------------------------

# 📌 Fluxo Mental Correto na Prova

1.  Verificar status do serviço\
2.  Aplicar regra permanente\
3.  Executar reload\
4.  Validar\
5.  Confirmar persistência

------------------------------------------------------------------------

# 🔬 Validação Avançada (Boa prática)

Após configuração:

``` bash
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --list-all
```

Confirme que a interface correta está na zona esperada.

------------------------------------------------------------------------

# 🏆 Resultado Esperado

✔ Firewalld ativo\
✔ Porta 80 liberada permanentemente\
✔ Porta 443 removida\
✔ Configuração persistente\
✔ Zona correta associada à interface

------------------------------------------------------------------------

# 🔎 Observação Técnica Importante

Firewall aberto **não significa que há serviço escutando**.

Para validar conectividade real:

``` bash
ss -tulnp
```

Deve existir um processo escutando na porta desejada.
