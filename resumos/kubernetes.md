# resumo sobre kubernetes

## resumo breve

Kubernetes é uma plataforma para gerenciar containers em vários servidores.

Ele serve para:

* subir aplicações em containers
* manter o número certo de réplicas rodando
* reiniciar containers com problema
* distribuir o tráfego entre as instâncias
* facilitar deploy, escalabilidade e atualização das aplicações

Em vez de administrar container por container, o Kubernetes trabalha com objetos declarativos, onde você descreve o estado desejado e ele tenta manter esse estado sempre ativo.

## pod

* Pod é a menor unidade do Kubernetes
* normalmente representa um ou mais containers que compartilham rede e armazenamento
* os containers do mesmo Pod compartilham o mesmo IP e podem se comunicar por localhost
* quando um Pod morre, ele pode ser recriado, mas com novo endereço

### resumo do pod

* pense no Pod como uma caixa onde um ou mais containers vivem juntos
* ele não é o container em si, mas o ambiente que executa o container

## replicaset

* ReplicaSet garante que um número específico de Pods esteja sempre rodando
* se um Pod cair, ele cria outro no lugar
* se houver Pods demais, ele remove os excedentes
* normalmente não se usa ReplicaSet direto em projetos comuns, porque o Deployment cuida disso

### resumo do replicaset

* serve para manter a quantidade certa de réplicas
* garante alta disponibilidade básica da aplicação

## deployment

* Deployment gerencia atualizações de Pods e ReplicaSets
* é o recurso mais usado para subir aplicações
* permite atualizar imagem, fazer rollback e controlar estratégia de deploy
* ele cria e administra ReplicaSets para você

### resumo do deployment

* use Deployment quando quiser versionar e atualizar sua aplicação com controle
* ele é a forma mais prática de gerenciar Pods em produção

## service

* Service cria um ponto de acesso estável para um conjunto de Pods
* como Pods podem morrer e nascer com novos IPs, o Service evita que o acesso quebre
* ele faz balanceamento de carga entre os Pods que seleciona

### tipos comuns de service

* ClusterIP
	- acessivel somente dentro do cluster
* NodePort
	- expoe uma porta fixa em cada no do cluster
* LoadBalancer
	- expoe o service usando um balanceador externo, comum em cloud

### resumo do service

* o Service é a porta de entrada estável para os Pods
* ele resolve o problema de IP dinâmico dos Pods

## ingress

* Ingress controla acesso HTTP e HTTPS para services do cluster
* permite rotear pedidos por domínio, caminho ou regra
* normalmente trabalha junto com um Ingress Controller
* é usado para expor várias aplicações com um único ponto de entrada

### resumo do ingress

* use Ingress quando quiser acesso externo organizado por domínio ou rota
* ele é mais flexível que expor vários NodePorts manualmente

## relacao entre eles

* Pod executa o container
* ReplicaSet garante quantidade de Pods
* Deployment gerencia atualizações e réplicas
* Service expõe e balanceia o acesso aos Pods
* Ingress organiza o acesso externo via HTTP/HTTPS

## fluxo simples

* você cria um Deployment
* o Deployment cria ReplicaSets
* os ReplicaSets mantêm os Pods rodando
* o Service aponta para os Pods
* o Ingress expõe o Service para fora do cluster
