# resumo sobre docker

## comandos do docker

Objetos comuns
* container
* image
* volume
* network

Ações comuns
* ls → listar
* rm → remover
* run → executar
* create → criar
* start / stop → iniciar/parar

comando: **docker [objeto] [ação]**

## comandos Dockerfile

* FROM - define a imagem base
* RUN - executa comandos durante o build da imagem
* WORKDIR - define o diretório de trabalho dentro do container
* COPY - copia arquivos da máquina local para a imagem
* ADD - copia arquivos e também pode extrair arquivos compactados
* LABEL - adiciona metadados na imagem
* ENV - define variáveis de ambiente
* VOLUME - define um ponto de volume no container
* ARG - define variáveis usadas apenas no build
* EXPOSE - documenta a porta que a aplicação usa
* USER - define qual usuário vai executar os comandos
* CMD - define o comando padrão ao iniciar o container
* ENTRYPOINT - define o executável principal do container

## diferença entre CMD e ENTRYPOINT

* `CMD`
  - define um comando padrão
  - pode ser substituído ao executar o container
* `ENTRYPOINT`
  - define o comando principal fixo do container
  - normalmente não é substituído, apenas recebe argumentos

### resumo

* use `CMD` quando quiser um comando padrão mais fácil de trocar
* use `ENTRYPOINT` quando o container sempre precisar executar o mesmo programa

## Dockerfile node.js

```docker
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```

## docker-compose.yml básico

```yaml
services:
  app:
    build: .
    container_name: app-node
    ports:
      - "3000:3000"
    depends_on:
      - postgres
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: postgres
      DB_PASSWORD: postgres
      DB_NAME: appdb
    networks:
      - app-network

  postgres:
    image: postgres:16
    container_name: postgres-db
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: appdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - app-network

volumes:
  postgres-data:

networks:
  app-network:
```

## comandos usados no docker-compose.yml
* `services`
  - agrupa os containers da aplicação
* `app`
  - service da aplicação Node.js
* `postgres`
  - service do banco de dados PostgreSQL
* `build: .`
  - manda construir a imagem usando o Dockerfile da pasta atual
* `image`
  - define qual imagem será usada no container
* `container_name`
  - define um nome fixo para o container
* `ports`
  - faz o mapeamento de portas entre máquina local e container
* `depends_on`
  - indica que um service depende de outro para iniciar
* `environment`
  - define variáveis de ambiente dentro do container
* `volumes`
  - faz persistência de dados ou compartilhamento de arquivos
* `postgres-data:/var/lib/postgresql/data`
  - salva os dados do PostgreSQL em um volume
* `networks`
  - conecta os services na mesma rede
* `restart: always`
  - reinicia o container automaticamente se ele parar

## o que esse compose faz

* sobe uma aplicação Node.js
* sobe um banco PostgreSQL
* conecta os dois na mesma rede
* mantém os dados do banco salvos em volume
* permite acessar a aplicação na porta `3000` e o banco na porta `5432`
