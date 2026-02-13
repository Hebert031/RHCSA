
# 🛠 Runbook RHCSA — Usuários, Permissões, LVM, Rede, Firewall e SELinux

---

# 🔐 BLOCO 1 — Usuários e Permissões

## Criar usuário

```bash
sudo useradd analista
```

Cria um novo usuário com diretório home e shell padrão.

---

## Criar grupo

```bash
sudo groupadd financeiro
```

Cria um grupo para controle coletivo de acesso.

---

## Adicionar usuário ao grupo

```bash
sudo usermod -aG financeiro analista
```

- `-a` adiciona sem remover outros grupos  
- `-G` define grupo suplementar  

---

## Criar diretório

```bash
sudo mkdir /projetos
```

---

## Alterar grupo dono do diretório

```bash
sudo chown :financeiro /projetos
```

Mantém dono root, altera grupo para financeiro.

---

## Ajustar permissões

```bash
sudo chmod 770 /projetos
```

Dono: rwx  
Grupo: rwx  
Outros: ---  

---

## Definir senha

```bash
sudo passwd analista
```

---

## Testar login

```bash
su - analista
```

---

# 💾 BLOCO 2 — LVM

## Listar discos

```bash
lsblk
```

---

## Criar Physical Volume

```bash
sudo pvcreate /dev/vdb
```

---

## Criar Volume Group

```bash
sudo vgcreate vgdata /dev/vdb
```

---

## Criar Logical Volumes

```bash
sudo lvcreate -L 500M -n lvapp vgdata
sudo lvcreate -L 700M -n lvdb vgdata
```

---

## Criar filesystem

```bash
sudo mkfs.xfs -f /dev/vgdata/lvapp
sudo mkfs.xfs -f /dev/vgdata/lvdb
```

---

## Criar pontos de montagem

```bash
sudo mkdir -p /app /db
```

---

## Montar volumes

```bash
sudo mount /dev/vgdata/lvapp /app
sudo mount /dev/vgdata/lvdb /db
```

---

## Persistência

```bash
sudo blkid
sudo nano /etc/fstab
sudo mount -a
```

---

# 🌐 BLOCO 3 — Rede

## Configurar IP estático

```bash
sudo nmcli connection modify enp1s0 ipv4.addresses 192.168.122.60/24 ipv4.gateway 192.168.122.1 ipv4.dns 8.8.8.8 ipv4.method manual
```

Reativar:

```bash
sudo nmcli connection down enp1s0
sudo nmcli connection up enp1s0
```

Testar:

```bash
ping 8.8.8.8
```

---

# 🔥 BLOCO 4 — Firewalld

## Liberar portas

```bash
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload
```

Remover porta:

```bash
sudo firewall-cmd --permanent --remove-port=443/tcp
sudo firewall-cmd --reload
```

Verificar:

```bash
sudo firewall-cmd --list-ports
```

---

# 🛡 BLOCO 5 — SELinux

## Verificar modo

```bash
getenforce
sestatus
```

---

## Criar diretório

```bash
sudo mkdir -p /webdata
sudo touch /webdata/index.html
```

---

## Ajustar contexto

```bash
sudo dnf install -y policycoreutils-python-utils
sudo semanage fcontext -a -t httpd_sys_content_t "/webdata(/.*)?"
sudo restorecon -Rv /webdata
```

Validar:

```bash
ls -lZ /webdata
```

---

# 🌐 BLOCO 6 — HTTPD

## Instalar e iniciar

```bash
sudo dnf install -y httpd
sudo systemctl enable --now httpd
```

Alterar DocumentRoot para /webdata:

Editar `/etc/httpd/conf/httpd.conf`

```
DocumentRoot "/webdata"
```

Adicionar:

```apache
<Directory "/webdata">
    AllowOverride None
    Require all granted
</Directory>
```

Reiniciar:

```bash
sudo systemctl restart httpd
```

Testar:

```bash
curl http://localhost/
```

---

# 🎯 CHECKLIST FINAL

✔ Usuário criado  
✔ Permissões corretas  
✔ LVM funcional  
✔ fstab validado  
✔ Rede configurada  
✔ Firewall aplicado  
✔ SELinux correto  
✔ Apache funcionando  
