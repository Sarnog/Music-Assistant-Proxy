# Changelog

Alle noemenswaardige wijzigingen aan deze app worden hier bijgehouden. /
All notable changes to this app are documented here.

## 1.2.0 – 2026-07-24

### 🇳🇱 Nederlands

**Toegevoegd**
- Nieuwe optionele optie **`ma_token`** (Music Assistant token). Maak in Music Assistant onder je **profielinstellingen** een langlevende token aan en vul die in bij de app. De app stuurt die token dan bij elke verbinding mee (`Authorization: Bearer`), zodat Music Assistant je automatisch herkent en er achter Home Assistant Ingress **geen loginscherm meer verschijnt**. Zonder token werkt de app precies als voorheen.

**Verwijderd**
- De ingress-header-doorgifte uit 1.1.0 (`X-Ingress-Path`, `X-Remote-User-*`) is verwijderd. Die had geen effect: Music Assistant herkent een ingress-verbinding aan de socket waarop die binnenkomt, niet aan deze headers. Token-authenticatie (zie hierboven) is de door Music Assistant bedoelde manier voor een reverse proxy.

**Toepassen:** herbouw/herstart de app, vul je token in en ververs je browser (Ctrl+F5).

### 🇬🇧 English

**Added**
- New optional **`ma_token`** option (Music Assistant token). Create a long-lived token in Music Assistant under your **profile settings** and paste it into the app. The app then sends that token on every connection (`Authorization: Bearer`), so Music Assistant recognises you automatically and **no login screen appears** behind Home Assistant Ingress. Without a token the app behaves exactly as before.

**Removed**
- The 1.1.0 ingress-header forwarding (`X-Ingress-Path`, `X-Remote-User-*`) has been removed. It had no effect: Music Assistant detects an ingress connection by the socket it arrives on, not by these headers. Token authentication (see above) is Music Assistant's intended method for a reverse proxy.

**How to apply:** rebuild/restart the app, enter your token and refresh your browser (Ctrl+F5).

## 1.1.0 – 2026-07-24

### 🇳🇱 Nederlands

**Opgelost**
- Je hoeft niet meer elke keer opnieuw in te loggen. De app stuurt nu de Home Assistant Ingress-headers (`X-Ingress-Path`, `X-Remote-User-Id`, `X-Remote-User-Name`, `X-Remote-User-Display-Name`) door aan Music Assistant, zodat MA je al-ingelogde Home Assistant-gebruiker herkent en zijn eigen loginscherm overslaat.

**Opgeschoond**
- Overbodige app-configuratiesleutels verwijderd die gelijk waren aan hun standaardwaarde (`uart`/`audio`/`video`/`gpio`, lege `privileged`/`map`/`environment`, `hassio_role`, `log_level`) en de ongebruikte `hassio_api`-permissie — deze proxy roept de Supervisor-API nooit aan.
- Het niet-schema `addons`-blok uit `repository.json` verwijderd; de Supervisor negeerde dit en het dupliceerde de gegevens uit `config.json`.

**Toepassen:** herbouw of herstart de app en ververs je browser (Ctrl+F5).

### 🇬🇧 English

**Fixed**
- No more logging in every time. The app now forwards the Home Assistant Ingress headers (`X-Ingress-Path`, `X-Remote-User-Id`, `X-Remote-User-Name`, `X-Remote-User-Display-Name`) to Music Assistant, so MA recognises your already-authenticated Home Assistant user and skips its own login screen.

**Cleaned up**
- Removed redundant app config keys that were equal to their defaults (`uart`/`audio`/`video`/`gpio`, empty `privileged`/`map`/`environment`, `hassio_role`, `log_level`) and the unused `hassio_api` permission — this proxy never calls the Supervisor API.
- Removed the non-schema `addons` block from `repository.json`; the Supervisor ignored it and it duplicated the data in `config.json`.

**How to apply:** rebuild or restart the app and refresh your browser (Ctrl+F5).

## 1.0.0 – 2024-10-28

### 🇳🇱 Nederlands
- Eerste release: proxy naar een los draaiende Music Assistant-server, met een item in de Home Assistant-zijbalk via ingress.

### 🇬🇧 English
- Initial release: proxy to a separately running Music Assistant server, with a Home Assistant sidebar entry via ingress.
