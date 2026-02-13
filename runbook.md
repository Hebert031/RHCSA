# 🛠 Runbook RHCSA --- Usuários, Permissões e LVM

------------------------------------------------------------------------

# 🔐 BLOCO 1 --- Usuários e Permissões

## Criar usuário

``` bash
sudo useradd analista
```

Cria um novo usuário com diretório home e shell padrão.

------------------------------------------------------------------------

## Criar grupo

``` bash
sudo groupadd financeiro
```

Cria um grupo para controle coletivo de acesso.

------------------------------------------------------------------------

## Adicionar usuário ao grupo

``` bash
sudo usermod -aG financeiro analista
```

`-a` adiciona sem remover outros grupos\
`-G` define grupo suplementar

------------------------------------------------------------------------

## Criar diretório

``` bash
sudo mkdir /projetos
```

------------------------------------------------------------------------

## Alterar grupo dono do diretório

``` bash
sudo chown :financeiro /projetos
```

Mantém dono root, altera grupo para financeiro.

------------------------------------------------------------------------

## Ajustar permissões

``` bash
sudo chmod 770 /projetos
```

Dono: rwx\
Grupo: rwx\
Outros: ---

------------------------------------------------------------------------

## Definir senha

``` bash
sudo passwd analista
```

------------------------------------------------------------------------

## Testar login

``` bash
su - analista
```

------------------------------------------------------------------------

# 💾 BLOCO 2 --- LVM

## Listar discos

``` bash
lsblk
```

------------------------------------------------------------------------

## Criar Physical Volume

``` bash
sudo pvcreate /dev/vdb
```

------------------------------------------------------------------------

## Listar PVs

``` bash
sudo pvs
```

------------------------------------------------------------------------

## Criar Volume Group

``` bash
sudo vgcreate vgdata /dev/vdb
```

------------------------------------------------------------------------

## Listar VGs

``` bash
sudo vgs
```

------------------------------------------------------------------------

## Criar Logical Volumes

``` bash
sudo lvcreate -L 500M -n lvapp vgdata
sudo lvcreate -L 700M -n lvdb vgdata
```

------------------------------------------------------------------------

## Listar LVs

``` bash
sudo lvs
```

------------------------------------------------------------------------

## Criar filesystem XFS

``` bash
sudo mkfs.xfs -f /dev/vgdata/lvapp
sudo mkfs.xfs -f /dev/vgdata/lvdb
```

------------------------------------------------------------------------

## Criar pontos de montagem

``` bash
sudo mkdir -p /app /db
```

------------------------------------------------------------------------

## Montar volumes

``` bash
sudo mount /dev/vgdata/lvapp /app
sudo mount /dev/vgdata/lvdb /db
```

------------------------------------------------------------------------

## Verificar montagem

``` bash
df -hT | egrep '/app|/db'
```

------------------------------------------------------------------------

## Obter UUID

``` bash
sudo blkid /dev/vgdata/lvapp /dev/vgdata/lvdb
```

------------------------------------------------------------------------

## Editar fstab

``` bash
sudo nano /etc/fstab
```

Adicionar:

    UUID=SEU-UUID-LVAPP  /app  xfs  defaults  0 0
    UUID=SEU-UUID-LVDB   /db   xfs  defaults  0 0

------------------------------------------------------------------------

## Testar persistência

``` bash
sudo umount /app /db
sudo mount -a
df -hT | egrep '/app|/db'
```

------------------------------------------------------------------------

## Conferência final

``` bash
pvs
vgs
lvs
lsblk
df -hT | egrep '/app|/db'
```

------------------------------------------------------------------------

# 📌 Estrutura LVM

DISCO → PV → VG → LV → Filesystem → Mount

------------------------------------------------------------------------

# 🎯 Observação Importante

Sempre testar `/etc/fstab` com `mount -a` antes de reiniciar.
