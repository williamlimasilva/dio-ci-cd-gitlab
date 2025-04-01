# Desafio: Pipeline de Criação e Execução de uma Imagem Docker

## Visão Geral

Este desafio consistiu na criação de um pipeline de CI/CD no GitLab para automatizar a construção e implantação de uma imagem Docker contendo um template de website. O objetivo foi demonstrar a capacidade de orquestrar a criação de uma imagem Docker e sua execução em um ambiente de nuvem utilizando o GitLab CI/CD e um GitLab Runner na Google Cloud Platform (GCP).

## Arquitetura

A arquitetura do projeto é relativamente simples, mas demonstra um fluxo de CI/CD completo:

1. **Código Fonte:** O código fonte do website (template HTML, CSS, JavaScript) reside no repositório GitLab, na pasta `app/`.
2. **Dockerfile:** Um `Dockerfile` define as etapas para construir a imagem Docker a partir do código fonte. Ele utiliza Apache como base para servir o website estático.
3. **GitLab CI/CD:** O arquivo `.gitlab-ci.yml` define o pipeline de CI/CD, que consiste em duas stages principais:
   - **Build:** Constrói a imagem Docker e a envia para o Docker Hub.
   - **Deploy:** Executa a imagem Docker em um servidor na nuvem, expondo o serviço na porta 8080.
4. **GitLab Runner:** Um GitLab Runner (configurado em um servidor GCP) executa as jobs definidas no pipeline.
5. **Servidor na Nuvem:** O servidor GCP hospeda o GitLab Runner e executa a imagem Docker, tornando o website acessível.

## Árvore de Diretórios

```
.
├── .gitlab-ci.yml          # Arquivo de configuração do GitLab CI/CD
├── README.md               # Documentação do projeto
└── app/                    # Diretório contendo os arquivos do template web
    ├── Dockerfile          # Instruções para a criação da imagem Docker
    ├── demo.html           # Página de demonstração do template
    ├── index.html          # Página principal do template
    ├── css/                # Arquivos CSS
    ├── images/             # Imagens
    ├── inc/                # Scripts PHP (e.g., sendEmail.php)
    └── js/                 # Arquivos JavaScript (init.js)
```

## Design Patterns

Embora este projeto seja relativamente simples, alguns princípios de design podem ser observados:

- **Infrastructure as Code (IaC):** O `Dockerfile` e o `.gitlab-ci.yml` representam IaC, pois definem a infraestrutura (o ambiente do container e o pipeline de CI/CD) como código.
- **Continuous Integration/Continuous Deployment (CI/CD):** O pipeline automatiza o processo de build e deploy, o que é um princípio fundamental de CI/CD.
- **Container Pattern:** Utiliza containers Docker para empacotar a aplicação e suas dependências, garantindo consistência em diferentes ambientes.
- **Pipeline Pattern:** Implementa um fluxo de trabalho automatizado dividido em estágios sequenciais.

## Configuração do Pipeline (.gitlab-ci.yml)

```yaml
stages:
  - build
  - deploy

create:
  stage: build
  tags:
    - gcp
  script:
    - cd "desafios/desafio1/Pipeline de Criação e Execução de uma Imagem Docker"
    - docker build -t williamlimasilva/gcp-runner-challenge-alpha:1.0 app/.
    - docker push williamlimasilva/gcp-runner-challenge-alpha:1.0

execute:
  stage: deploy
  needs:
    - create
  tags:
    - gcp
  script:
    - docker run -dti --name web-server-alpha -p 8080:8080 williamlimasilva/gcp-runner-challenge-alpha:1.0
```

**Explicação:**

- **stages:** Define as stages do pipeline (build e deploy).
- **create (job build):**
  - Utiliza a tag `gcp` para executar em um runner específico.
  - Navega até o diretório do projeto.
  - Constrói a imagem Docker com a tag `williamlimasilva/gcp-runner-challenge-alpha:1.0`.
  - Envia a imagem para o Docker Hub.
- **execute (job deploy):**
  - Depende do job `create` para garantir a ordem correta.
  - Executa a imagem Docker na porta 8080.
  - Nomeia o container como `web-server-alpha`.

## Implementação

### 1. Template Web

Utilizei um template web responsivo chamado "CeeVee", que inclui várias seções como:

- Página inicial com banner
- Seção sobre o perfil
- Resumo/CV
- Portfólio
- Testemunhos
- Formulário de contato

O template utiliza jQuery e diversos plugins para proporcionar uma experiência de usuário fluida.

### 2. Dockerfile

```dockerfile
FROM httpd:latest
WORKDIR /usr/local/apache2/htdocs/
COPY . /usr/local/apache2/htdocs/
EXPOSE 8080
```

Este Dockerfile simples:

- Utiliza a imagem oficial do Apache como base
- Copia todos os arquivos do website para o diretório padrão do Apache
- Expõe a porta 8080 para acesso externo

### 3. Configuração do GitLab Runner

Para este projeto, configurei um GitLab Runner na GCP com a tag `gcp`, permitindo que os jobs do pipeline sejam executados na infraestrutura da nuvem.

## Desafios e Lições Aprendidas

- **Configuração do GitLab Runner:** A configuração e manutenção do GitLab Runner na GCP exigiu um bom entendimento de networking, permissões e configuração de containers.
- **Docker Registry:** Utilizei o Docker Hub como registry, o que exigiu a configuração de credenciais seguras.
- **Persistência de Containers:** O job de execução cria um novo container a cada execução, o que pode levar a problemas se um container existente já estiver utilizando a porta 8080.

## Melhorias Futuras

- **Variáveis de Ambiente:** Refatorar o pipeline para utilizar variáveis do GitLab em vez de valores hardcoded.
- **Testes Automatizados:** Adicionar uma stage de teste para verificar a integridade do website.
- **Limpeza de Recursos:** Implementar um job para remover containers antigos antes de criar novos.
- **CI/CD para Múltiplos Ambientes:** Expandir o pipeline para suportar ambientes de desenvolvimento, staging e produção.
- **Monitoramento:** Adicionar ferramentas de monitoramento para acompanhar o desempenho e disponibilidade do website.

## Conclusão

Este projeto demonstrou a implementação de um pipeline CI/CD completo para a criação e execução de uma imagem Docker contendo um website estático. A utilização do GitLab CI/CD em conjunto com um runner na GCP permitiu a automação completa do processo, desde o código fonte até a disponibilização da aplicação em um ambiente de nuvem.

A implementação seguiu boas práticas de DevOps, como Infrastructure as Code e automação, resultando em um processo de delivery confiável e repetível.
