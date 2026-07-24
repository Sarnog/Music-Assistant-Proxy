# Changelog

Alle noemenswaardige wijzigingen aan deze app worden hier bijgehouden. /
All notable changes to this app are documented here.

## 2.0.0 – 2026-07-24

### 🇳🇱 Nederlands

**Gewijzigd**
- De app authenticeert nu de **WebSocket-verbinding** met Music Assistant zelf, met jouw langlevende token. Daardoor logt de web-frontend achter Home Assistant Ingress automatisch in en verschijnt er **geen loginscherm** meer — óók met een los draaiende Music Assistant-server. (De token-header uit 1.2.0 dekte alleen de REST-kant; de eigenlijke login gebeurt in de WebSocket, en die wordt nu afgehandeld.)
- Nieuwe interne opzet: naast nginx draait een kleine **Python-bridge** die uitsluitend `/ws` afhandelt, de MA-verbinding vooraf met de token authenticeert en de rest transparant doorgeeft.

**Vereist**
- Vul de **Music Assistant token** in (langlevende token uit je MA-profielinstellingen). Zonder token valt de app terug op de gewone ingress-login, die voor een losse server niet werkt.

**Terugvallen**
- De vorige, pure nginx-proxy (v1.2.0) staat op de branch [`legacy-nginx-proxy`](https://github.com/Sarnog/Music-Assistant-Proxy/tree/legacy-nginx-proxy). Lost Music Assistant het ingress-probleem bovenstroom op, dan kun je daarnaartoe terugswitchen.

**Toepassen:** werk bij naar 2.0.0, controleer dat je token is ingevuld, herstart de app en ververs je browser (Ctrl+F5).

### 🇬🇧 English

**Changed**
- The app now authenticates the **WebSocket connection** to Music Assistant itself, using your long-lived token. As a result the web frontend logs in automatically behind Home Assistant Ingress and **no login screen** appears — even with a standalone Music Assistant server. (The 1.2.0 token header only covered the REST side; the actual login happens over the WebSocket, which is now handled.)
- New internal setup: alongside nginx a small **Python bridge** handles `/ws` only, authenticating the MA connection with the token up front and relaying everything else transparently.

**Required**
- Set the **Music Assistant token** (a long-lived token from your MA profile settings). Without a token the app falls back to the regular ingress login, which does not work for a standalone server.

**Fallback**
- The previous, pure nginx proxy (v1.2.0) lives on the [`legacy-nginx-proxy`](https://github.com/Sarnog/Music-Assistant-Proxy/tree/legacy-nginx-proxy) branch. If Music Assistant fixes the ingress issue upstream, you can switch back to it.

**How to apply:** update to 2.0.0, make sure your token is set, restart the app and refresh your browser (Ctrl+F5).

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
