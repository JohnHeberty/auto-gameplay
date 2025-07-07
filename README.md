# 🎮 Auto-GamePlay: Plataforma de Automação para Conteúdo Gaming

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/)
[![Docker](https://img.shields.io/badge/Docker-20.10+-blue.svg)](https://www.docker.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue.svg)](https://www.postgresql.org/)
[![Apache Airflow](https://img.shields.io/badge/Apache_Airflow-2.5+-red.svg)](https://airflow.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📋 Índice

- [🎯 Objetivo](#-objetivo)
- [🚀 Características Principais](#-características-principais)
- [🏗️ Estrutura do Projeto](#%EF%B8%8F-estrutura-do-projeto)
- [⚙️ Pipelines Implementados](#%EF%B8%8F-pipelines-implementados)
- [🛠️ Instalação e Configuração](#%EF%B8%8F-instalação-e-configuração)
- [📊 Banco de Dados](#-banco-de-dados)
- [🎮 Jogos Suportados](#-jogos-suportados)
- [🗺️ Roadmap](#%EF%B8%8F-roadmap)
- [📈 Análises Possíveis](#-análises-possíveis)
- [🤝 Contribuindo](#-contribuindo)

---

## 🎯 Objetivo

O **Auto-GamePlay** é uma plataforma completa de automação para **extração, processamento e análise** de dados de jogos competitivos. O projeto visa transformar replays de partidas (`.dem`, `.rofl`, etc.) em **conteúdo rico e automatizado** para múltiplos canais:

- 📺 **YouTube** com gameplays completas e highlights
- 📝 **Blogs** com análises táticas e estatísticas
- 📱 **Apps** com tendências e notícias automáticas
- 🎯 **APIs** para dados de partidas e estatísticas
- 💰 **Monetização** através de múltiplos formatos de conteúdo

---

## 🚀 Características Principais

### 🔧 Tecnologias Core
- **Python 3.11+** com pandas, psycopg2, typer
- **PostgreSQL** para armazenamento de dados
- **Apache Airflow** para orquestração de pipelines
- **Docker** para containerização
- **Java/Maven** para parsers de replay
- **YouTube API** para extração de dados

### 📊 Processamento de Dados
- **ETL Pipelines** automatizados
- **Extração de replays** (.dem, .rofl)
- **Análise de estatísticas** de jogadores/times
- **Backup automático** do banco de dados
- **Jupyter Notebooks** para análise interativa

### 🎮 Suporte Multi-Jogos
- **Dota 2** (implementado)
- **CS:GO** (estrutura preparada)
- **League of Legends** (estrutura preparada)
- **Arquitetura modular** para novos jogos

---

## 🏗️ Estrutura do Projeto

```
auto-gameplay/
├── 📁 src/                           # Código fonte principal
│   ├── 📁 constants/                 # Constantes dos jogos
│   │   └── 📁 games/                 # Dados por jogo (dota2, csgo, lol)
│   ├── � data/                      # Dados e backups
│   │   ├── 📁 DB/pgbackups/          # Backups PostgreSQL
│   │   ├── 📁 processed/             # Dados processados
│   │   ├── 📁 external/              # Dados externos
│   │   └── 📁 interim/               # Dados intermediários
│   ├── 📁 modules/                   # Módulos Python
│   │   ├── 📁 database/              # Gerenciamento de BD
│   │   ├── 📁 youtube/               # Extração YouTube
│   │   ├── 📁 downloader/            # Downloads
│   │   └── 📁 extractor/             # Extração de dados
│   ├── 📁 services/                  # Serviços especializados
│   │   ├── 📁 parser/                # Parsers de replay
│   │   │   ├── 📁 dota2/             # Parser Dota 2 (Java)
│   │   │   ├── 📁 csgo/              # Parser CS:GO
│   │   │   └── 📁 lol/               # Parser LoL
│   │   ├── 📁 youtube/               # Serviços YouTube
│   │   ├── 📁 docling/               # Processamento docs
│   │   └── � recorder/              # Gravação de tela
│   ├── 📁 repository/                # Queries SQL
│   │   └── 📁 querys/
│   │       ├── 📁 init/create/       # Criação de tabelas
│   │       └── 📁 operation/         # Operações SQL
│   ├── 📁 notebooks/                 # Jupyter Notebooks
│   │   ├── 📄 1-channel_register.ipynb
│   │   ├── 📄 2-register_playlist.ipynb
│   │   ├── 📄 3-register_video.ipynb
│   │   ├── 📄 4-channel_register_video_historic.ipynb
│   │   └── 📄 5-update_constants_dota2.ipynb
│   ├── 📁 scripts/                   # Scripts utilitários
│   │   └── 📄 restore_db.sh
│   └── 📁 docs/                      # Documentação
│       └── 📁 ideia/
│           └── 📄 README_PIPELINES.md
├── 📄 docker-compose.yaml            # Airflow + Redis
├── 📄 src/compose.yaml               # PostgreSQL + PgAdmin
├── 📄 Dockerfile                     # Container principal
└── 📄 README.md                      # Este arquivo
```

---

## ⚙️ Pipelines Implementados

### 🎯 Pipeline de Extração YouTube
- **Registro de Canais** (`1-channel_register.ipynb`)
- **Extração de Playlists** (`2-register_playlist.ipynb`)
- **Catalogação de Vídeos** (`3-register_video.ipynb`)
- **Histórico de Canais** (`4-channel_register_video_historic.ipynb`)

### 🎮 Pipeline Dota 2
- **Atualização de Constantes** (`5-update_constants_dota2.ipynb`)
- **Extração de Heróis** com imagens e estatísticas
- **Extração de Itens** com dados atualizados
- **Parser de Replays** (.dem files)
- **Análise de Partidas** profissionais

### 🗄️ Pipeline de Dados
- **Backup Automático** diário do PostgreSQL
- **Migração de Esquemas** SQL seguras
- **Controle de Versão** do banco
- **Limpeza de Dados** duplicados

---

## �️ Instalação e Configuração

### 📋 Pré-requisitos
- Docker & Docker Compose
- Python 3.11+
- Java 8+ (para parsers)
- Git

### 🚀 Instalação Rápida

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/auto-gameplay.git
cd auto-gameplay
```

2. **Configure as variáveis de ambiente**
```bash
cp src/.env.example src/.env
# Edite src/.env com suas configurações
```

3. **Inicie os serviços**
```bash
# PostgreSQL + PgAdmin
cd src
docker-compose up -d

# Airflow (opcional)
cd ..
docker-compose up -d
```

4. **Execute os notebooks**
```bash
# Acesse Jupyter em http://localhost:8888
# Ou use VS Code com extensão Python
```

### 🔧 Configuração Detalhada

#### 1. Dota 2 Setup
```bash
# Atualizar constantes
cd src/constants/games/
git clone --depth 1 https://github.com/odota/dotaconstants.git dota2
cd dota2 && rm -rf .git
```

#### 2. Parser de Replays
```bash
# Subir parser Dota 2
cd src/services/parser/dota2
docker-compose up --build -d
```

#### 3. Acesso aos Serviços
- **PgAdmin**: http://localhost:5050 (admin@admin.com / admin)
- **Airflow**: http://localhost:8080 (admin / admin)
- **Parser Dota 2**: http://localhost:5600

---

## 📊 Banco de Dados

### 🗂️ Estrutura Principal
- **GAMES** - Jogos suportados
- **CHANNELS** - Canais do YouTube
- **PLAYLISTS** - Playlists organizadas
- **HEROES** - Heróis/personagens
- **ITEMS** - Itens do jogo
- **PROPLAYERS** - Jogadores profissionais
- **TEAMS** - Times/organizações
- **GAME_VERSIONS** - Versões do jogo

### 🔒 Backup e Restore
```bash
# Backup automático (diário)
docker exec auto-gameplay-backup /bin/bash

# Restore manual
cd src/scripts
./restore_db.sh
```

---

## 🎮 Jogos Suportados

### ✅ Dota 2 (Implementado)
- ✅ Parser de replays (.dem)
- ✅ Extração de heróis e itens
- ✅ Análise de partidas
- ✅ Integração com OpenDota

### 🚧 CS:GO (Em Desenvolvimento)
- 🔄 Estrutura de dados
- 🔄 Parser básico
- ⏳ Extração de mapas/armas

### 🚧 League of Legends (Planejado)
- 📋 Estrutura preparada
- 📋 Riot API integration
- 📋 Parser .rofl files

---

## 🗺️ Roadmap

### 🎯 Fase 1: Consolidação (Q1 2025)
- [x] Estrutura básica do projeto
- [x] Pipeline Dota 2 completo
- [x] Banco de dados PostgreSQL
- [x] Sistema de backup
- [ ] Documentação completa
- [ ] Testes automatizados

### 🎯 Fase 2: Expansão (Q2 2025)
- [ ] Pipeline CS:GO
- [ ] API REST para dados
- [ ] Dashboard web
- [ ] Integração com Airflow
- [ ] CI/CD Pipeline

### 🎯 Fase 3: Inteligência (Q3 2025)
- [ ] Análise de IA com LLMs
- [ ] Detecção de momentos épicos
- [ ] Geração automática de highlights
- [ ] Narração automática (TTS)
- [ ] Classificação de estratégias

### 🎯 Fase 4: Monetização (Q4 2025)
- [ ] Publicação automática YouTube
- [ ] Geração de blogs
- [ ] App mobile
- [ ] API comercial
- [ ] Cursos e e-books

---

## 📈 Análises Possíveis

### 📊 Análises Básicas
- **Estatísticas de Jogadores**: KDA, GPM, XPM, farm efficiency
- **Meta Analysis**: Heróis mais picados, itens populares
- **Trends Timeline**: Evolução do meta por patch
- **Team Performance**: Análise de times profissionais

### 🧠 Análises Avançadas
- **Heatmaps de Posicionamento**: Onde jogadores ficam no mapa
- **Análise de Builds**: Sequência ótima de itens
- **Detecção de Padrões**: Estratégias recorrentes
- **Previsão de Resultados**: ML para prever vencedores

### 📈 Análises de Negócio
- **ROI de Conteúdo**: Qual tipo de vídeo gera mais views
- **Análise de Audiência**: Perfil dos espectadores
- **Trending Topics**: Temas em alta na comunidade
- **Monetização**: Otimização de ads e patrocínios

### 🎯 Análises Específicas por Jogo

#### Dota 2
- **Draft Analysis**: Combinações de heróis
- **Timings**: Momentos-chave das partidas
- **Roshan Analysis**: Controle do Roshan
- **Ward Placement**: Estratégias de visão

#### CS:GO (Futuro)
- **Aim Analysis**: Precisão dos jogadores
- **Map Control**: Controle territorial
- **Economy Management**: Gestão financeira
- **Clutch Situations**: Situações 1vX

---

## 🤝 Contribuindo

### 💡 Como Contribuir
1. **Fork** o repositório
2. **Crie** uma branch para sua feature
3. **Commit** suas mudanças
4. **Push** para a branch
5. **Abra** um Pull Request

### 🐛 Reportando Bugs
- Use as **GitHub Issues**
- Inclua logs e prints
- Descreva o ambiente

### 🚀 Sugerindo Features
- Abra uma **Issue** com label "enhancement"
- Descreva o caso de uso
- Proponha a implementação

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

---

## 🙏 Agradecimentos

- **OpenDota** pela API e parsers
- **YouTube API** pela extração de dados
- **Valve** pelos jogos incríveis
- **Comunidade** gaming pelo feedback

---

<div align="center">

### 🚀 Pronto para automatizar seu conteúdo gaming?

[📚 Documentação](src/docs/) • [🐛 Issues](https://github.com/seu-usuario/auto-gameplay/issues) • [💬 Discussões](https://github.com/seu-usuario/auto-gameplay/discussions)

</div>
