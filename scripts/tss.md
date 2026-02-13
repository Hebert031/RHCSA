LABORATÓRIO DE VOZ – COQUI TTS + XTTS

Autor: Hebert Ribeiro
Ambiente: Debian 13
📌 Objetivo

Gerar áudio em português brasileiro usando:

    Modelo simples (VITS PT)

    Modelo avançado (XTTS v2 – clonagem de voz)

📦 Estrutura do Projeto

~/tss/
 ├── venv/
 ├── teste.wav
 └── README_TTS_RHCSA.md

🚀 1️⃣ Ativar ambiente correto

SEMPRE faça isso antes de usar:

cd ~/tss
source venv/bin/activate

Confirme:

which tts

Deve retornar:

/root/tss/venv/bin/tts

Se aparecer .pyenv, está errado.
🎧 2️⃣ Modelo Simples (Português Brasil)

Modelo leve e estável:

tts_models/pt/cv/vits

Gerar áudio:

tts \
--text "Olá, estamos iniciando o laboratório RHCSA." \
--model_name tts_models/pt/cv/vits \
--out_path teste.wav

Copiar para usuário:

cp teste.wav /home/hebert/

🧠 3️⃣ Modelo Avançado – XTTS v2 (Clonagem de Voz)

Modelo multilíngue com clonagem de voz:

tts_models/multilingual/multi-dataset/xtts_v2

⚠️ Requer áudio da sua voz
🎤 4️⃣ Gravar sua voz

Listar dispositivos:

arecord -l

Gravar com dispositivo USB (exemplo hw:2,0):

arecord -D plughw:2,0 -f cd ~/Downloads/voz.wav

Fale por 5–10 segundos.

Ctrl+C para parar.
🔊 5️⃣ Gerar áudio com sua voz clonada

tts \
--text "Olá, estamos iniciando o laboratório RHCSA." \
--model_name tts_models/multilingual/multi-dataset/xtts_v2 \
--language_idx pt \
--speaker_wav /home/hebert/Downloads/voz.wav \
--out_path teste.wav

🛠 Problemas comuns
❌ BeamSearchScorer error

Corrigir:

pip uninstall transformers -y
pip install transformers==4.39.3

Verificar versão:

python -c "import transformers; print(transformers.__version__)"

Deve ser:

4.39.3

❌ Multi-speaker model error

Mensagem:

You need to define either speaker_idx or speaker_wav

Solução: usar

--speaker_wav caminho/voz.wav

❌ arecord erro

Use:

arecord -D plughw:2,0 -f cd arquivo.wav

⚡ 6️⃣ Gerar áudio de texto grande (arquivo)

tts \
--text "$(cat /caminho/arquivo.txt)" \
--model_name tts_models/pt/cv/vits \
--out_path runbook.wav

Se tiver espaço no nome do caminho:

cat /home/hebert/Área\ de\ trabalho/RHCSA/RHCSA/runbook.txt

🎯 7️⃣ Script automático (opcional)

Criar arquivo gerar_audio.sh:

#!/bin/bash
source ~/tss/venv/bin/activate

tts \
--text "$1" \
--model_name tts_models/pt/cv/vits \
--out_path saida.wav

cp saida.wav /home/hebert/
echo "Áudio gerado com sucesso."

Dar permissão:

chmod +x gerar_audio.sh

Usar:

./gerar_audio.sh "Texto que eu quiser"

🧠 Observações Técnicas

    XTTS baixa ~1.8GB

    Funciona melhor com GPU

    VITS é mais leve e rápido

    XTTS permite criar sua própria identidade de voz
