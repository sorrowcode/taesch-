# taesch
Komfortables einkaufen

<img src="https://github.com/sorrowcode/taesch-/blob/developer/taesch/assets/logo.png?raw=true" width=20% height=20%>

taesch mach das Einkaufen einfacher. taesch lernt aus Ihrem Einkaufsverhalten in einem Supermarkt und gibt Tipps für die Reihenfolge.

## Getting Started
Voraussetzungen
- [git](https://git-scm.com/)
- [Flutter SDK](https://docs.flutter.dev/development/tools/sdk/releases)
- [Docker](https://www.docker.com/)
- Apple Mac Gerät (für iOS)

Zur Entwickung in Flutter eignet sich gut [Android Studio](https://developer.android.com/studio) mit dem Flutter Plugin.


Klonen des Projektes
```bash
  git clone https://github.com/sorrowcode/taesch-
```

Codeverzeichnis betreten
```bash
  cd taesch-/taesch
```

Installieren der Abhängigkeiten
```bash
  flutter pub get
```

Ein Debuganwendung erstellen & ausführen
```bash
  flutter run
```

Ein Auslieferungsanwendung erstellen & ausführen
```bash
  flutter run --release
```

Anwendungspaket bauen (Android)
```bash
  flutter build apk
```

Anwendungspaket bauen (iOS)
```bash
  flutter build ipa
```
Weitere infos zum iOS build in der [Flutter Dokumentation](https://docs.flutter.dev/deployment/ios)

## Tests durchführen
Um Tests auszuführen:
```bash
  flutter test
```
oder mit docker
```bash
  docker build .
```


## Flutter Entwicklung
Für Hilfe in den Einstig in Flutter, sehen Sie sich die
[online documentation](https://docs.flutter.dev/) an,
welche Anleitungen, Beispiele oder Hilfe für mobile Anwendungen und eine umfangreiche Dokumentation bietet.