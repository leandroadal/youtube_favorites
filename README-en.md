# fav_youtube_with_bloc

An app to save your favorite YouTube videos and play them using Flutter and Bloc.

## Muda o Idioma | Change Language

- [Português (BR)](README.md)

## Key Features

- Home Page: Displays a list of videos with thumbnails, titles, and channel names.
  
- Search: Users can search videos by title.
  
- Favorites: Users can favorite videos and view them later.
  
- Video Page: Users can view video details such as title, description, views, likes.
  
- Video Playback: Users can play videos in fullscreen.
  
- Comments: Users can view and add comments to videos.

## How to Run

### Prerequisites

- Flutter 3.16.0 or higher
- Android Studio or VS Code
- Android or iOS device or configured emulator

### Steps

#### Clone this repository

```bash
git clone https://github.com/your-username/flutter-youtube-clone.git
```

#### Navigate to the project directory

```bash
cd flutter-youtube-clone
```

#### Instale as dependências

```dart
flutter pub get
```

#### Execute o aplicativo

```dart
flutter run
```

## Bibliotecas Utilizadas

- **bloc_pattern**: For state management.
- **youtube_player_flutter**: For video playback.
- **http**: For making HTTP requests to the YouTube API.
- **flutter_dotenv**: For loading environment variables from the .env file.
- **rxdart**: For creating data streams.
- **shared_preferences**: For saving favorites.
