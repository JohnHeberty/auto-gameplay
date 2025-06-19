# 🎮 auto-gameplay

## 💡 IDEIA PRINCIPAL

Para **cada jogo** a ser abordado, a estrutura se repete com foco em monetização e conteúdo automatizado:

1. 📺 Canal no **YouTube** com gameplays completas dos melhores jogadores.  
2. ✂️ Canal de **Highlights** com os melhores momentos das gameplays acima.  
3. 🛡️ Canal de **Top Builds** com análise tática e estratégica dos destaques.  
4. 📝 Criação de **Blog** com vídeos e postagens integradas dos 3 canais para monetização com **AdSense**.  
5. 📱 Criação de um **App de tendências e notícias**, alimentado automaticamente com dados do blog.

---

## 📂 Estrutura das playlists no canal do YouTube

- 🧙‍♂️ Playlist por **Herói** `Caso de Dota 2`
- 🧠 Playlist por **Pro Player**  
- 🧠🎯 Playlist por **Pro Player + Herói** `Caso de Dota 2`
- 🏆 Playlist por **Times**
- 🏆 Playlist por **Competições**

---

# 🧙‍♂️ Dota 2 – Processamento de Replays

### Processo de Execução

- 1° Atualizar as constants do dota2
```shell
cd constants\games\
git clone --depth 1 https://github.com/odota/dotaconstants.git dota2
cd dota2
rm -rf .git
``` 

- 2° Subir o serviço do parser que faz leitura dos files `.dem`
```shell
cd services\parser\dota2
docker compose up --build -d
```
