# 📘 Explicação Completa --- Exercício 03 Configuração de Rede (RHCSA)

## 🎯 Objetivo

Configurar IP estático utilizando `nmcli`, definir gateway e DNS, ativar
conexão e validar conectividade.

------------------------------------------------------------------------

# 🔎 1️⃣ Identificar Interface e Conexão

``` bash
ip a
nmcli connection show
```

No seu caso:

Interface: `enp1s0`\
Nome da conexão: `enp1s0`

⚠️ Importante: `nmcli` usa o nome da CONEXÃO, não apenas da interface.

------------------------------------------------------------------------

# 🧱 2️⃣ Configurar IP Estático

``` bash
sudo nmcli connection modify enp1s0 ipv4.addresses 192.168.122.60/24 ipv4.gateway 192.168.122.1 ipv4.dns 8.8.8.8 ipv4.method manual
```

### O que cada parâmetro faz:

-   `ipv4.addresses` → define IP e máscara
-   `ipv4.gateway` → define rota padrão
-   `ipv4.dns` → define servidor DNS
-   `ipv4.method manual` → desativa DHCP e ativa modo estático

------------------------------------------------------------------------

# 🔄 3️⃣ Reiniciar Conexão

``` bash
sudo nmcli connection down enp1s0
sudo nmcli connection up enp1s0
```

Aplica as alterações imediatamente.

------------------------------------------------------------------------

# 🔎 4️⃣ Verificar Configuração

``` bash
ip a
ip route
nmcli device show enp1s0
```

Deve mostrar:

IP: 192.168.122.60/24\
Gateway: 192.168.122.1\
DNS: 8.8.8.8

------------------------------------------------------------------------

# 🌍 5️⃣ Testar Conectividade

## Testar gateway

``` bash
ping -c 4 192.168.122.1
```

## Testar internet (IP direto)

``` bash
ping -c 4 8.8.8.8
```

## Testar DNS

``` bash
ping -c 4 google.com
```

Se:

-   8.8.8.8 funciona → rede OK\
-   google.com funciona → DNS OK

------------------------------------------------------------------------

# 🔁 6️⃣ Teste Pós-Reboot

Reinicie a máquina.

Após subir:

``` bash
ip a
ip route
cat /etc/resolv.conf
```

Se IP continuar estático → configuração persistente correta.

------------------------------------------------------------------------

# 🧠 Conceito Importante para RHCSA

Rede no RHEL/Rocky 9 é gerenciada pelo NetworkManager.

Nunca editar arquivos manualmente se a prova exigir `nmcli`.

Fluxo mental correto:

Identificar conexão → Modificar → Reativar → Validar → Testar →
Reiniciar → Confirmar

------------------------------------------------------------------------

# 🏆 Resultado

Você executou:

✔ Alteração DHCP → Manual\
✔ Configuração IP estático\
✔ Definição Gateway\
✔ Configuração DNS\
✔ Teste de conectividade\
✔ Validação pós-reboot

Nível compatível com prova RHCSA.
