# resumo sobre git

## comandos pt1

* git config
  - serve para configurações básicas como nome e email do author dos commits e para criar alias
* git init
  - cria o repositorio localmente
* git status
  - verifica arquivos alterados e criados no diretorio de trabalho
* git add
  - adiciona arquivos na área de staging
* git commit -m ""
  - salva as alterações do stagging no histórico do repositório

## comandos pt2
* git reset --soft HEAD~1
  - volta o último commit, mantendo as alterações prontas para commit
* git rm -r --cached .
  - remove todos arquivos do staging sem apagar do computador
* git log
  - mostrar o histórico de commits do repositorio
  - -p nome_do_arquivo mostra o histórico de commits de um arquivo específico + as diferenças do que foi feito em cada commit
* git checkout 99f7c7fb3082937e85c706
  - serve para ir para um commit específico.
* git cherry-pick
  - serve para pegar um commit específico de outra branch e aplicar na sua branch atual.

## diferença entre merge e rebase
### git merge

* Junta duas branches criando um commit de merge
* Não reescreve histórico
* Mantém o histórico completo (com ramificações)
* Mais seguro para branches compartilhadas

👉 Resultado: histórico “em árvore”

### git rebase

* Move seus commits para cima de outra branch
* Reescreve o histórico
* Deixa o histórico linear e mais limpo
* Pode dar problema se usado em branch compartilhada

👉 Resultado: histórico “em linha reta”

## git rebase -i
O git rebase -i (rebase interativo) serve para editar, organizar e limpar commits antes de subir.

* pick → manter commit
* squash → juntar commits
* reword → mudar mensagem
* drop → remover commit
* edit → alterar conteúdo do commit

## gitflow
Gitflow é um modelo de organização de branches no Git para separar desenvolvimento, releases e correções.

### branches principais

* `main`
  - guarda a versão estável que está em produção
* `develop`
  - concentra o desenvolvimento do projeto

### branches de apoio

* `feature/*`
  - usadas para desenvolver novas funcionalidades
  - normalmente saem da `develop` e voltam para a `develop`
* `release/*`
  - usadas para preparar uma nova versão
  - servem para ajustes finais, testes e correções antes da entrega
  - saem da `develop` e depois voltam para `main` e `develop`
* `hotfix/*`
  - usadas para corrigir erros urgentes em produção
  - saem da `main` e depois voltam para `main` e `develop`

### fluxo básico

* cria uma `feature` a partir da `develop`
* finaliza a `feature` e faz merge na `develop`
* quando a versão estiver pronta, cria uma `release`
* finaliza a `release` e faz merge na `main` e na `develop`
* se houver bug urgente em produção, cria uma `hotfix` a partir da `main`
* finaliza a `hotfix` e faz merge na `main` e na `develop`

### vantagens

* organiza melhor times e versões
* separa novas funcionalidades de correções urgentes
* facilita o controle de releases

### desvantagens

* pode ser mais complexo para projetos pequenos
* gera mais branches e mais merges
* nem sempre é a melhor opção para times que fazem deploy contínuo

## tags
Tags são marcadores usados para identificar pontos importantes no histórico, geralmente versões do projeto, como `v1.0.0`.

* `git tag nome-da-tag`
  - cria uma tag simples no commit atual
* `git tag -a nome-da-tag -m "mensagem"`
  - cria uma tag anotada com mensagem
* `git tag`
  - lista as tags do repositório
* `git show nome-da-tag`
  - mostra informações da tag e do commit marcado
* `git push origin nome-da-tag`
  - envia uma tag específica para o repositório remoto
* `git push origin --tags`
  - envia todas as tags para o remoto

### uso das tags

* marcar versões estáveis
* facilitar releases
* localizar commits importantes no histórico

### tipos de tags

* lightweight
  - mais simples, funciona como um ponteiro para um commit
* annotated
  - guarda autor, data e mensagem
  - mais indicada para versionamento de releases
