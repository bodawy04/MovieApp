# Movie App

A basic movie application made with flutter featuring:

* **Viewing Now Playing and Popular Movies**
* **Viewing Movie Details**
* **Searching for Movies**
---

## Features

* **Viewing Movies(Main Screen)**: Both built with BlocBulder to render movies' details into widgets, displaying required data on successful data retrievement, loading and error if it failed to retrieve data

* **Movie Details Screen**: Used CustomScrollView to build the screen, SliverList to view movie details and FutureBuilder to view movie trailer and bloopers

* **Seraching for Movies**: Built using FutureBuilder to check if there are movies matching with the searched word or not.

---

## Project Structure

```text
lib/
├── Data/
│   ├── API/
│   │   ├── now_play_movies_api.dart
│   │   └── popular_movies_api.dart
│   ├── Model/
│   │   ├── movie_detail_model.dart
│   │   ├── movie_videos_model.dart
│   │   ├── now_play_movies_model.dart
│   │   └── popular_movies_model.dart
│   └── Repository/
│       ├── now_play_movies_repo.dart
│       └── popular_movies_repo.dart
│
├── cubits/
│   ├── now_playing_movies_cubit/
│   │   ├── now_playing_movies_cubit.dart
│   │   └── now_playing_movies_state.dart
│   └── popular_movies_cubit/
│       ├── popular_movies_cubit.dart
│       └── popular_movies_state.dart
│
├── presentation/
│   ├── screens/
│   │   ├── details_screen.dart
│   │   ├── main_screen.dart
│   │   └── search_screen.dart
│   └── widgets/
│       ├── now_playing_movies_bloc_builder.dart
│       ├── offline_builder.dart
│       ├── popular_movies_bloc_builder.dart
│       └── top_movie_stack.dart
│
├── constants.dart
├── main.dart
```
