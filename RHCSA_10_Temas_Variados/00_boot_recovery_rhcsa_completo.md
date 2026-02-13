# 🔐 Boot Recovery -- Reset de Senha Root (RHEL / Rocky / Alma)

Autor: Hebert Ribeiro\
Objetivo: Recuperar senha do usuário root utilizando os dois métodos
possíveis: - Método moderno (`rd.break`) - Método legado
(`init=/bin/bash`)

------------------------------------------------------------------------

# 🥇 MÉTODO 1 -- rd.break (Padrão RHEL 8/9 -- Recomendado para RHCSA)

## 1️⃣ Reiniciar o sistema

No menu do GRUB pressione:

    e

------------------------------------------------------------------------

## 2️⃣ Editar parâmetros do kernel

Localize a linha que começa com:

    linux

ou

    linuxefi

Adicione ao final:

    rd.break

Exemplo:

    linux (...) ro crashkernel=auto rhgb quiet rd.break

Pressione:

    Ctrl + X

------------------------------------------------------------------------

## 3️⃣ No ambiente initramfs

O sistema real estará montado em:

    /sysroot

Remonte como leitura e escrita:

    mount -o remount,rw /sysroot

Entre no sistema real:

    chroot /sysroot

------------------------------------------------------------------------

## 4️⃣ Alterar senha

    passwd

------------------------------------------------------------------------

## 5️⃣ Corrigir SELinux

    touch /.autorelabel

------------------------------------------------------------------------

## 6️⃣ Finalizar

    exit
    exit

ou

    reboot

------------------------------------------------------------------------

# 🥈 MÉTODO 2 -- init=/bin/bash (Legado -- Simples e Funciona)

## 1️⃣ No GRUB pressione:

    e

------------------------------------------------------------------------

## 2️⃣ Na linha que começa com:

    linux

ou

    linuxefi

Substitua ou remova `rhgb quiet` e adicione:

    init=/bin/bash

Exemplo:

    linux (...) ro crashkernel=auto init=/bin/bash

Pressione:

    Ctrl + X

------------------------------------------------------------------------

## 3️⃣ Sistema sobe direto no bash como root

O sistema estará montado como somente leitura.

Remonte:

    mount -o remount,rw /

------------------------------------------------------------------------

## 4️⃣ Alterar senha

    passwd

------------------------------------------------------------------------

## 5️⃣ Corrigir SELinux

    touch /.autorelabel

------------------------------------------------------------------------

## 6️⃣ Reiniciar

    reboot -f

ou

    exec /sbin/init

------------------------------------------------------------------------

# 📌 Resumo Rápido para Prova

## rd.break

    GRUB → e
    rd.break
    Ctrl+X
    mount -o remount,rw /sysroot
    chroot /sysroot
    passwd
    touch /.autorelabel
    exit
    exit

## init=/bin/bash

    GRUB → e
    init=/bin/bash
    Ctrl+X
    mount -o remount,rw /
    passwd
    touch /.autorelabel
    reboot -f

------------------------------------------------------------------------

# 🎯 Observação

-   `rd.break` é o método oficial moderno.
-   `init=/bin/bash` ainda funciona e é mais direto.
-   Sempre usar `touch /.autorelabel` se SELinux estiver habilitado.
