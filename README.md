# Primeiros passos com Dockerfile

Um Dockerfile é um arquivo de configuração usado no Docker, uma plataforma de conteinerização que permite empacotar, distribuir e executar aplicativos em contêineres leves e isolados. O Dockerfile é usado para definir como um contêiner deve ser construído. Ele contém uma lista de instruções que o Docker segue para criar uma imagem do contêiner.

### Aqui estão algumas das instruções comuns que você pode encontrar em um Dockerfile:

***FROM:*** Esta é a primeira instrução em um Dockerfile e especifica a imagem base a ser usada como ponto de partida. Todas as instruções subsequentes serão aplicadas a partir desta imagem base. Por exemplo, você pode usar FROM ubuntu:20.04 para iniciar com uma imagem base do Ubuntu 20.04.

***RUN:*** Esta instrução permite que você execute comandos dentro do contêiner durante a construção da imagem. Por exemplo, você pode usar RUN apt-get update && apt-get install -y apache2 para instalar o servidor web Apache durante a construção da imagem.

***COPY*** e ***ADD:*** Essas instruções são usadas para copiar arquivos e diretórios do sistema de arquivos do host para dentro do contêiner. O COPY é usado para copiar arquivos do host, enquanto o ADD pode fazer isso e também suporta URLs e descompactação de arquivos.

***WORKDIR:*** Define o diretório de trabalho dentro do contêiner onde comandos subsequentes serão executados. Isso ajuda a manter o contexto dos comandos organizado.

***EXPOSE:*** Esta instrução especifica as portas em que o contêiner estará escutando durante a execução. No entanto, ela não publica automaticamente as portas para o host, isso deve ser feito explicitamente ao iniciar o contêiner.

***CMD*** e ***ENTRYPOINT:*** Essas instruções definem o comando padrão que será executado quando o contêiner for iniciado. A diferença principal é que o CMD pode ser substituído quando você inicia o contêiner com comandos específicos, enquanto o ENTRYPOINT não pode ser substituído.

***ENV:*** Essa instrução define variáveis de ambiente dentro do contêiner, o que é útil para configurar parâmetros de aplicativos.

***LABEL:*** Permite adicionar metadados descritivos à imagem, como informações de versão, autor, etc.

***VOLUME:*** Especifica os pontos de montagem para volumes externos que podem ser anexados ao contêiner durante a execução.

Depois de criar um [***Dockerfile***](dockerfile), você pode usar o comando docker build para criar uma imagem a partir dele. Em seguida, você pode usar essa imagem para criar e executar contêineres isolados que executam seu aplicativo ou serviço.

O ***Dockerfile*** é uma parte fundamental da abordagem de ***conteinerização***, permitindo a criação de ambientes consistentes e isolados para seus aplicativos, facilitando a implantação e a escalabilidade.

### Arquivo Dockerfile

```bash
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

# Comando para deixar o contêiner em execução, após sua ativação.
ENTRYPOINT tail -f /dev/null
```

### Exemplo de customização de uma imagem

+ Clonando o repositório:

```bash
git clone https://github.com/Renatoelho/dockerfile.git dockerfile
```

+ Acessando o repositório:

```bash
cd dockerfile/
```

+ Construíndo a imagem:

```bash
docker build -f dockerfile -t imagem-base:0.0.1 .
```

+ Criando um contêiner a partir da imagem:

```bash
docker run --rm -d --name=servidor_app --hostname=servidor_app imagem-base:0.0.1
```

+ Acessando o contêiner:

```bash
docker exec -it servidor_app bash
```

### Referências: 

Dockerfile reference, ***Docker Docs***. Disponível em: \<[https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)\>. Acesso em: 01 set. de 2023.
