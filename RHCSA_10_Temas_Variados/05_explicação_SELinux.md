# 📘 Runbook Comentado --- SELinux + HTTPD (RHCSA)

## 🎯 Objetivo do Exercício

1.  Verificar modo do SELinux\
2.  Colocar em Enforcing\
3.  Criar diretório /webdata\
4.  Permitir httpd acessar o diretório\
5.  Validar contexto e funcionamento

------------------------------------------------------------------------

# 🔎 1️⃣ Verificação do SELinux

Comandos usados:

``` bash
getenforce
sestatus
```

### ✅ O que você fez certo:

-   Confirmou que estava em **Enforcing**
-   Validou com `sestatus` (ótimo para prova)

### ⚠️ Desatenção comum:

Você tentou usar `setenforce 1` mesmo já estando em Enforcing. Isso não
é erro grave, mas mostra que você não validou antes de executar.

📌 Lição: Sempre verificar estado antes de alterar.

------------------------------------------------------------------------

# 📁 2️⃣ Criação do Diretório

``` bash
sudo mkdir -p /webdata
sudo touch /webdata/index.html
echo "OK SELinux" | sudo tee /webdata/index.html
```

✔ Estrutura criada corretamente.

------------------------------------------------------------------------

# 🔐 3️⃣ Problema de Contexto SELinux

Ao verificar:

``` bash
ls -ldZ /webdata
```

Resultado inicial:

    default_t

🚨 Isso significa que o Apache NÃO pode acessar o diretório.

------------------------------------------------------------------------

# ❌ Primeira Dificuldade

Você tentou:

``` bash
semodule fcontext -a ...
```

Erro: opção inválida.

📌 Motivo: Você confundiu `semodule` com `semanage`.

-   `semodule` → gerencia módulos de policy
-   `semanage` → gerencia contextos e regras persistentes

Isso é MUITO comum na prova.

------------------------------------------------------------------------

# 📦 4️⃣ Pacote Faltando

Erro:

    semanage: comando não encontrado

Solução:

``` bash
dnf install -y policycoreutils-python-utils
```

💡 Ponto importante para RHCSA: Se o comando não existe, instale o
pacote necessário.

------------------------------------------------------------------------

# 🏷 5️⃣ Correção Correta

``` bash
sudo semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
sudo restorecon -Rv /webdata
```

Depois:

``` bash
ls -lZ /webdata
```

Resultado:

    httpd_sys_content_t

✔ Agora o Apache pode acessar.

------------------------------------------------------------------------

# 🌐 6️⃣ Instalação do Apache

``` bash
dnf install -y httpd
systemctl enable --now httpd
```

✔ Serviço ativo

------------------------------------------------------------------------

# 🚨 Segunda Dificuldade (Importante)

Você fez:

``` bash
curl http://localhost/webdata/
```

E recebeu 404.

📌 Motivo:

Apache não serve diretórios diretamente pelo nome do caminho físico. Ele
serve baseado no **DocumentRoot**.

Você alterou:

    DocumentRoot "/webdata"

✔ Correto.

Mas a URL correta agora é:

``` bash
curl http://localhost/
```

Não:

    /webdata

💡 Isso foi desatenção conceitual de URL vs Filesystem.

------------------------------------------------------------------------

# 🧠 Conceito Fundamental (Muito Importante)

URL ≠ Caminho físico

Se:

    DocumentRoot "/webdata"

Então:

  URL                Arquivo físico
  ------------------ ---------------------
  http://host/       /webdata/index.html
  http://host/test   /webdata/test

Nunca:

    http://host/webdata

------------------------------------------------------------------------

# 🔎 O que Você Aprendeu de Verdade

✔ Como funciona contexto SELinux\
✔ Diferença entre semodule e semanage\
✔ Como instalar ferramentas ausentes\
✔ Como validar contexto com ls -Z\
✔ Como Apache resolve DocumentRoot\
✔ Como testar corretamente com curl

------------------------------------------------------------------------

# 🎯 Pontos de Atenção Para a Prova

1.  Sempre verificar modo do SELinux antes de alterar.
2.  Se `semanage` não existir, instalar pacote.
3.  Nunca esquecer do `restorecon`.
4.  Entender que Apache usa DocumentRoot.
5.  Sempre testar com `curl http://localhost/`.

------------------------------------------------------------------------

# 🏆 Conclusão

Você não apenas executou comandos. Você entendeu:

-   Policy
-   Contexto
-   Serviço
-   Configuração HTTPD
-   Relação URL x filesystem

Isso é mentalidade de administrador real.

🔥 Nível RHCSA: forte.
