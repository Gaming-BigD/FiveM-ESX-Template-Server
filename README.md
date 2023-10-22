# Template Server ESX Legacy! - UNBEDINGT LESEN

![FiveM template Server ]()

Schön das du dir dieses Projekt anguckst, mein Ziel ist es, für jeden den Perfekten Start in die Welt von FiveM zu bieten. Hier ist ein angepasster FiveM ESX Legacy Server. 
- Mehr Infos: Auf unseren Discord https://discord.gg/JvnmpZmJ8s
# Entwicklungszeit aktuell:

[![wakatime](https://wakatime.com/badge/user/8179ac82-4f81-4e8c-8976-2e51e14e1a46/project/35040979-3cf9-4010-8904-5ec10b7ea1d4.svg)](https://wakatime.com/badge/user/8179ac82-4f81-4e8c-8976-2e51e14e1a46/project/35040979-3cf9-4010-8904-5ec10b7ea1d4)

- Für den Server sind noch weitere Sachen geplant, gerne könnt ihr Vorschläge über den Discussions Tab machen.
- Solltet ihr irgendwelche Bugs finden, nutzt bitte den Issues Tab und beschreibt den Bug so gut wie möglich. Wir werden dann schnellst möglich versuchen den Bug zu fixen.
-----------------------------------------
# FiveM Server mieten oder Lifetime kaufen!

- https://zap-hosting.com/ServerFiveM

# Testserver:

- Hier eine IP zu einem Test Server
- folgt
- Testserver läuft mit der Version Release folgt


# Projekt unterstüzen:

- PayPal: tismerd15@gmail.com

-----------------------------------------

# Versionen

- Alpha 0.1 - Release: 1.09.2023
- v1.0-beta.1 - Release: 22.10.2023

# Installationsanleitung:
## Die Anleitung ist für einen neuen FiveM Server
### Wichtig! Hast du einen TxAdmin Server musst du bei der Einrichtung von TxAdmin, Popular Template auswählen und dann Default CFX.

- Bei einem vServer oder Rootserver musst du erstmal einen Cleanen FiveM Server auf diesen installieren.
-- https://docs.fivem.net/docs/server-manual/setting-up-a-server-vanilla/
- Bei einem vServer oder Rootserver brauchst du die FiveM Element Club Argentum Mitgliedschaft um OneSync zu nutzen.
- Bei einem Gameserver von Zap-hosting brauchst du die FiveM Element Club Argentum Mitgleidschaft erst bei über 48 Slots.
- Fivem Serverversion mindestens: 6552

- Für weitere Hilfe kannst du das Projekt unterstüzen und Zugriff zum Ticketsystem bekommen: https://shop.achimsommer.com/package/5708271 


1.
Füge folgende Ordner in deinen resources Ordner ein:
- [admin]
- [cfx-default]
- [datenbank]
- [esx]
- [esx_addons]
- [gc]
- [job] 
- [maps]
- [phone]
- [sontiges]

2.
Füge folgende Dateien in deinen server-data Ordner ein:
- maps.cfg
- resources.cfg
- phone.cfg
- server.cfg
- Trage deine MySql Datenbank Verbidung in die server.cfg

3.
Trage deine MySql Datenbank Verbidung in die server.cfg
- siehe Zeile 16

4.
Trage deine SteamID64(hex) in die server.cfg um Admin zu werden:
- siehe Zeile 68

5.
Trage deinen steam_webApiKey in die server.cfg ein
- siehe Zeile 74

6.
Importiere die ESXLegacy_FAF92E-sql aus dem [SQL] Ordner per phpmyadmin in deine Datenbank
