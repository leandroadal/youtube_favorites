# fav_youtube_with_bloc

Aplicativo para salvar seus videos favoritos do YouTube e reproduzi-los usando Flutter e Bloc.

## Muda o Idioma | Change Language

- [English (EN)](README-en.md)

## Funcionalidades Principais

- Página Inicial: Apresenta uma lista de vídeos com miniaturas, títulos e nome do canal.

- Pesquisa: Os usuários podem pesquisar vídeos por título.

- Favoritos: Os usuários podem favoritar vídeos e visualizá-los mais tarde.

- Página do Vídeo: Os usuários podem visualizar detalhes do vídeo, como título, descrição, visualizações, likes.

- Reprodução de Vídeo: Os usuários podem reproduzir vídeos em tela cheia.

## Como Executar

### Pré-requisitos

- Flutter 3.16.0 ou superior
- Android Studio ou VS Code
- Dispositivo Android ou iOS ou emulador configurado

### Passos

#### Clone este repositório

```bash
git clone https://github.com/seu-usuario/flutter-youtube-clone.git
```

#### Navegue até o diretório do projeto

``````bash
cd flutter-youtube-clone
``````

#### Instale as dependências

```dart
flutter pub get
```

#### Execute o aplicativo

```dart
flutter run
```

## Bibliotecas Utilizadas

- **bloc_pattern**: Para gerencia de estado
- **youtube_player_flutter**: Para reprodução de vídeo.
- **http**: Para fazer solicitações HTTP à API do YouTube.
- **flutter_dotenv**: Para carregar variáveis de ambiente do arquivo .env.
- **rxdart**: Para criar streams de dados.
- **shared_preferences**: Para salvar os favoritos.
