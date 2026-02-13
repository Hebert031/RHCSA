# Simulado RHCSA (EX200) — estilo Red Hat (RHEL 10)

> **Tempo sugerido:** 3 horas (1 seção).  
> **Regras do simulado (igual “vida real”):** sem internet, só *man/info* e documentação local.  
> **Persistência:** tudo deve continuar funcionando após reboot.  
> **Base:** objetivos públicos do EX200 (RHEL 10).  

---

## 0) Ambiente do laboratório (sugestão)

Crie **2 VMs** (ou 2 hosts) na mesma rede:

- **servera.lab.local**
  - IPv4: `192.168.50.10/24`
  - IPv6: `fd00:50::10/64`
- **serverb.lab.local**
  - IPv4: `192.168.50.11/24`
  - IPv6: `fd00:50::11/64`
- Gateway: `192.168.50.1`
- DNS: `192.168.50.1` (ou o que você tiver no lab)

Credenciais (defina no seu lab):
- `root` com senha conhecida (ex.: `redhat`)
- Usuário comum: `student` com senha conhecida (ex.: `student`)

Discos extras (opcional, mas recomendado):
- Adicione **2 discos** ao `servera`:
  - `/dev/vdb` com ~5 GiB
  - `/dev/vdc` com ~3 GiB

---

## 1) Como pontuar

- Total: **100 pontos**
- Você “passa” no simulado com **70+** (ajuste como quiser).
- Ao final, faça **reboot** nos 2 hosts e valide tudo.

---

# Tarefas (100 pts)

## A) Ferramentas essenciais (18 pts)

1. **(3 pts)** No `servera`, crie o arquivo `/root/relatorio.txt` com:
   - hostname
   - data/hora
   - kernel (`uname -r`)
   Tudo em um único comando usando redirecionamento (`>` e/ou `>>`).

2. **(3 pts)** No `servera`, encontre **todas** as linhas de erro (case-insensitive) em:
   - `/var/log/messages` **ou** `journalctl`
   Salve em `/root/erros.txt`.

3. **(3 pts)** No `servera`, crie:
   - diretório `/opt/projetos`
   - arquivo `/opt/projetos/README.txt` com 3 linhas
   - um **link simbólico** `/root/readme_projetos` apontando para esse arquivo

4. **(3 pts)** No `servera`, crie um **hard link** de `/etc/hosts` em `/root/hosts.hard`.

5. **(3 pts)** Crie um tar.gz em `/root/backup_etc.tgz` contendo `/etc/ssh/` e `/etc/hosts`.

6. **(3 pts)** Ajuste permissões (ugo/rwx) para que `/opt/projetos` fique:
   - dono: `root`, grupo: `root`
   - permissões: dono `rwx`, grupo `rx`, outros `---`

---

## B) Software e repositórios (10 pts)

7. **(4 pts)** No `servera`, configure um repositório RPM (pode ser local no lab ou remoto, o importante é funcionar) e instale:
   - `vim` (ou `vim-enhanced`)
   - `tree`

8. **(3 pts)** Remova um pacote que você **não** precise (ex.: `nano` ou outro que exista no seu sistema) e prove que foi removido.

9. **(3 pts)** (Se o seu lab suportar) configure um repositório Flatpak e instale **um** app simples.  
   Se não tiver Flatpak no lab, **valide apenas** que você sabe listar remotos e consultar ajuda.

---

## C) Shell script (10 pts)

10. **(6 pts)** Crie o script `/usr/local/bin/checador.sh` que:
   - Recebe 1 argumento (um diretório)
   - Se não existir, imprime “NAO EXISTE” e sai com código `2`
   - Se existir, imprime:
     - “OK: <dir>”
     - número de arquivos regulares dentro (apenas 1 nível)  
   Dica: use `test`, `if`, `find`, `wc -l`.

11. **(4 pts)** Crie um loop no script (ou outro script `/usr/local/bin/loop.sh`) que:
   - percorra uma lista de usuários (ex.: `ana bob carla`)
   - para cada um, imprima `user:<nome>`.

---

## D) Operar sistemas (18 pts)

12. **(4 pts)** No `servera`, configure o `journald` para **persistir** logs em disco.

13. **(4 pts)** No `servera`, crie um serviço systemd customizado `hello.service` que execute:
   - `logger "HELLO-RHCSA"`  
   O serviço deve iniciar manualmente e registrar no journal.

14. **(4 pts)** No `servera`, crie um **timer systemd** que execute diariamente (horário à sua escolha) o comando:
   - `logger "TIMER-RHCSA"`

15. **(3 pts)** Ajuste o sistema para bootar por padrão no target **multi-user**.

16. **(3 pts)** Ative um perfil de tuning (`tuned`) apropriado para “throughput” (ou equivalente disponível no seu sistema) e faça persistir.

---

## E) Storage local (18 pts)

> Use o `servera` com discos extras.

17. **(6 pts)** Em `/dev/vdb`, crie uma partição GPT para LVM, crie:
   - VG: `vgdados`
   - LV: `lvdados` com 1 GiB
   Formate em **XFS** e monte em `/dados` (persistente no boot por UUID ou LABEL).

18. **(4 pts)** Estenda o `lvdados` para **2 GiB** sem perder dados e confirme o novo tamanho do filesystem.

19. **(4 pts)** Crie uma área de **swap** de 512 MiB (pode ser LV ou partição) e ative no boot.

20. **(4 pts)** Em `/dev/vdc`, crie um filesystem **ext4** com label `BACKUP` e monte em `/backup` usando o **label** no `/etc/fstab`.

---

## F) File systems e NFS/autofs (12 pts)

21. **(4 pts)** No `serverb`, configure um export NFS:
   - Diretório: `/exports/public`
   - Permissões: leitura para clientes da rede `192.168.50.0/24`
   - Garanta que o serviço NFS suba no boot e que o firewall permita.

22. **(4 pts)** No `servera`, monte o NFS de `serverb:/exports/public` em `/mnt/public` e configure para montar no boot.

23. **(4 pts)** No `servera`, configure **autofs** para que acessar `/net/public` monte automaticamente o mesmo NFS.

---

## G) Networking e firewall (6 pts)

24. **(3 pts)** Configure IPv4 e IPv6 estáticos (conforme topo do simulado) nos dois hosts.

25. **(3 pts)** Configure resolução de nomes para que `servera` e `serverb` resolvam entre si (DNS do lab ou `/etc/hosts`, mas tem que funcionar).

---

## H) Usuários, grupos e sudo (10 pts)

26. **(3 pts)** Crie:
   - Grupo `ops`
   - Usuários `ana` e `bob` (shell bash) pertencendo ao grupo `ops`

27. **(3 pts)** Configure política de senha/aging para `ana`:
   - expira em 30 dias
   - aviso de 7 dias antes de expirar

28. **(4 pts)** Configure `sudo`:
   - membros do grupo `ops` podem executar **apenas** `systemctl` e `journalctl`
   - sem pedir senha (**NOPASSWD**)

---

## I) Segurança (SELinux + SSH) (18 pts)

29. **(4 pts)** Garanta SELinux em modo **enforcing** no `servera`.

30. **(6 pts)** No `servera`:
   - instale e habilite `httpd`
   - crie `/webdata/index.html` com conteúdo “OK RHCSA”
   - configure o `httpd` para servir esse conteúdo
   - **corrija contexto SELinux** do diretório/arquivo para servir via HTTP
   - libere no firewall (porta padrão 80)

31. **(4 pts)** Mude o `httpd` para escutar na porta **8081** e:
   - ajuste firewall
   - ajuste SELinux (label de porta) para permitir o novo bind

32. **(4 pts)** Configure autenticação SSH por chave:
   - Gere uma chave para o usuário `student` no `servera`
   - Permita login via chave em `serverb` como `student` (sem senha)

---

# BÔNUS (opcional, +10 pts) — Containers (podman)

> Alguns materiais e versões da certificação citam “basic container management”. Se você quiser treinar isso também:

B1. **(+5 pts)** No `servera`, baixe (ou carregue de um tar local) uma imagem e rode um container chamado `webtest` que:
- execute em background
- publique `8082:80` (host:container)
- reinicie automaticamente

B2. **(+5 pts)** Gere um arquivo `/root/containers.txt` com:
- `podman ps`
- `podman images`

---

## Checklist final (não é solução)

- Reboot `servera` e `serverb`
- Confira:
  - mounts (`findmnt`, `lsblk`, `swapon --show`)
  - NFS/autofs (`mount`, `showmount -e`, `ls /net/public`)
  - firewall (`firewall-cmd --list-all`)
  - SELinux (`getenforce`, `semanage port -l | grep http_port_t`)
  - serviços (`systemctl is-enabled/is-active`)
  - SSH por chave (`ssh student@serverb`)

Boa prova. 🙂
