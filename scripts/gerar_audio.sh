#!/bin/bash
source ~/tss/venv/bin/activate

tts \
--text "$1" \
--model_name tts_models/pt/cv/vits \
--out_path saida.wav

cp saida.wav /home/hebert/
echo "Áudio gerado com sucesso."