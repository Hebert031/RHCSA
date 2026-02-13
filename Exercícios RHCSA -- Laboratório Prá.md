# 📘 Exercícios RHCSA -- Laboratório Prático

------------------------------------------------------------------------

# 🔹 BLOCO 1 --- Usuários e Permissões

## Exercício

1.  Crie um usuário chamado `analista`.
2.  Crie um grupo chamado `financeiro`.
3.  Adicione `analista` ao grupo `financeiro`.
4.  Crie o diretório `/projetos`.
5.  Faça com que apenas membros do grupo `financeiro` possam acessar
    `/projetos`.
6.  Configure senha para `analista`.
7.  Teste login com `su - analista`.

## Comandos

``` bash
sudo useradd analista
sudo groupadd financeiro
sudo usermod -aG financeiro analista

sudo mkdir /projetos
sudo chown :financeiro /projetos
sudo chmod 770 /projetos

sudo passwd analista
su - analista
```

------------------------------------------------------------------------

# 🔹 BLOCO 2 --- Pacotes e Serviços

## Exercício

1.  Instale o pacote `httpd`.
2.  Inicie o serviço.
3.  Configure para iniciar automaticamente no boot.
4.  Verifique status do serviço.
5.  Descubra em qual porta ele está escutando.
6.  Pare o serviço.

## Comandos

``` bash
sudo dnf install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
sudo ss -tulnp | grep httpd
sudo systemctl stop httpd
```

------------------------------------------------------------------------

# 🔹 BLOCO 3 --- Firewall

## Exercício

1.  Libere permanentemente a porta 80/tcp.
2.  Recarregue o firewall.
3.  Liste as portas liberadas.
4.  Remova a porta 80 novamente.

## Comandos

``` bash
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports

sudo firewall-cmd --remove-port=80/tcp --permanent
sudo firewall-cmd --reload
```

------------------------------------------------------------------------

# 🔹 BLOCO 4 --- Rede

## Exercício

Configure IP estático: - IP: 192.168.122.50/24 - Gateway:
192.168.122.1 - DNS: 8.8.8.8

Ative a conexão. Verifique IP com `ip a`. Teste conectividade com
`ping`.

## Comandos

``` bash
nmcli connection show

sudo nmcli connection modify "System enp1s0" ipv4.addresses 192.168.122.50/24 ipv4.gateway 192.168.122.1 ipv4.dns 8.8.8.8 ipv4.method manual ipv6.method ignore

sudo nmcli connection up "System enp1s0"

ip a
ping 8.8.8.8
```

------------------------------------------------------------------------

# 🔹 BLOCO 5 --- LVM

## Exercício

1.  Crie um disco virtual extra na VM (1GB).
2.  Crie um Physical Volume.
3.  Crie um Volume Group chamado `vgdados`.
4.  Crie um Logical Volume chamado `lvprojeto` com 500MB.
5.  Formate em xfs.
6.  Monte em `/dados`.
7.  Configure montagem persistente no `/etc/fstab`.

## Comandos

``` bash
sudo pvcreate /dev/sdb
sudo vgcreate vgdados /dev/sdb
sudo lvcreate -L 500M -n lvprojeto vgdados

sudo mkfs.xfs /dev/vgdados/lvprojeto

sudo mkdir /dados
sudo mount /dev/vgdados/lvprojeto /dados

echo '/dev/vgdados/lvprojeto /dados xfs defaults 0 0' | sudo tee -a /etc/fstab
sudo mount -a
```

------------------------------------------------------------------------

# 🔹 BLOCO 6 --- SELinux

## Exercício

1.  Verifique o modo atual do SELinux.
2.  Coloque em enforcing.
3.  Verifique novamente.
4.  Liste booleans ativos.
5.  Permita que `httpd` acesse um diretório customizado.

## Comandos

``` bash
getenforce
sudo setenforce 1
getenforce

sestatus
getsebool -a | grep httpd

sudo dnf install -y policycoreutils-python-utils

sudo semanage fcontext -a -t httpd_sys_content_t "/meudiretorio(/.*)?"
sudo restorecon -Rv /meudiretorio
```

------------------------------------------------------------------------

# 🔹 BLOCO 7 --- Containers (Podman)

## Exercício

1.  Execute um container nginx.
2.  Liste containers.
3.  Pare o container.
4.  Remova o container.
5.  Liste imagens.

## Comandos

``` bash
sudo dnf install -y podman

podman run -d --name meu-nginx -p 8080:80 nginx
podman ps
podman stop meu-nginx
podman rm meu-nginx
podman images
```
