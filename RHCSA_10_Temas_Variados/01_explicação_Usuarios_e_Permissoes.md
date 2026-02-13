# 📘 Resolução Comentada -- Exercício 01 (Usuários e Permissões)

## 📌 Objetivo do Exercício

1.  Criar usuários: dev1, dev2 e auditor
2.  Criar grupo projeto
3.  Adicionar dev1 e dev2 ao grupo projeto
4.  Criar diretório /srv/projeto
5.  Permitir acesso total apenas ao grupo projeto
6.  Permitir auditor com acesso somente leitura
7.  Testar permissões

------------------------------------------------------------------------

# ✅ Resolução Correta

## 1️⃣ Criar usuários

``` bash
useradd dev1
useradd dev2
useradd auditor
```

------------------------------------------------------------------------

## 2️⃣ Criar grupo

``` bash
groupadd projeto
```

------------------------------------------------------------------------

## 3️⃣ Adicionar usuários ao grupo

``` bash
usermod -aG projeto dev1
usermod -aG projeto dev2
```

------------------------------------------------------------------------

## 4️⃣ Criar diretório

``` bash
mkdir -p /srv/projeto
```

------------------------------------------------------------------------

## 5️⃣ Configurar grupo dono + permissão total para grupo

``` bash
chown :projeto /srv/projeto
chmod 770 /srv/projeto
```

### 🔎 Onde houve dificuldade

Você tentou:

``` bash
chown -R 770 /srv/projeto
```

Mas:

-   `chown` altera dono/grupo
-   `chmod` altera permissões

Essa confusão é comum e totalmente normal no início.

------------------------------------------------------------------------

# 🧠 Entendendo 770

    rwx | rwx | ---
    owner | group | others

-   Owner → controle total
-   Grupo → controle total
-   Outros → nenhum acesso

Como dev1 e dev2 estão no grupo `projeto`, funcionou após aplicar
corretamente.

------------------------------------------------------------------------

# 6️⃣ Configurar auditor somente leitura

Permissões tradicionais NÃO permitem:

-   Grupo com rwx
-   Usuário específico apenas leitura

Por isso usamos ACL.

------------------------------------------------------------------------

# 📘 O que é ACL?

ACL (Access Control List) permite adicionar permissões específicas para
usuários ou grupos adicionais sem alterar owner/group principal.

------------------------------------------------------------------------

## Aplicando ACL

``` bash
setfacl -m u:auditor:rx /srv/projeto
```

Verificar:

``` bash
getfacl /srv/projeto
```

Saída esperada:

    user::rwx
    group::rwx
    other::---
    user:auditor:r-x

Agora:

-   dev1 e dev2 → rwx
-   auditor → r-x
-   outros → nenhum acesso

------------------------------------------------------------------------

# 🔎 Teste realizado

``` bash
su - auditor
touch /srv/projeto/teste
```

Resultado:

    Permissão negada

Mas leitura funcionou.

✔️ Comportamento correto.

------------------------------------------------------------------------

# 🚀 Conceito importante para prova

RHCSA normalmente foca mais em:

-   chmod
-   chown
-   grupos
-   permissões numéricas

ACL pode aparecer, mas não é foco pesado.

Você demonstrou:

✔️ Raciocínio de troubleshooting\
✔️ Teste com su\
✔️ Correção incremental\
✔️ Validação real

Isso é comportamento de administrador.

------------------------------------------------------------------------

# 📌 Resumo do aprendizado

Erro comum: - Confundir chown com chmod

Novo conceito aprendido: - ACL para permissões específicas

Nível atual: - Intermediário avançando para sólido

------------------------------------------------------------------------

🔥 Próximo passo recomendado: Treinar LVM com mesma lógica de execução +
validação.
