#!/bin/bash
# Script de Limpeza Automática para openSUSE Leap 15.6
# Autor: [Seu Nome]
# Data: [Data]
# Descrição: Este script realiza a limpeza automática do sistema, incluindo cache de pacotes,
# arquivos temporários, logs antigos, snapshots do Snapper e otimização do sistema de arquivos.

# Limpar cache de pacotes Zypper
echo "Limpando cache de pacotes Zypper..."
sudo zypper clean --all

# Limpar arquivos temporários
echo "Limpando arquivos temporários..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Limpar logs antigos
echo "Limpando logs antigos..."
sudo journalctl --vacuum-time=7d
# Opcional: Limpar todos os arquivos de log (mantenha apenas logs recentes)
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;

# Limpeza de snapshots antigos do Snapper
echo "Limpando snapshots antigos do Snapper..."
sudo snapper cleanup timeline
sudo snapper cleanup number

# Otimizar sistema de arquivos Btrfs
echo "Otimizando sistema de arquivos Btrfs..."
sudo btrfs balance start -dusage=75 /
sudo btrfs scrub start /

# Reorganizar estrutura do sistema de arquivos (fstrim)
echo "Executando fstrim..."
sudo fstrim -av

echo "Limpeza automática concluída!"