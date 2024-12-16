#!/bin/bash

# This is a script to run before docker compose

# chat-ui
chmod a+w docker-images/chat-ui/chat/db

if ! [ -d "docker-images/chat-ui/TEI/bge-large-en-v1.5" ]
then
    cd docker-images/chat-ui/TEI
    git clone https://hf.co/BAAI/bge-large-en-v1.5
    cd -
fi

if ! [ -d "docker-images/chat-ui/TGI/Phi-3-mini-4k-instruct" ]
then
    cd docker-images/chat-ui/TGI
    git clone https://hf.co/microsoft/Phi-3-mini-4k-instruct
    cd -
fi

if ! [ -d "docker-images/chat-ui/llama.cpp/Phi-3-mini-4k-instruct-gguf" ]
then
    cd docker-images/chat-ui/llama.cpp
    git clone https://hf.co/microsoft/Phi-3-mini-4k-instruct-gguf
    cd -
fi

docker compose down

docker compose build

docker compose push

docker compose pull

# for file in $(ls docker-images/chat-ui/chat/db); do rm -rf "docker-images/chat-ui/chat/db/$file"; done

docker compose up -d
