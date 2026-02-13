# 🎙 LABORATÓRIO DE VOZ -- COQUI TTS + XTTS

**Autor:** Hebert Ribeiro\
**Ambiente:** Debian 13

------------------------------------------------------------------------

## 📌 Objetivo

Gerar áudio em português brasileiro usando:

-   Modelo simples (VITS PT)
-   Modelo avançado (XTTS v2 -- clonagem de voz)

------------------------------------------------------------------------

## 📦 Estrutura do Projeto

\~/tss/ ├── venv/ ├── teste.wav └── README_TTS_RHCSA.md

------------------------------------------------------------------------

# 🚀 1️⃣ Ativar ambiente correto

``` bash
cd ~/tss
source venv/bin/activate
```

Confirmar:

``` bash
which tts
```

------------------------------------------------------------------------

# 🎧 2️⃣ Modelo Simples (Português Brasil)

``` bash
tts --text "Olá, estamos iniciando o laboratório RHCSA." --model_name tts_models/pt/cv/vits --out_path teste.wav
```

------------------------------------------------------------------------

# 🎤 3️⃣ Gravar sua voz

``` bash
arecord -l
arecord -D plughw:2,0 -f cd ~/Downloads/voz.wav
```

------------------------------------------------------------------------

# 🔊 4️⃣ XTTS v2 -- Clonagem de Voz

``` bash
tts --text "Olá, estamos iniciando o laboratório RHCSA." --model_name tts_models/multilingual/multi-dataset/xtts_v2 --language_idx pt --speaker_wav /home/hebert/Downloads/voz.wav --out_path teste.wav
```

------------------------------------------------------------------------

# 🛠 Correção BeamSearchScorer

``` bash
pip uninstall transformers -y
pip install transformers==4.39.3
```

------------------------------------------------------------------------

# ⚡ Texto grande (arquivo)

``` bash
tts --text "$(cat /caminho/arquivo.txt)" --model_name tts_models/pt/cv/vits --out_path runbook.wav
```

------------------------------------------------------------------------

# 🎯 Script automático

``` bash
#!/bin/bash
source ~/tss/venv/bin/activate

tts --text "$1" --model_name tts_models/pt/cv/vits --out_path saida.wav

cp saida.wav /home/hebert/
echo "Áudio gerado com sucesso."
```

------------------------------------------------------------------------

## 🧠 Observações

-   XTTS baixa \~1.8GB\
-   Melhor com GPU\
-   VITS é mais leve\
-   XTTS permite clonagem de voz
