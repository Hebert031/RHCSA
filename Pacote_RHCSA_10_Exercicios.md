# 📘 PACOTE RHCSA -- 10 EXERCÍCIOS PRÁTICOS (LVM + ADMIN)

------------------------------------------------------------------------

## EXERCÍCIO 1 -- LVM Básico

1.  Adicione um disco virtual de 1GB.
2.  Crie um Physical Volume.
3.  Crie um Volume Group chamado `vgteste`.
4.  Crie um Logical Volume `lvteste` com 300MB.
5.  Formate em XFS.
6.  Monte em `/teste`.
7.  Configure persistência no `/etc/fstab`.

------------------------------------------------------------------------

## EXERCÍCIO 2 -- Expansão

1.  Expanda o Volume Group adicionando mais espaço.
2.  Expanda o Logical Volume existente.
3.  Expanda o sistema de arquivos.
4.  Verifique o novo tamanho.

------------------------------------------------------------------------

## EXERCÍCIO 3 -- Múltiplos Volumes

1.  Crie um VG chamado `vgdados`.
2.  Crie dois LVs: `lvapp` (500MB) e `lvbackup` (700MB).
3.  Formate ambos.
4.  Monte em `/app` e `/backup`.
5.  Configure montagem persistente.

------------------------------------------------------------------------

## EXERCÍCIO 4 -- Usuários + LVM

1.  Crie grupo `infra`.
2.  Configure `/app` para acesso exclusivo do grupo.
3.  Crie usuário `deploy`.
4.  Teste permissões.

------------------------------------------------------------------------

## EXERCÍCIO 5 -- Snapshot

1.  Crie snapshot do LV `lvapp`.
2.  Modifique arquivos.
3.  Restaure snapshot.

------------------------------------------------------------------------

## EXERCÍCIO 6 -- Redução (Simulado Avançado)

1.  Reduza um LV existente.
2.  Ajuste sistema de arquivos corretamente.
3.  Valide integridade.

------------------------------------------------------------------------

## EXERCÍCIO 7 -- Firewalld

1.  Libere porta 8080 permanentemente.
2.  Recarregue firewall.
3.  Verifique regras ativas.

------------------------------------------------------------------------

## EXERCÍCIO 8 -- SELinux

1.  Verifique modo atual.
2.  Coloque em enforcing.
3.  Permita httpd acessar diretório customizado.

------------------------------------------------------------------------

## EXERCÍCIO 9 -- Rede Estática

1.  Configure IP estático.
2.  Configure gateway e DNS.
3.  Ative conexão.
4.  Teste conectividade.

------------------------------------------------------------------------

## EXERCÍCIO 10 -- Simulação Final

1.  Criar usuário.
2.  Criar LVM.
3.  Configurar firewall.
4.  Ajustar SELinux.
5.  Tornar tudo persistente.
6.  Reiniciar e validar funcionamento.
