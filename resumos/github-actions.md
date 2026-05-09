# CI/CD

## comandos

* name
  - define o nome do workflow
* run-name
  - nome mostrado no momento de execução

```yaml
name: Pipeline principal do projeto
run-name: Executada por ${{ github.actor }}
```

* on
  - trigger que acionará o workflow (push, pull_request...)
  - workflow_dispatch executado manualmente
* branches
  - branches que serão monitoradas pela trigger
* paths
  - caminhos que serão monitorados pela trigger
* paths-ignore
  - caminhos ignorados pela trigger
* inputs
  - serve para receber parametros no workflow
  - pode ser usado em `workflow_dispatch` e `workflow_call`
* workflow_run
  - executa um workflow quando outro workflow for executado ou concluido
* workflow_call
  - permite reutilizar um workflow e receber parametros

```yaml
on:
  push:
    branches: [ master ]
    paths:
      - "src/**"
      - ".github/workflows/**"
    paths-ignore:
      - "**.md"
      - "docs/**"
  workflow_dispatch:
    inputs:
      ambiente:
        description: "Ambiente do deploy"
        required: true
        default: "dev"
```

```yaml
on:
  workflow_run:
    workflows: [ "CI" ]
    types:
      - completed
```

```yaml
on:
  workflow_call:
    inputs:
      versao:
        required: true
        type: string
```

* jobs
  - agrupa as tarefas que o workflow vai executar
  - cada job roda em um runner
* runs-on
  - define em qual maquina o job sera executado
  - exemplo: `ubuntu-latest`
* if
  - define uma condicao para executar o job ou step
* steps
  - lista de etapas executadas dentro do job
* uses
  - usa uma action pronta ou um workflow reutilizavel
* with
  - envia parametros para `uses`
* environment
  - define o ambiente do job, como `dev`, `staging` ou `production`
* concurrency
  - evita execucoes simultaneas do mesmo grupo
* defaults
  - define valores padrao, como shell ou diretorio de trabalho

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/master'
    environment: production
    concurrency:
      group: deploy-production
      cancel-in-progress: true
    defaults:
      run:
        shell: bash
    steps:
      - name: Baixar codigo
        uses: actions/checkout@v4

      - name: Instalar Node
        uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Rodar testes
        run: npm test
```

## criar sua propria action

* action customizada
  - voce pode criar sua propria action dentro do repositorio
  - normalmente ela fica em `.github/actions/nome-da-action`
  - o arquivo principal da action e o `action.yml`

```yaml
name: "Minha action"
description: "Exemplo de action customizada"
inputs:
  mensagem:
    description: "Mensagem que sera exibida"
    required: true
runs:
  using: "composite"
  steps:
    - run: echo "Mensagem: ${{ inputs.mensagem }}"
      shell: bash
```

* para usar a action local:runs:
  using: "composite"
  steps:
    - run: echo "Mensagem: ${{ inputs.mensagem }}"
      shell: bash

```yaml
jobs:
  exemplo:
    runs-on: ubuntu-latest
    steps:
      - name: Baixar codigo
        uses: actions/checkout@v4

      - name: Chamar action local
        uses: ./.github/actions/minha-action
        with:
          mensagem: "Ola"
```

## criar um workflow e chamar depois

* workflow reutilizavel
  - e um workflow com `workflow_call`
  - ele pode receber `inputs`
  - outro workflow pode chamar esse arquivo com `uses`

```yaml
name: Workflow reutilizavel

on:
  workflow_call:
    inputs:
      ambiente:
        required: true
        type: string

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Exibir ambiente
        run: echo "Deploy no ambiente ${{ inputs.ambiente }}"
```

* para chamar esse workflow:

```yaml
name: Chamar workflow reutilizavel

on:
  workflow_dispatch:

jobs:
  usar-workflow:
    uses: ./.github/workflows/deploy.yml
    with:
      ambiente: "prod"
```
