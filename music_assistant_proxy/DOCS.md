<a href="#nl">NL</a> | <a href="#en">EN</a>

##### <ins>NL</ins>

Deze app zet een proxy op naar een **Music Assistant**-server die los van Home Assistant draait, zodat je Music Assistant via de zijbalk kunt openen zonder Music Assistant zelf als app te draaien. Dat is vooral handig als je Home Assistant van buitenaf over HTTPS benadert: een gewone HTTP-verbinding naar Music Assistant kan de browser dan niet rechtstreeks laden, maar via deze proxy loopt het netjes over de beveiligde Home Assistant-verbinding. **Deze app bevat Music Assistant zelf niet.**

### Configuratie

- **server_host** — het IP-adres van je Music Assistant-server (bijvoorbeeld `192.168.0.72`).
- **server_port** — de poort van je Music Assistant-server (standaard `8095`).
- **Music Assistant token** *(vereist)* — een langlevende token waarmee de app de WebSocket-verbinding met Music Assistant authenticeert, zodat je achter Home Assistant Ingress **geen loginscherm** meer krijgt (ook met een los draaiende server). Zonder token krijg je de gewone ingress-login, die voor een losse server niet werkt.

### Automatisch inloggen (langlevende token)

Music Assistant vereist tegenwoordig een login. Draait je Music Assistant-server los (dus niet als Home Assistant-app), dan kan Music Assistant via de zijbalk niet automatisch inloggen en vraagt het telkens opnieuw om in te loggen. Dat los je op met een langlevende token:

1. Open **Music Assistant** en ga naar je **profielinstellingen**.
2. Maak een **langlevende token** aan (1 jaar geldig) en kopieer die.
3. Ga in deze app naar het tabblad **Configuratie**, plak de token bij **Music Assistant token** en sla op.
4. **Herstart** de app en ververs je browser (Ctrl+F5).

De app authenticeert hiermee de WebSocket-verbinding met Music Assistant, waardoor je automatisch herkend wordt en er geen loginscherm meer verschijnt.

> **Let op:** met een token ingesteld krijgt iedere Home Assistant-gebruiker die deze app kan openen toegang tot Music Assistant (via de gedeelde token). Omdat de zijbalk al een Home Assistant-login vereist, komt dit neer op "ingelogd in Home Assistant = toegang tot Music Assistant". De token verloopt na 1 jaar; maak dan een nieuwe aan.

### Ondersteuning

Open een issue op GitHub als je hulp nodig hebt.

### Steun dit project ☕

Vind je deze app nuttig? Een kleine bijdrage houdt de koffie warm en de commits komend. Volledig vrijblijvend natuurlijk!

<!-- Ko-fi badge via shields.io, geen externe tracking -->
[![Koop me een koffie op Ko-fi](https://img.shields.io/badge/Ko--fi-Koop%20me%20een%20koffie-FF5E5B?style=for-the-badge&logo=kofi&logoColor=white)](https://ko-fi.com/sarnog)

<!-- GitHub Sponsors badge, toont live het aantal sponsors -->
[![Sponsor via GitHub](https://img.shields.io/github/sponsors/sarnog?style=for-the-badge&logo=github&label=Sponsors&color=EA4AAA)](https://github.com/sponsors/sarnog)


---


##### <ins>EN</ins>

This app sets up a proxy to a **Music Assistant** server that runs separately from Home Assistant, so you can open Music Assistant from the sidebar without running Music Assistant itself as an app. This is especially handy when you access Home Assistant remotely over HTTPS: the browser can't load a plain HTTP connection to Music Assistant directly, but through this proxy it travels over the secure Home Assistant connection. **This app does not contain Music Assistant itself.**

### Configuration

- **server_host** — the IP address of your Music Assistant server (for example `192.168.0.72`).
- **server_port** — the port of your Music Assistant server (default `8095`).
- **Music Assistant token** *(required)* — a long-lived token the app uses to authenticate the WebSocket connection to Music Assistant, so **no login screen** appears behind Home Assistant Ingress (even with a standalone server). Without a token you get the regular ingress login, which does not work for a standalone server.

### Automatic login (long-lived token)

Music Assistant now requires a login. If your Music Assistant server runs separately (not as a Home Assistant app), Music Assistant can't log in automatically through the sidebar and keeps asking you to log in. A long-lived token solves this:

1. Open **Music Assistant** and go to your **profile settings**.
2. Create a **long-lived token** (valid for 1 year) and copy it.
3. In this app, open the **Configuration** tab, paste the token into **Music Assistant token** and save.
4. **Restart** the app and refresh your browser (Ctrl+F5).

The app then uses it to authenticate the WebSocket connection to Music Assistant, so you are recognised automatically and no login screen appears.

> **Note:** with a token set, any Home Assistant user who can open this app gets access to Music Assistant (via the shared token). Since the sidebar already requires a Home Assistant login, this effectively means "logged in to Home Assistant = access to Music Assistant". The token expires after 1 year; create a new one when it does.

### Support

Open an issue on GitHub if you need help.

### Support this project ☕

Do you find this app useful? A small contribution keeps the coffee warm and the commits coming. Entirely optional, of course!

<!-- Ko-fi badge via shields.io, no external tracking -->
[![Buy me a coffee on Ko-fi](https://img.shields.io/badge/Ko--fi-Buy%20me%20a%20coffee-FF5E5B?style=for-the-badge&logo=kofi&logoColor=white)](https://ko-fi.com/sarnog)

<!-- GitHub Sponsors badge, shows the sponsor count live -->
[![Sponsor via GitHub](https://img.shields.io/github/sponsors/sarnog?style=for-the-badge&logo=github&label=Sponsors&color=EA4AAA)](https://github.com/sponsors/sarnog)
