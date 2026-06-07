
O terraform é uma ferramenta para provisionar infraestrutura em diversos ambientes atráves de código.

Pontos positivos:
Multi cloud
Linguagem declarativa (HCL -> Hashicorp Configuration Language)
Gerenciamento de estado.

*Blocos* :
Terraform -> as configurações para rodar o terraform
Providers -> coloca as clouds que vão ser utilizadas no projetos
Variable -> define variáveis que vão ser utilizadas
Resource -> define o recurso que vai ser criado na cloud
Locals -> variaveis internas
Data -> link entre resources
output -> pega informações geradas pela configuração
Module -> reutilização de recursos criados

## comandos do terraform

* `terraform init`
  - inicializa o diretório e baixa os providers
* `terraform fmt`
  - formata os arquivos `.tf` no padrão da HCL
* `terraform validate`
  - valida a sintaxe e a consistência da configuração
* `terraform plan`
  - mostra o que vai ser criado, alterado ou destruído sem aplicar
* `terraform apply`
  - aplica as mudanças e provisiona a infraestrutura
* `terraform destroy`
  - destrói toda a infraestrutura criada
* `terraform show`
  - mostra o estado atual da infraestrutura
* `terraform state list`
  - lista os recursos presentes no estado
* `terraform output`
  - mostra os valores definidos nos blocos `output`

## flags úteis

* `-auto-approve`
  - aplica/destrói sem pedir confirmação (ex.: `terraform apply -auto-approve`)
* `-var "nome=valor"`
  - passa uma variável direto pela linha de comando
* `-var-file="arquivo.tfvars"`
  - usa um arquivo específico de variáveis
* `-target=recurso`
  - aplica a mudança apenas em um recurso específico

## fluxo básico

* `terraform init` → `terraform plan` → `terraform apply`
* para remover tudo: `terraform destroy`

## arquivos comuns

* `main.tf` - recursos, provider e bloco terraform
* `variables.tf` - declaração das variáveis
* `outputs.tf` - valores de saída
* `terraform.tfvars` - valores atribuídos às variáveis
* `terraform.tfstate` - estado atual da infraestrutura (gerado automaticamente)

