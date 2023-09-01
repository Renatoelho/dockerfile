# Imagem base do nosso Dockerfile.
FROM ubuntu:20.04

# Anotações para adicionar aos metadados da nossa imagem.
LABEL maintainer="Renato coelho <contato@renato.tec.br>"
LABEL version="0.0.1"
LABEL description="Está é uma imagem de exemplo."

# Definindo o bash como SHELL padrão.
SHELL ["/bin/bash", "-c"]

# Criando e configurando o usuário 'user01' para nossa imagem.
RUN useradd -ms /bin/bash user01 -G sudo && \
  passwd -d  user01 && \
  mkdir -p /home/user01/app

# Definindo o diretório padrão da nossa imagem.
WORKDIR /home/user01/app

# Atualizando o APT e instalando alguns softwares.
RUN apt update && \
  apt install curl \
  wget \
  nano \
  zip \
  unzip \
  sudo -y

# Copiando o conteúdo do diretório 'app' para a imagem.
COPY app/ .

# Copiando um arquivo direto da WEB para o diretório 'app'.
ADD https://renato.tec.br/wp-content/uploads/2020/07/Foto-Renato-FULL-Tratadav4.jpg .

# Atribuindo a propriedade do diretório 'app' ao usuário 'user01'.
RUN chown -R user01:user01 /home/user01/app

# Adicionando a variável TERM as variáveis de ambiente da imagem.
ENV TERM=xterm-256color

# Definindo o usuário padrão da nossa imagem.
USER user01

# Comando para deixar o contêiner em execução.
ENTRYPOINT tail -f /dev/null