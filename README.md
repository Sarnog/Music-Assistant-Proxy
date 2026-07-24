<a href="#nl">NL</a> | <a href="#en">EN</a>

<div align="center">
  <!-- align="center" centreert alles binnen deze div -->
  <h1>
    <!-- h1 = grootste kop, standaard al dikgedrukt en groot -->
    <ins>Music Assistant Proxy</ins>
    <!-- ins = onderstreepte tekst op GitHub -->
  </h1>
</div>


##### <ins>NL</ins>

Een Home Assistant-app die een los draaiende **Music Assistant**-server in de zijbalk van Home Assistant beschikbaar maakt. De app draait Music Assistant niet zelf — het is puur een proxy, zodat je Music Assistant kunt openen (ook van buitenaf via HTTPS) zonder het als app op je Home Assistant-machine te draaien.

<table>
  <tr>
    <td>App-repository toevoegen:</td>
    <td><a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FSarnog%2FMusic-Assistant-Proxy"><img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" alt="Open je Home Assistant en voeg deze add-on-repository toe."></a></td>
  </tr>
</table>

**Te installeren via de Home Assistant add-on-store als repository — zie [Installatie](#installatie).**

### Wat doet dit

Music Assistant draait op een andere machine dan Home Assistant. Deze app zet een proxy op die die server via de zijbalk van Home Assistant (ingress) bereikbaar maakt — handig als je Home Assistant van buitenaf over HTTPS benadert, want dan kan een gewone HTTP-verbinding naar Music Assistant niet rechtstreeks geladen worden. **De app bevat Music Assistant zelf niet.**

### Installatie

1. Voeg deze repository toe aan de add-on-store: klik de badge hierboven, of ga naar **Instellingen → Add-ons → Add-on-store → ⋮ → Repositories** en plak de GitHub-URL van deze repository.
2. Installeer **Music Assistant Proxy** uit de store.
3. Stel de opties in (zie [Configuratie](#configuratie)) en start de app.

### Configuratie

- **server_host** — het IP-adres van je Music Assistant-server.
- **server_port** — de poort van je Music Assistant-server (standaard `8095`).
- **Music Assistant token** *(optioneel)* — een langlevende token uit je Music Assistant-**profielinstellingen**. Vul je die in, dan authenticeert de app elke verbinding automatisch en verschijnt er **geen loginscherm** achter Home Assistant Ingress. Laat leeg om de gewone Music Assistant-login te gebruiken.

### Steun dit project ☕

Vind je deze app nuttig? Een kleine bijdrage houdt de koffie warm en de commits komend. Volledig vrijblijvend natuurlijk!

<!-- Ko-fi badge via shields.io, geen externe tracking -->
[![Koop me een koffie op Ko-fi](https://img.shields.io/badge/Ko--fi-Koop%20me%20een%20koffie-FF5E5B?style=for-the-badge&logo=kofi&logoColor=white)](https://ko-fi.com/sarnog)

<!-- GitHub Sponsors badge, toont live het aantal sponsors -->
[![Sponsor via GitHub](https://img.shields.io/github/sponsors/sarnog?style=for-the-badge&logo=github&label=Sponsors&color=EA4AAA)](https://github.com/sponsors/sarnog)


---


##### <ins>EN</ins>

A Home Assistant app that makes a separately running **Music Assistant** server available in the Home Assistant sidebar. The app does not run Music Assistant itself — it is purely a proxy, so you can open Music Assistant (including remotely over HTTPS) without running it as an app on your Home Assistant machine.

<table>
  <tr>
    <td>Add app repository:</td>
    <td><a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FSarnog%2FMusic-Assistant-Proxy"><img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" alt="Open your Home Assistant instance and add this add-on repository."></a></td>
  </tr>
</table>

**Install via the Home Assistant add-on store as a repository — see [Installation](#installation).**

### What this does

Music Assistant runs on a different machine than Home Assistant. This app sets up a proxy that makes that server reachable through the Home Assistant sidebar (ingress) — useful when you access Home Assistant remotely over HTTPS, because a plain HTTP connection to Music Assistant can't be loaded directly then. **The app does not contain Music Assistant itself.**

### Installation

1. Add this repository to the add-on store: click the badge above, or go to **Settings → Add-ons → Add-on store → ⋮ → Repositories** and paste this repository's GitHub URL.
2. Install **Music Assistant Proxy** from the store.
3. Set the options (see [Configuration](#configuration)) and start the app.

### Configuration

- **server_host** — the IP address of your Music Assistant server.
- **server_port** — the port of your Music Assistant server (default `8095`).
- **Music Assistant token** *(optional)* — a long-lived token from your Music Assistant **profile settings**. Enter it and the app authenticates every connection automatically, so **no login screen** appears behind Home Assistant Ingress. Leave empty to use the regular Music Assistant login.

### Support this project ☕

Do you find this app useful? A small contribution keeps the coffee warm and the commits coming. Entirely optional, of course!

<!-- Ko-fi badge via shields.io, no external tracking -->
[![Buy me a coffee on Ko-fi](https://img.shields.io/badge/Ko--fi-Buy%20me%20a%20coffee-FF5E5B?style=for-the-badge&logo=kofi&logoColor=white)](https://ko-fi.com/sarnog)

<!-- GitHub Sponsors badge, shows the sponsor count live -->
[![Sponsor via GitHub](https://img.shields.io/github/sponsors/sarnog?style=for-the-badge&logo=github&label=Sponsors&color=EA4AAA)](https://github.com/sponsors/sarnog)
