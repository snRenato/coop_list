# 🧾 Coop List

[![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-8.x-red?logo=rubyonrails)](https://rubyonrails.org/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue?logo=docker)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Active-blue?logo=postgresql)](https://www.postgresql.org/)
[![RSpec](https://img.shields.io/badge/Tests-RSpec-green?logo=ruby)](https://rspec.info/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🧠 Sobre o Projeto

O **Coop List** é um sistema **colaborativo de criação e gerenciamento de listas**, desenvolvido em **Ruby on Rails**.  
Seu objetivo é permitir que **usuários criem listas compartilhadas**, adicionem itens e colaborem em tempo real — ideal para listas de compras, tarefas ou planejamento em grupo.

Este projeto foi desenvolvido como **trabalho de conclusão de curso da Pós-graduação em Desenvolvimento Web Full Stack**, aplicando boas práticas de desenvolvimento, testes automatizados e containerização com Docker.

---

## 🚀 Tecnologias Utilizadas

| Categoria | Tecnologias |
|------------|--------------|
| **Linguagem** | Ruby 3.x |
| **Framework** | Ruby on Rails 8.x |
| **Frontend** | Hotwire (Turbo + Stimulus), TailwindCSS |
| **Banco de Dados** | PostgreSQL |
| **Containerização** | Docker e Docker Compose |
| **Autenticação** | Devise |
| **Autorização** | Pundit |
| **Testes Automatizados** | RSpec |
| **Versionamento** | Git e GitHub |

---

## 🧩 Funcionalidades

- 👥 **Cadastro e autenticação de usuários**
- 🗒️ **Criação e gerenciamento de listas**
- 🤝 **Compartilhamento de listas com outros membros**
- 🔍 **Filtros e pesquisa**
- 📱 **Design responsivo e moderno (TailwindCSS)**
- 🧪 **Testes automatizados com RSpec**

---

## 🐳 Execução com Docker

> 💡 **Não é necessário instalar Ruby, Rails ou PostgreSQL.**  
> O ambiente é totalmente automatizado via Docker.

### 🧰 Pré-requisitos

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)

### 🧱 Passos para execução

1. **Clonar o repositório**
   ```bash
   git clone https://github.com/snRenato/coop_list.git
   cd coop_list

    Subir os containers

docker-compose up --build

Criar e migrar o banco de dados

docker-compose exec web rails db:create db:migrate

(Opcional) Popular com dados de exemplo

docker-compose exec web rails db:seed

Acessar o sistema

    http://localhost:3000

🧪 Executando Testes Automatizados

Após implementar os testes com RSpec, eles podem ser executados via Docker:

docker-compose exec web bundle exec rspec

    Os testes verificam o funcionamento correto dos modelos, controladores e fluxos principais da aplicação.

🧱 Estrutura do Projeto

<img width="436" height="250" alt="image" src="https://github.com/user-attachments/assets/41a7a3b3-3e1e-4365-ac4d-117b6534c8c3" />


📚 Contexto Acadêmico

Este projeto foi desenvolvido como parte do Trabalho de Conclusão da Pós-Graduação em Desenvolvimento Web Full Stack, com foco em:

    Desenvolvimento full stack com Ruby on Rails

    Arquitetura MVC e boas práticas de código

    Testes automatizados e qualidade de software

    Containerização e portabilidade com Docker

    Integração entre frontend e backend (Hotwire + Tailwind)

    Metodologias ágeis

Renato Souza Neto
📚 Pós-graduação em Desenvolvimento Web Full Stack


Este projeto está licenciado sob a MIT License.
Consulte o arquivo LICENSE
para mais detalhes.
