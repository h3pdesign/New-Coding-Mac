# PowerShell-_Cmdlets_ suchen mit Get-Command und Get-Module

Microsoft sieht **PowerShell** als Script-Umgebung und Kommandozeile, die praktisch alle Komponenten und Funktionen des Systems verwalten soll. Entsprechend groß ist der Umfang an Kommandos (_Cmdlets_) und er wächst mit Windows 8 und Server 2012 noch erheblich. Hinzu kommen Module für die Administration von Anwendungen wie Sharepoint oder für Software von Drittanbietern (z.B. VMware PowerCLI). Zum Glück bietet PowerShell die Mittel, um sich in den zahlreichen _Cmdlets_ zurechtzufinden.
Der Befehlssatz von PowerShell besteht aus _Cmdlets_, die ihrerseits in Modulen zusammengefasst sind. Die meisten davon, die man für das Abfragen und Verändern von Windows-Basisfunktionen benötigt, werden automatisch mit dem Start von PowerShell geladen. Andere wiederum, wie beispielsweise für den Zugriff auf das Active Directory oder für Group Policy müssen nachträglich geladen werden.

### Module laden, um nach _Cmdlets_ zu suchen

Während man bis PowerShell 2.0 die _Cmdlets_ zusätzlicher Module explizit mit dem Befehl nach dem Muster Import-Module ActiveDirectory laden musste, beherrscht die Version 3.0 das so genannte Autoloading. Dabei werden _Cmdlets_ automatisch importiert, sobald man sie aufruft, ihre Online-Hilfe mit Get-Help anzeigt oder den Befehl `Get-Command` auf sie anwendet.

### Liste der Module anzeigen

Sucht man für eine bestimmte Aufgabe ein passendes _Cmdlet_, dann kann die Recherche auf ein bestimmtes Modul eingrenzen, wenn man nicht zu viele Ergebnisse haben möchte und weiß, wo man nachsehen muss.
Zu diesem Zweck lässt man sich erst die verfügbaren Module mit `Get-Module` anzeigen. Ruft man das _Cmdlet_ ohne Parameter auf, dann gibt es eine Liste der geladenen Module aus. Möchte man wissen, welche zusätzlich verfügbar sind und importiert werden können, dann gibt man `Get-Module -ListAvailable` ein.

### Suche nach Cmdlet mit Get-Command

Die eigentliche Suche nach einem passenden Cmdlet erfolgt über `Get-Command`,wobei nun hier die gewonnenen Informationen über Module genutzt werden können. Um etwa die _Cmdlets_ aus dem Module ActiveDirectory aufzulisten, tippt man `Get-Command -Module ActiveDirectory` ein. Voraussetzung dafür ist bei PowerShell 2.0 jedoch, dass das Modul vorher geladen wurde, sonst zeigt `Get-Command` nichts an.

Die auf solche Weise gewonnene Liste ist bei vielen Modulen zu lang und unübersichtlich. Erst recht gilt das, wenn man die Recherche über alle Module laufen lässt, indem man keinen Parameter angibt.

### Einschränkung der Suche auf Namensbestandteile

Zur weiteren Filterung der verfügbaren _Cmdlets_ kann man verschiedene Methoden anwenden. Zum einen kann man sich die Namenskonvention für _Cmdlets_ zunutze machen, die ein Verb und ein Noun als Namensbestandteile vorsieht. Das Verb beschreibt die Tätigkeit des Kommandos, also etwa `Get`, `Write` oder `Remove`. Will man nur Werte aus dem AD auslesen, dann könnte man den obigen Befehl folgendermaßen erweitern:

`Get-Command -Module ActiveDirectory -Verb get`

Möchte man dagegen im zweiten Namensteil hinter dem Bindestrich suchen, dann hilft hier der Parameter -noun. Um beispielsweise ein Cmdlet zu finden, mit dem man auf AD-Gruppen zugreifen kann, würde man etwa `Get-Command -Noun ADGroup*` eingeben. Dieses Beispiel verzichtet auf die Eingrenzung auf das ActiveDirectory-Modul, weil die für -noun angegebene Zeichenkette schon sehr spezifisch ist und daher nicht zu viele Ergebnisse zu erwarten sind.

### Allgemeine Suche im Namen

Möchte man nach beliebigen Zeichenketten im Namen eines _Cmdlets_ suchen, dann kann man das über den Parameter -name tun. Dabei lassen sich Wildcards verwenden, um Vorkommnisse an allen Positionen zu erfassen:

`Get-Command -Module ActiveDirectory *Group*`

Hat man aufgrund seines Namens ein scheinbar passendes Cmdlet gefunden, dann besteht der nächste Schritt meistens darin, dass man sich dafür den Hilfetext anzeigen lässt:

`Get-Help Add-ADGroupMember`

Für eine ausführliche Beschreibung inklusive Beispielen fügt man dem Aufruf noch den Parameter `-full` an.
