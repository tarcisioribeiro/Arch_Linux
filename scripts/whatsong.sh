#!/bin/bash

# Verifica qual player está tocando e retorna o nome da música
playerctl metadata title || echo "No song playing"
