🚀 Projeto de Infraestrutura EKS na AWS com Terraform
Este repositório provisiona um cluster Amazon Elastic Kubernetes Service (EKS), incluindo a Virtual Private Cloud (VPC) e todos os recursos de IAM (Identity and Access Management) necessários para a operação, além da configuração do AWS Load Balancer Controller usando o IRSA (IAM Roles for Service Accounts).



🎯 Visão Geral da Arquitetura
Este projeto provisiona:

Networking (VPC): Uma VPC dedicada com 2 subnets públicas e 2 subnets privadas.

EKS Control Plane: O cluster Kubernetes gerenciado pela AWS.

EKS Managed Node Group (MNG): Um grupo de nós EC2 de trabalho.

IRSA para Load Balancer Controller: Configuração de IAM Role e Service Account (SA) para permitir que o AWS Load Balancer Controller provisione ALBs/NLBs.

OIDC Provider: Provedor de Identidade OpenID Connect para segurança do IRSA.






📁 Estrutura do Projeto (Recomendada)O projeto segue uma estrutura modular para garantir a reutilização e a separação de preocupações..
├── addons/
│   └── alb-controller/  # Módulo IRSA e SA para o Load Balancer
├── modules/
│   ├── eks-cluster/     # Módulo para o Control Plane e Node Groups
│   └── vpc/             # Módulo para VPC, Subnets e NAT Gateways
├── main.tf              # Orquestrador (Chama os módulos)
├── variables.tf         # Variáveis globais
├── outputs.tf           # Saídas da infraestrutura
└── README.md            # Este arquivo


✅ Pré-requisitos
Para executar este projeto, você precisa ter o seguinte instalado e configurado:

AWS CLI: Configurado com credenciais de acesso programático.

Terraform: Versão ~> 1.0 (ou superior).

kubectl: Para interagir com o cluster EKS após a implantação.

1. Inicialização
Acesse o diretório raiz do projeto e inicialize o Terraform.

Bash

terraform init

2. Validação e PlanejamentoExecute a validação para verificar a sintaxe e o plano para ver as mudanças a serem aplicadas.Bashterraform validate

Bash

terraform validate
terraform plan


3. Aplicação

Aplique as mudanças para provisionar a VPC, o EKS Cluster e o IAM.

Bash

terraform apply --auto-approve



🔌 Uso do Cluster

Após a aplicação bem-sucedida, configure o kubectl para se conectar ao seu novo cluster EKS.Obtenha o Nome do Cluster: O nome pode ser encontrado na saída do Terraform, mas é referenciado pela variável var.eks_cluster_name.Configure o kubeconfig:Bashaws eks update-kubeconfig --name $(terraform output -raw eks_cluster_name) --region us-east-1
Verifique a Conexão:Bashkubectl get svc
kubectl get nodes


🗑️ Limpeza (Destroy)

Para remover toda a infraestrutura provisionada e evitar custos contínuos:🚨 Aviso: Certifique-se de que não há Load Balancers ou Pods externos rodando no cluster que possam impedir o processo de destruição.Bashterraform destroy --auto-approve


🧩 Parâmetros Chave (variáveis.tf)


Os principais parâmetros de configuração estão em variables.tf:VariávelTipoPadrãoDescriçãoproject_namestring"EKS-Project"Prefixo de nome para todos os recursos (Tags).eks_cluster_namestring"cluster-eks-lab-dev"Nome do Cluster EKS.cidr_blockstring"10.0.0.0/16"Bloco CIDR da VPC.