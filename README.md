<p align="center">
  <img src="https://i.imgur.com/v2u5nP9.png" alt="CoopList Logo" width="480">
</p>

<h1 align="center">🧾 Coop List</h1>

<p align="center">
  <a href="https://rubyonrails.org/"><img src="https://img.shields.io/badge/Ruby%20on%20Rails-8.x-red?logo=rubyonrails"></a>
  <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-Enabled-blue?logo=docker"></a>
  <a href="https://www.postgresql.org/"><img src="https://img.shields.io/badge/PostgreSQL-Active-blue?logo=postgresql"></a>
  <a href="https://rspec.info/"><img src="https://img.shields.io/badge/Tests-RSpec-green?logo=ruby"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
</p>

---

### 🧭 Índice

- [🧠 Sobre o Projeto](#sobre-o-projeto)
- [🚀 Tecnologias Utilizadas](#tecnologias-utilizadas)
- [🧩 Funcionalidades](#funcionalidades)
- [🐳 Execução com Docker](#execucao-com-docker)
  - [🧰 Pré-requisitos](#pre-requisitos)
  - [🧱 Passos para execução](#passos-para-execucao)
- [🧪 Testes Automatizados](#testes-automatizados)
- [🧱 Estrutura do Projeto](#estrutura-do-projeto)
- [🎓 Contexto Acadêmico](#contexto-academico)
- [👨‍💻 Autor](#autor)

## 🧠 Sobre o Projeto

O **Coop List** é uma aplicação **colaborativa de gerenciamento de listas**, desenvolvida com **Ruby on Rails 8**.  
Ela permite que **usuários criem listas compartilhadas**, adicionem itens e colaborem em tempo real — ideal para tarefas, listas de compras ou planejamentos coletivos.

> 🎓 Desenvolvido como **Trabalho de Conclusão de Curso (TCC)** da **Pós-Graduação em Desenvolvimento Web Full Stack**, este projeto integra conceitos de arquitetura moderna, testes automatizados e containerização com Docker.

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
| **URLs Amigáveis** | FriendlyId |
| **Testes Automatizados** | RSpec |
| **Versionamento** | Git e GitHub |

---

## 🧩 Funcionalidades

- 👥 **Cadastro e autenticação de usuários (Devise)**
- 🗒️ **Criação e edição de listas com URLs amigáveis (FriendlyId)**
- 🤝 **Convite e gerenciamento de membros**
- 📦 **Adição e controle de itens em tempo real com Hotwire**
- 🔐 **Autorização de ações com Pundit**
- 🎨 **Interface responsiva e moderna (TailwindCSS)**
- 🧪 **Testes automatizados com RSpec**
- 🐳 **Execução completa via Docker (sem dependências locais)**

---

## 🐳 Execução com Docker

> 💡 **Não é necessário instalar Ruby, Rails ou PostgreSQL.**  
> Todo o ambiente é gerenciado via Docker.

### 🧰 Pré-requisitos

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/)

---

### 🧱 Passos para execução

1. **Clonar o repositório**
   ```bash
   git clone https://github.com/snRenato/coop_list.git
   cd coop_list
2. **Clonar o repositório**
   ```bash
   docker compose up --build
3. **(Opcional) Rodar os testes automatizados**
   ```bash
   docker compose exec web bundle exec rspec

4. **Acessar o sistema**
   ```bash
   http://localhost:3000

### 🧪 Testes Automatizados

Os testes garantem o funcionamento correto de **modelos**, **controladores**, **políticas** e **fluxos principais** da aplicação.


🔍 **Cobertura de Testes (RSpec):**

- [x] Regras de negócio
- [x] Autenticação e autorização
- [x] Comportamento dos componentes Hotwire (Turbo + Stimulus)

## 🧱 Estrutura do Projeto

```text
coop_list/
├── app/
│   ├── controllers/      → Lógica das rotas e regras de acesso
│   ├── models/           → Regras de negócio (ActiveRecord)
│   ├── views/            → Interfaces com Hotwire + Tailwind
│   └── policies/         → Autorização (Pundit)
├── config/               → Configurações do Rails e Docker
├── db/                   → Migrações e seeds
├── spec/                 → Testes RSpec
└── Dockerfile / docker-compose.yml
---
```

## 🎓 Contexto Acadêmico

Este projeto foi desenvolvido como parte do Trabalho de Conclusão da Pós-Graduação em Desenvolvimento Web Full Stack, com foco em:

* Desenvolvimento full stack com Ruby on Rails
* Arquitetura MVC e boas práticas de código
* Testes automatizados e qualidade de software
* Containerização e portabilidade com Docker
* Integração frontend/backend (Hotwire + TailwindCSS)
* Metodologias ágeis e versionamento com Git

---

## 👨‍💻 Autor

Renato Souza Neto
📚 Pós-graduação em Desenvolvimento Web Full Stack 
   