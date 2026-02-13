# Guia rápido do `tar` (Linux) — empacotar e (opcionalmente) comprimir

O `tar` é a ferramenta clássica do Linux para **empacotar** arquivos e diretórios em um único arquivo.  
Ele pode **apenas juntar** (tarball) ou **juntar + comprimir** (gzip, xz, bzip2).

> **Mentalidade certa:**
> - `tar` = **empacotar**
> - `gzip/xz/bzip2` = **comprimir**

---

## 1) Sintaxe básica

```bash
tar [opções] -f ARQUIVO.tar[.gz|.xz|.bz2] ITENS...
```

### Opções mais comuns
- `-c` **create** (criar arquivo tar)
- `-x` **extract** (extrair)
- `-t` **table** (listar conteúdo)
- `-f` **file** (nome do arquivo **vem logo depois**)
- `-v` **verbose** (mostra o que está fazendo — útil pra debug)
- `-C DIR` extrai/cria **a partir** de um diretório
- Compressão:
  - `-z` gzip (`.tar.gz` / `.tgz`)
  - `-J` xz (`.tar.xz`)
  - `-j` bzip2 (`.tar.bz2`)

📌 **Regra importante:** o nome do arquivo vem **imediatamente após** o `-f`.

---

## 2) Criar tar.gz (o mais usado)

Empacotar e comprimir com gzip:

```bash
tar -czf /root/backup_etc.tgz /etc/ssh /etc/hosts
```

- `-c` cria
- `-z` gzip
- `-f` define o arquivo de saída

💡 Dica: `.tgz` é só um “apelido” de `.tar.gz`.

---

## 3) Listar o conteúdo (sem extrair)

```bash
tar -tzf /root/backup_etc.tgz
```

Quer só ver o começo?

```bash
tar -tzf /root/backup_etc.tgz | head
```

---

## 4) Extrair (descompactar)

### Extrair no diretório atual
```bash
tar -xzf /root/backup_etc.tgz
```

### Extrair em um diretório específico (recomendado)
```bash
mkdir -p /tmp/restore
tar -xzf /root/backup_etc.tgz -C /tmp/restore
```

- `-C /tmp/restore` evita “sujar” o diretório atual.

---

## 5) Criar tar sem compressão (mais rápido, maior)

```bash
tar -cf /root/backup.tar /etc/ssh /etc/hosts
```

Listar:
```bash
tar -tf /root/backup.tar
```

Extrair:
```bash
tar -xf /root/backup.tar -C /tmp/restore
```

---

## 6) Outras compressões (se aparecer)

### XZ (compacta mais, pode ser mais lenta)
```bash
tar -cJf backup.tar.xz /etc/ssh
tar -tJf backup.tar.xz
tar -xJf backup.tar.xz -C /tmp/restore
```

### Bzip2
```bash
tar -cjf backup.tar.bz2 /etc/ssh
tar -tjf backup.tar.bz2
tar -xjf backup.tar.bz2 -C /tmp/restore
```

---

## 7) Caminhos dentro do tar (macete “nota de prova”)

Se você quer evitar caminhos “absolutos” dentro do arquivo (ex.: `etc/ssh/...` em vez de `/etc/ssh/...`), use `-C`:

```bash
tar -czf /root/backup_etc.tgz -C / etc/ssh etc/hosts
```

Assim, você define a “raiz” como `/` e empacota `etc/...` sem barra inicial.

---

## 8) Excluir coisas (útil no dia a dia)

Exemplo: empacotar `/var/log` mas ignorar arquivos `.gz`:

```bash
tar -czf logs.tgz /var/log --exclude='*.gz'
```

---

## 9) Validação rápida (checklist)

Depois de criar:
```bash
tar -tzf /root/backup_etc.tgz | grep -E 'etc/(ssh|hosts)'
```

Para confirmar que extraiu certo:
```bash
ls -l /tmp/restore/etc
```

---

## 10) Pegadinhas comuns

1) **Esquecer o `-f`**  
2) Colocar o nome do arquivo longe do `-f`  
3) Extrair sem `-C` e bagunçar o diretório atual  
4) Confundir `-c` (criar) com `-x` (extrair)  
5) Achar que `tar` é “só compressão” — ele é principalmente **empacotador**

---

## 11) Mini “cola” (cheat sheet)

Criar:
```bash
tar -czf arquivo.tgz pasta/ arquivo.txt
```

Listar:
```bash
tar -tzf arquivo.tgz
```

Extrair:
```bash
tar -xzf arquivo.tgz -C /destino
```

Verbose (ver tudo):
```bash
tar -xzvf arquivo.tgz -C /destino
```

---

✅ Pronto: com isso você resolve praticamente tudo de `tar` que aparece em prova/lab.
