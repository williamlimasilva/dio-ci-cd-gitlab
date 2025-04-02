# Criando um Pipeline de Deploy de uma Aplicação Utilizando GitLab, Docker e Kubernetes

## Visão Geral

Este projeto é um desafio prático que demonstra a implementação de um pipeline completo de CI/CD (Continuous Integration/Continuous Deployment) para uma aplicação Node.js usando GitLab, Docker e Kubernetes. O objetivo principal é automatizar todo o processo de teste, compilação e implantação da aplicação em um ambiente de produção com alta disponibilidade.

O pipeline implementado segue as melhores práticas de DevOps, garantindo que cada mudança no código seja testada, empacotada e implantada de forma automatizada e confiável.

## Arquitetura

A arquitetura deste projeto é baseada em microserviços e contêineres, facilitando a escalabilidade, manutenção e implementação da aplicação. O sistema utiliza:

- **GitLab CI/CD**: Orquestração do pipeline de entrega contínua
- **Docker**: Containerização da aplicação
- **Kubernetes**: Orquestração de contêineres para implantação e gerenciamento
- **Node.js**: Tecnologia backend para a aplicação web

O fluxo de trabalho é estruturado da seguinte forma:

1. **Desenvolvimento**: Os desenvolvedores fazem alterações e enviam para o repositório GitLab
2. **Integração**: O GitLab CI/CD detecta as alterações e inicia o pipeline
3. **Teste**: Execução de testes automatizados para validar a qualidade do código
4. **Build**: Criação da imagem Docker com a aplicação
5. **Deploy**: Implantação da imagem no ambiente Kubernetes

## Árvore de Diretórios

```
.
├── .gitlab-ci.yml           # Configuração do pipeline GitLab CI/CD
├── .gitignore               # Arquivos e diretórios a serem ignorados pelo Git
├── README.md                # Documentação do projeto
└── app/                     # Diretório da aplicação
    ├── dockerfile           # Instruções para criar a imagem Docker
    ├── index.html           # Página principal da aplicação
    ├── package.json         # Dependências e scripts do Node.js
    └── node_modules/        # Bibliotecas e dependências (ignorado pelo Git)
```

## Tecnologias Utilizadas

### Desenvolvimento

- **Node.js**: Runtime JavaScript para execução da aplicação backend
- **HTML/CSS/JavaScript**: Tecnologias frontend para a interface do usuário

### DevOps e Infraestrutura

- **GitLab**: Plataforma de desenvolvimento colaborativo e CI/CD
- **Docker**: Plataforma para desenvolvimento, envio e execução de aplicações em contêineres
- **Kubernetes**: Sistema de orquestração de contêineres para automação de implantação, escalonamento e gerenciamento
- **Alpine Linux**: Distribuição Linux leve usada como base para contêineres

## Design Patterns e Modelos de Engenharia

### Padrões de Arquitetura

- **Microserviços**: Separação de responsabilidades em serviços independentes
- **Containerização**: Isolamento de aplicações e suas dependências
- **Infrastructure as Code (IaC)**: Definição da infraestrutura através de arquivos de configuração
- **Continuous Integration/Continuous Deployment (CI/CD)**: Automação do processo de entrega de software

### Padrões de DevOps

- **Pipeline as Code**: Definição do processo de CI/CD como código no arquivo `.gitlab-ci.yml`
- **Immutable Infrastructure**: Infraestrutura tratada como imutável, substituindo instâncias ao invés de modificá-las
- **Shift Left Testing**: Testes realizados mais cedo no ciclo de desenvolvimento
- **Ambiente Efêmero**: Criação e destruição automatizada de ambientes conforme necessidade

## Pipeline CI/CD (GitLab)

O pipeline implementado no arquivo `.gitlab-ci.yml` consiste em três estágios principais:

### 1. Estágio de Teste (`test`)

- Utiliza a imagem `node:17-alpine3.14`
- Executa testes automatizados na aplicação
- Gera relatórios de testes no formato JUnit
- Armazena os resultados dos testes como artefatos

### 2. Estágio de Build (`build`)

- Utiliza a imagem `docker:20.10.16` e Docker-in-Docker (DinD)
- Faz login no Docker Registry usando variáveis de ambiente seguras
- Cria uma imagem Docker da aplicação
- Publica a imagem em um repositório Docker (Docker Hub)

### 3. Estágio de Deploy (`deploy`)

- Utiliza executores com a tag `gcp` (Google Cloud Platform)
- Baixa a imagem Docker criada no estágio anterior
- Interrompe e remove contêineres existentes
- Implanta a nova versão da aplicação

## Segurança

O projeto implementa várias práticas de segurança:

- Credenciais armazenadas como variáveis de ambiente seguras do GitLab
- Uso de imagens base mínimas (Alpine) para reduzir a superfície de ataque
- Controle de acesso para o registro Docker e o cluster Kubernetes

## Desafios e Lições Aprendidas

Durante o desenvolvimento deste projeto, enfrentamos e superamos vários desafios:

- Configuração do ambiente Kubernetes e integração com o GitLab
- Otimização do tamanho e segurança das imagens Docker
- Gerenciamento de dependências e versões
- Configuração de executores específicos para diferentes estágios do pipeline

## Conclusão

Este projeto demonstra a implementação bem-sucedida de um pipeline completo de CI/CD usando GitLab, Docker e Kubernetes. As tecnologias e práticas utilizadas representam o estado da arte em DevOps e desenvolvimento de software moderno.

A automação do pipeline permite entregas mais rápidas, confiáveis e seguras, reduzindo erros humanos e aumentando a produtividade da equipe. A infraestrutura baseada em contêineres facilita a escalabilidade e a portabilidade da aplicação entre diferentes ambientes.

## Próximos Passos

Melhorias futuras que podem ser implementadas:

- Múltiplos ambientes (desenvolvimento, homologação, produção)
- Estratégias de implantação avançadas (blue-green, canary)
- Monitoramento e observabilidade com Prometheus e Grafana
- Integração com ferramentas de segurança e análise de código estático
