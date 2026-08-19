# Intermission-
The **INTERMISSION** app is a **SwiftUI** movie discovery app built for iOS.
It has the **TMDB(The movie database)** API integrated and lets you browse trending films,explore movies by genre, search titles of your interests, and offeres to save movies to your personal watchlist.
The color scheme/theme in the UI is inspired by theatre colors like Cinema Red, Cinema white, Cinema black and etc and is similar to that of netflix/CineBy.
This project doesn't have that much of a real life implementation but it for sure covers a variety of major concepts that form the base of iOS development.

## Features 
- Browse trending and popular movies
- Search movies in real time
- Explore movies by genre (Action , Adevnture, comedy etc.)
- Detailed movie pages with ratings,overview, release date etc.
- Add to/Remove from Watchlist
- Clear Watchlist
- cinematic Netflix like UI 

## Tech Stack
- **Language:** Swift
- **Framework:** SwiftUI
- **IDE:** Xcode
- **Architecture:** MVVM(Model-View-ViewModel)
- **Networking:** URLSession + async/await
- **API:** TMDB (The Movie Database)

## Screenshots 

|           HOME             |       MOVIE DETAILS        |      WATCHLIST      |

<img width="210" height="450" alt="Screenshot 2026-08-14 at 6 52 26 PM" src="https://github.com/user-attachments/assets/afd0a341-9247-41da-8262-5438794efad5" />
<img width="210" height="450" alt="Screenshot 2026-08-14 at 6 54 01 PM" src="https://github.com/user-attachments/assets/465bdff3-0654-438a-b6fa-92eb4be22f28" />
<img width="210" height="450" alt="Screenshot 2026-08-14 at 6 55 43 PM" src="https://github.com/user-attachments/assets/4f852bf7-eb6e-4ee9-b87a-5715baa53e7f" />

## Project Structure

```text
Intermission/
├── Components/
├── Extensions/
├── Models/
├── Networking/
├── Utilities/
├── ViewModels/
└── Views/
```
## Itinerary 
                    INTERMISSION APP
                           │
                           ▼
      ┌──────────────────────────────┐
      │            Views             │  ← What user sees
      └──────────────────────────────┘
                           │
                           ▼
      ┌──────────────────────────────┐
      │         ViewModels           │  ← UI logic & state
      └──────────────────────────────┘
                           │
                           ▼
      ┌──────────────────────────────┐
      │        API / Services        │  ← Gets & manages data
      └──────────────────────────────┘
                           │
                           ▼
      ┌──────────────────────────────┐
      │           Models             │  ← Data structures
      └──────────────────────────────┘
      
## Things I learned 
- Decoding JSON to swift models (via models amd codable)
- Implementation of the MVVM structure and it's importance 
- State Management with property wrappers (specifically how some view model is shared globally and how some are only used for their specific views)
- Undertstanding async/await and making API/Image/View calls 
- Reusable swift components 

## Challenged/Issues I faced/am facing -
- Regarding section header's reusability biasness in cretain views 
- Use of "List" 
- confused about the APIService.swift file- primarily all of the helper methods . 
- Decoding nested JSON
- Trail of WatchlistManager throughout the app 

## Disclosure 
I used LLM for code completion and then for understanding swift concepts. Also currently I'm using it to understand whole of the code better and focusing on areas I'm struggling with. The Itinerary diagram shown above in the README is also LLM generated 


