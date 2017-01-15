--[[
	@translators:
	Take care before you hit save button: this file always needs to be saved in UTF-8 without BOM format!
	
	Garrysmod uses in most cases ISO639-1 for language code tags, some uses a additional region code tag
	Check convar gmod_language (after you changed language in mainmenu) and match against the array key you are translating for
]]--

CAF.LANGUAGE = CAF.LANGUAGE or {}

local t = CAF.LANGUAGE["en"] or {}

--Custom Addon Framework
t["caf_menu_title"] = "Custom Addon Framework Menu"
t["caf_menu_tab_title"] = "Custom Addon Framework"

--Life Support
t["Life Support"] = "Life Support"
t["Generator"] = "Generator"
t["Generators"] = "Generators"
t["Storage Device"] = "Storage Device"
t["Storage Devices"] = "Storage Devices"
t["Life Support Generators"] = "Life Support Generators"
t["Life Support Storage Devices"] = "Life Support Storage Devices"
t["Create Storage Devices attached to any surface."] = "Create Storage Devices attached to any surface."
t["Create Generators attached to any surface."] = "Create Generators attached to any surface."
t["Left-Click: Spawn a Device.  Reload: Repair Device."] = "Left-Click: Spawn a Device.  Reload: Repair Device."
t["Environmental Control"] = "Environmental Control"
t["Environmental Controls"] = "Environmental Controls"
t["sb_dev_plants_title"] = "Spacebuild Dev Plants"
t["sb_dev_plants_desc"] = "Create Dev Plants attached to any surface."
t["sb_dev_plants_desc2"] = "Left-Click: Spawn a Dev Plant.(Admin Only)  Reload: Repair Plant."

t["O2 Refresh Rate"] = "O2 Refresh Rate"
t["Dev Plants (Auto O2 Refresher)"] = "Dev Plants (Auto O2 Refresher)"
t["#Dev Plants"] = "Admin-only Plants"
t["Air"] = "Air"
t["Temperature"] = "Temperature"
t["Coolant"] = "Coolant"
t["Energy"] = "Energy"
t["Water"] = "Water"
t["Nitrogen"] = "Nitrogen"
t["Hydrogen"] = "Hydrogen"
t["Oxygen"] = "Oxygen"
t["Carbon Dioxide"] = "Carbon Dioxide"
t["Steam"] = "Steam"
t["Heavy Water"] = "Heavy Water"
t["Liquid Nitrogen"] = "Liquid Nitrogen"
t["Some Language Changes will only Show after a map reload!"] = "Some Language Changes will only Show after a map reload!"
t["Language"] = "Language"
t["Clientside CAF Options"] = "Clientside CAF Options"
--Shared 
t["No Implementation yet"] = "No Implementation yet"
t["Beta"] = "Beta"
t["This Addon is already Active!"] = "This Addon is already Active!"
t["Resource Distribution is Required and needs to be Active!"] = "Resource Distribution is Required and needs to be Active!"
t["This addon wasn't on in the first place"] = "This addon wasn't on in the first place"

--CAF Stuff
t["Error unloading Addon"] = "Error unloading Addon"
t["Error loading Addon"] = "Error loading Addon"
t["Addon"] = "Addon"
t["got disabled"] = "got disabled"
t["An error occured when trying to disable Addon"] = "An error occured when trying to disable Addon"
t["got enabled"] = "got enabled"
t["An error occured when trying to enable Addon"] = "An error occured when trying to enable Addon"
t["Missing Argument"] = "Missing Argument"
t["No HookName given"] = "No HookName given"
t["No function given"] = "No function given"
t["This hook doesn't exist"] = "This hook doesn't exist"
t["No AddonName given"] = "No AddonName given"
t["No OptionName given"] = "No OptionName given"
t["This option wasn't found for this Addon"] = "This option wasn't found for this Addon"
t["No Extra options found for this Addon"] = "No Extra options found for this Addon"
t["Addon Not Found"] = "Addon Not Found"
t["No Status Info Found"] = "No Status Info Found"
t["No Custom Status Info Found"] = "No Custom Status Info Found"
t["No Version Info Found"] = "No Version Info Found"
t["No AddonClass given"] = "No AddonClass (table) given"
t["CAF: Client has Internet. Enabled Online-Help"] = "CAF: Client has Internet. Enabled Online-Help"
t["Your version is out of date. Please update to version "] = "Your version is out of date. Please update to version "
t["No Description"] = "No Description"
t["Description"] = "Description"
t["Installed Addons"] = "Installed Addons"
t["Info and Help"] = "Info and Help"
t["Server Settings"] = "Server Settings"
t["Client Settings"] = "Client Settings"
t["About"] = "About"
t["Unknown"] = "Unknown"
t["Loading"] = "Loading"

--New CAF Stuff
t["This Addon is up to date"] = "This Addon is up to date";
t["This Addon is out of date"] = "This Addon is out of date";
t["No Update Information Available"] = "No Update Information Available";

--Default Stool Stuff
t["caf_stool_disabled"] = "This Stool is not active"
t["caf_stool_entity_disabled"] = "This Stool Entity is not active"
t["caf_stool_entity_model_disabled"] = "This Stool Entity Model is not active"
t["caf_stool_admin_required"] = "This Stool requires you to be an Admin";
t["caf_stool_entity_admin_required"] = "This Stool Entity requires you to be an Admin";
t["caf_stool_entity_model_admin_required"] = "This Stool Entity Model requires you to be an Admin";

t["This Addon is already Active!"] = "This Addon is already Active!"
t["This Addon is already disabled!"] = "This Addon is already disabled!"
t["Not on a Spacebuild Map!"] = "Not on a Spacebuild Map!"

CAF.LANGUAGE["en"] = t;

local t = CAF.LANGUAGE["nl"] or {}

--Custom Addon Framework
t["caf_menu_title"] = "Custom Addon Framework Menu"
t["caf_menu_tab_title"] = "Custom Addon Framework"

--Life Support
t["Life Support"] = "Life Support"
t["Generator"] = "Generator"
t["Generators"] = "Generators"
t["Storage Device"] = "Storage Device"
t["Storage Devices"] = "Storage Devices"
t["Life Support Generators"] = "Life Support Generators"
t["Life Support Storage Devices"] = "Life Support Storage Devices"
t["Create Storage Devices attached to any surface."] = "Create Storage Devices attached to any surface."
t["Create Generators attached to any surface."] = "Create Generators attached to any surface."
t["Left-Click: Spawn a Device.  Reload: Repair Device."] = "Left-Click: Spawn a Device.  Reload: Repair Device."
t["Environmental Control"] = "Environmental Control"
t["Environmental Controls"] = "Environmental Controls"
t["sb_dev_plants_title"] = "Spacebuild Dev Plants"
t["sb_dev_plants_desc"] = "Maak als admin nieuwe \"Dev Plants\" op eendert welk oppervlak aan."
t["sb_dev_plants_desc2"] = "Linksklikken: Spawn een Dev Plant.(Alleen Admins)  Herladen: Repareer de plant."

t["O2 Refresh Rate"] = "O2 Herstel ratio"
t["Dev Plants (Auto O2 Refresher)"] = "Dev Plants (Auto O2 hersteller)"
t["#Dev Plants"] = "Admin-only planten"
t["Air"] = "Zuurstof"
t["Temperature"] = "Temperatuur"
t["Coolant"] = "Koeling"
t["Energy"] = "Energie"
t["Water"] = "Water"
t["Nitrogen"] = "Skikstof"
t["Hydrogen"] = "Waterstof"
t["Oxygen"] = "Zuurstof"
t["Carbon Dioxide"] = "Koolstofdioxide"
t["Steam"] = "Stoom"
t["Heavy Water"] = "Zwaar Water"
t["Liquid Nitrogen"] = "Vloeibare skikstof"
t["Some Language Changes will only Show after a map reload!"] = "De taal kan nog niet op alle plaatsen. De taal is maar volledig gewijzigd eenmaal er minstens een 'map-reload' heeft plaatsgevonden!"
t["Language"] = "Taal"
t["Clientside CAF Options"] = "Clientside CAF Instellingen"
--Shared 
t["No Implementation yet"] = "Nog geen implementatie"
t["Beta"] = "Beta"
t["This Addon is already Active!"] = "Deze addon is al actief!"
t["Resource Distribution is Required and needs to be Active!"] = "Resource Distribution is nodig en moet actief zijn!"
t["This addon wasn't on in the first place"] = "Deze addon was nog nie eens actief"

--CAF Stuff
t["Error unloading Addon"] = "Er is een fout opgetreden bij het stoppen van de Addon"
t["Error loading Addon"] = "Er is een fout opgetreden bij het laden van de Addon"
t["Addon"] = "Addon"
t["got disabled"] = "is uitgeschakeld"
t["An error occured when trying to disable Addon"] = "Er is een fout opgetreden bij het stoppen van de Addon"
t["got enabled"] = "is ingeschakeld"
t["An error occured when trying to enable Addon"] = "Er is een fout opgetreden bij het starten van de Addon"
t["Missing Argument"] = "Er ontbreekt minstens 1 paramater"
t["No HookName given"] = "Geen HookNaam meegegeven"
t["No function given"] = "Geen functie meegegeven"
t["This hook doesn't exist"] = "Deze Hook bestaat niet"
t["No AddonName given"] = "Geen AddonNaam meegegeven"
t["No OptionName given"] = "Geen OptieNaam meegegeven"
t["This option wasn't found for this Addon"] = "Deze optie is niet gevonden voor deze Addon"
t["No Extra options found for this Addon"] = "Geen extra opties voor deze Addon gevonden"
t["Addon Not Found"] = "Deze Addon bestaat niet"
t["No Status Info Found"] = "Geen Status informatie gevonden"
t["No Custom Status Info Found"] = "Geen Custom Status informatie gevonden"
t["No Version Info Found"] = "Geen versie informatie gevonden"
t["No AddonClass given"] = "Geen AddonClass (Table) meegegeven"
t["CAF: Client has Internet. Enabled Online-Help"] = "CAF: Client heeft Internet. Online-Help wordt ingeschakeld."
t["Your version is out of date. Please update to version "] = "Je versie van CAF is niet meer up to date. Update AUB je versie van CAF "
t["No Description"] = "Geen beschrijving"
t["Description"] = "Beschrijving"
t["Installed Addons"] = "Geïnstalleerde Addons"
t["Info and Help"] = "Informatie en Hulp"
t["Server Settings"] = "Server Instellingen"
t["Client Settings"] = "Client Instellingen"
t["About"] = "Over"
t["Unknown"] = "Onbekend"
t["Loading"] = "Bezig met laden van"

--New CAF Stuff
t["This Addon is up to date"] = "Deze addon is volledig up to date";
t["This Addon is out of date"] = "Deze addon moet geupdate worden";
t["No Update Information Available"] = "Geen Update informatie gevonden";

--Default Stool Stuff
t["caf_stool_disabled"] = "Deze Stool is niet actief"
t["caf_stool_entity_disabled"] = "Deze Stool Entity is niet actief"
t["caf_stool_entity_model_disabled"] = "Dit Stool Entity Model is niet actief"
t["caf_stool_admin_required"] = "Om deze Stool te gebruiken moet je Admin rechten hebben.";
t["caf_stool_entity_admin_required"] = "Om deze Stool Entity te gebruiken moet je Admin rechten hebben.";
t["caf_stool_entity_model_admin_required"] = "Om dit Stool Entity Model te gebruiken moet je Admin rechten hebben.";

t["This Addon is already Active!"] = "Deze Addon is al actief!"
t["This Addon is already disabled!"] = "Deze Addon is niet actief!"
t["Not on a Spacebuild Map!"] = "Niet op een Spacebuild Kaart!"

CAF.LANGUAGE["nl"] = t;

local t = CAF.LANGUAGE["de"] or {}

--Custom Addon Framework
t["caf_menu_title"] = "Custom Addon Framework Menü"
t["caf_menu_tab_title"] = "Custom Addon Framework"

--Life Support
t["Life Support"] = "Lebenserhaltung"
t["Generator"] = "Generator"
t["Generators"] = "Generatoren"
t["Storage Device"] = "Speichersystem"
t["Storage Devices"] = "Speichersysteme"
t["Life Support Storage Devices"] = "Lebenserhaltungs-Speichersysteme"
t["Life Support Generators"] = "Lebenserhaltungs-Generatoren"
t["Create Storage Devices attached to any surface."] = "Erstellt Speichersysteme auf der Oberfläche."
t["Create Generators attached to any surface."] = "Erstellt Generatoren auf der Oberfläche."
t["Left-Click: Spawn a Device.  Reload: Repair Device."] = "Links-Klick: Erstellt ein Gerät.  Nachladen: Gerät reparieren."
t["Environmental Control"] = "Umweltkontrollsystem"
t["Environmental Controls"] = "Umweltkontrollsysteme"
t["sb_dev_plants_title"] = "Spacebuild Dev-Pflanzen"
t["sb_dev_plants_desc"] = "Erstelle Dev-Pflanzen auf jeder Oberfläche."
t["sb_dev_plants_desc2"] = "Links-Klick: Erstelle eine Dev-Pflanze.(nur Admins)  Nachladen: Pflanze aufpäppeln."

t["O2 Refresh Rate"] = "O2 Aktualisierungs-Rate"
t["Dev Plants (Auto O2 Refresher)"] = "Dev-Pflanzen (Automatische O2 Auffrischung)"
t["#Dev Plants"] = "Admin-Pflanzen"
t["Air"] = "Sauerstoff"
t["Temperature"] = "Temperatur"
t["Coolant"] = "Kühlmittel"
t["Energy"] = "Energie"
t["Water"] = "Wasser"
t["Nitrogen"] = "Stickstoff"
t["Hydrogen"] = "Wasserstoff"
t["Oxygen"] = "Sauerstoff"
t["Carbon Dioxide"] = "Kohlendioxid"
t["Steam"] = "Dampf"
t["Heavy Water"] = "Schweres Wasser"
t["Liquid Nitrogen"] = "Flüssiger Stickstoff"
t["Some Language Changes will only Show after a map reload!"] = "Änderungen der Spracheinstellungen sind erst nach einem Mapwechsel sichtbar!"
t["Language"] = "Sprache"
t["Clientside CAF Options"] = "Clientseitige CAF-Einstellungen"
--Shared 
t["No Implementation yet"] = "Noch nicht implementiert"
t["Beta"] = "Beta"
t["This Addon is already Active!"] = "Dieses Addon ist bereits aktiv!"
t["Resource Distribution is Required and needs to be Active!"] = "Resource Distribution wird benötigt und muss aktiv sein!"
t["This addon wasn't on in the first place"] = "Dieses Addon war noch nicht aktiv"

--CAF Stuff
t["Error unloading Addon"] = "Fehler beim Entladen des Addons"
t["Error loading Addon"] = "Fehler beim Laden des Addons"
t["Addon"] = "Addon"
t["got disabled"] = "wurde deaktiviert"
t["An error occured when trying to disable Addon"] = "Beim Versuch das Addon zu deaktivieren trat ein Fehler auf"
t["got enabled"] = "wurde aktiviert"
t["An error occured when trying to enable Addon"] = "Beim Versuch das Addon zu aktivieren trat ein Fehler auf"
t["Missing Argument"] = "Fehlendes Argument"
t["No HookName given"] = "Kein HookName angegeben"
t["No function given"] = "Keine Funktion angegeben"
t["This hook doesn't exist"] = "Dieser Hook existiert nicht"
t["No AddonName given"] = "Kein AddonName angegeben"
t["No OptionName given"] = "Kein OptionName angegeben"
t["This option wasn't found for this Addon"] = "Diese Einstellung wurde für dieses Addon nicht gefunden"
t["No Extra options found for this Addon"] = "Keine weiteren Einstellungen für dieses gefunden"
t["Addon Not Found"] = "Addon nicht gefunden"
t["No Status Info Found"] = "Keine Statusinformationen gefunden"
t["No Custom Status Info Found"] = "Keine benutzerdefinierten Statusinformationen gefunden"
t["No Version Info Found"] = "Keine Versionsinformationen gefunden"
t["No AddonClass given"] = "Keine AddonClass (table) übergeben"
t["CAF: Client has Internet. Enabled Online-Help"] = "CAF: Clientseitige Internetanbindung gefunden. Online-Hilfe eingeschaltet"
t["Your version is out of date. Please update to version "] = "Deine Version ist veraltet. Bitte auf diese Version updaten "
t["No Description"] = "Keine Beschreibung"
t["Description"] = "Beschreibung"
t["Installed Addons"] = "Installierte Addons"
t["Info and Help"] = "Infos und Hilfe"
t["Server Settings"] = "Server Einstellungen"
t["Client Settings"] = "Client Einstellungen"
t["About"] = "Über"
t["Unknown"] = "Unbekannt"
t["Loading"] = "Lade"

--New CAF Stuff
t["This Addon is up to date"] = "Dieses Addon ist aktuell";
t["This Addon is out of date"] = "Dieses Addon ist veraltet";
t["No Update Information Available"] = "Keine Update-Informationen verfügbar";

--Default Stool Stuff
t["caf_stool_disabled"] = "Dieses Stool ist deaktiviert"
t["caf_stool_entity_disabled"] = "Dieses Stool Entity ist deaktiviert"
t["caf_stool_entity_model_disabled"] = "Dieses Stool Entity Model ist deaktiviert"
t["caf_stool_admin_required"] = "Dieses Stool benötigt Adminrechte";
t["caf_stool_entity_admin_required"] = "Dieses Stool Entity benötigt Adminrechte";
t["caf_stool_entity_model_admin_required"] = "Dieses Stool Entity Model benötigt Adminrechte";

t["This Addon is already Active!"] = "Dieses Addon ist bereits aktiv!"
t["This Addon is already disabled!"] = "Dieses Addon ist bereits deaktiviert!"
t["Not on a Spacebuild Map!"] = "Dieses ist keine Spacebuild-Map!"

CAF.LANGUAGE["de"] = t;

local t = CAF.LANGUAGE["pt-BR"] or {}

--Custom Addon Framework
t["caf_menu_title"] = "Menu Custom Addon Framework"
t["caf_menu_tab_title"] = "Custom Addon Framework"

--Life Support
t["Life Support"] = "Suporte de Vida"
t["Generator"] = "Gerador"
t["Generators"] = "Geradores"
t["Storage Device"] = "Dispositivo de Armazenamento"
t["Storage Devices"] = "Dispositivos de Armazenamento"
t["Life Support Storage Devices"] = "Dispositivos de Armazenamento do Suporte de Vida"
t["Life Support Generators"] = "Geradores do Suporte de Vida"
t["Create Storage Devices attached to any surface."] = "Criar Dispositivos de Armazenamento fixados á qualquer superfície."
t["Create Generators attached to any surface."] = "Criar Geradores fixados á qualquer superífice."
t["Left-Click: Spawn a Device.  Reload: Repair Device."] = "Clique Esquerdo: Criar um Dispositivo. Recarregar: Consertar Dispositivo."
t["Environmental Control"] = "Controle de Ambiente"
t["Environmental Controls"] = "Controles de Ambiente"
t["sb_dev_plants_title"] = "Planta Dev Spacebuild"
t["sb_dev_plants_desc"] = "Criar Plantas Dev fixadas á qualquer superfície."
t["sb_dev_plants_desc2"] = "Clique Esquerdo: Criar uma Planta Dev.(Somente Admins) Recarregar: Consertar Planta."

t["O2 Refresh Rate"] = "Taxa de Recarregamento O2"
t["Dev Plants (Auto O2 Refresher)"] = "Plantas Dev (Recarregador de O2 Automático)"
t["#Dev Plants"] = "#Planta Dev"
t["Air"] = "Ar"
t["Temperature"] = "Temperatura"
t["Coolant"] = "Refrigerante"
t["Energy"] = "Energia"
t["Water"] = "Água"
t["Nitrogen"] = "Nitrogênio"
t["Hydrogen"] = "Hidrogênio"
t["Oxygen"] = "Oxigênio"
t["Carbon Dioxide"] = "Dióxido de Carbono"
t["Steam"] = "Vapor"
t["Heavy Water"] = "Água Pesada"
t["Liquid Nitrogen"] = "Nitrogênio Líquido"
t["Some Language Changes will only Show after a map reload!"] = "Algumas Mudanças de Linguagem só irão Aparecer depois de recarregar ou mudar o mapa!"
t["Language"] = "Linguagem"
t["Clientside CAF Options"] = "Opções CAF do Cliente"
--Shared 
t["No Implementation yet"] = "Nenhuma Implementação ainda."
t["Beta"] = "Beta"
t["This Addon is already Active!"] = "Esse Addon já está Ativo!"
t["Resource Distribution is Required and needs to be Active!"] = "Resource Distribution é necessário e precisa estar Ativo!"
t["This addon wasn't on in the first place"] = "Esse Addon não estava ligado para começar"

--CAF Stuff
t["Error unloading Addon"] = "Erro upando Addon"
t["Error loading Addon"] = "Erro carregando Addon"
t["Addon"] = "Addon"
t["got disabled"] = "foi desativado"
t["An error occured when trying to disable Addon"] = "Um erro occoreu ao tentar desabilitar o Addon"
t["got enabled"] = "foi ativado"
t["An error occured when trying to enable Addon"] = "Um erro occoreu ao tentar abilitar o Addon"
t["Missing Argument"] = "Argumento Faltando"
t["No HookName given"] = "Nenhum HookName especificado"
t["No function given"] = "Nenhum function especificado"
t["This hook doesn't exist"] = "Esse hook não existe"
t["No AddonName given"] = "Nenhum AddonName especificado"
t["No OptionName given"] = "Nenhum OptionName especificado"
t["This option wasn't found for this Addon"] = "Esta opção nao foi encontrada para esse Addon"
t["No Extra options found for this Addon"] = "Nenhuma opção extra encontrada para esse Addon"
t["Addon Not Found"] = "Addon Não Encontrado"
t["No Status Info Found"] = "Nenhum Status Info Encontrado"
t["No Custom Status Info Found"] = "Nenhum Custom Status Info Encontrado"
t["No Version Info Found"] = "Nenhum Version Info Encontrado"
t["No AddonClass given"] = "Nenhum AddonClass especificado"
t["CAF: Client has Internet. Enabled Online-Help"] = "CAF: Cliente tem Internet. Ajuda Online Abilitada"
t["Your version is out of date. Please update to version "] = "A sua versão está desatualizada. Por favor atualize para versão "
t["No Description"] = "Nenhuma Descrição"
t["Description"] = "Descrição"
t["Installed Addons"] = "Addons Instalados"
t["Info and Help"] = "Informação e Ajuda"
t["Server Settings"] = "Configurações do Server"
t["Client Settings"] = "Configurações do Cliente"
t["About"] = "Sobre"
t["Unknown"] = "Desconhecido"
t["Loading"] = "Carregando"

--New CAF Stuff
t["This Addon is up to date"] = "Esse Addon está atualizado";
t["This Addon is out of date"] = "Esse Addon está destualizado";
t["No Update Information Available"] = "Nenhuma Informção de Atualização Disponível";

--Default Stool Stuff
t["caf_stool_disabled"] = "Esse Stool não está ativo"
t["caf_stool_entity_disabled"] = "Esse Entidade Stool não está ativa"
t["caf_stool_entity_model_disabled"] = "Esse Modelo de Entidade Stool não está ativo"
t["caf_stool_admin_required"] = "Esse Stool é exclusivo para Admins";
t["caf_stool_entity_admin_required"] = "Essa Entidade Stool é exclusiva para Admins";
t["caf_stool_entity_model_admin_required"] = "Esse Modelo de Entidade Stool é exclusivo para Admins";

t["This Addon is already Active!"] = "Esse Addon já está Ativo!"
t["This Addon is already disabled!"] = "Esse Addon já está Desativado!"
t["Not on a Spacebuild Map!"] = "Esse não é um Mapa Spacebuild!"

CAF.LANGUAGE["pt-BR"] = t;

