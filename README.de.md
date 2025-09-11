<p align="center">
   <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="lunchSTEM Logo" width="300"/>
</p>

<h1 align="center">Demokratisierung von <i>STEM</i>-Wissen auf organisierte Weise</h1><br>

<p align="center">
   <strong>🌟 Gemeinnütziges Open-Source-Projekt 🌟</strong>
</p>

<p align="center">
   <em>Denken Sie an ein besseres Wikipedia für <i>STEM</i>.<br>
   Es ist wie FreeCodeCamp, aber für Dokumente (und nicht nur für Software-Engineering).</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Unserer%20Community%20Beitreten-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
   </a>
</p>

<p align="center">
   <a href="README.md">
      <img src="https://img.shields.io/badge/English-README-blue?style=for-the-badge" alt="English">
   </a>
   <a href="README.es.md">
      <img src="https://img.shields.io/badge/Español-README-red?style=for-the-badge" alt="Español">
   </a>
   <a href="README.zh.md">
      <img src="https://img.shields.io/badge/中文-README-yellow?style=for-the-badge" alt="中文">
   </a>
   <a href="README.pt.md">
      <img src="https://img.shields.io/badge/Português-README-green?style=for-the-badge" alt="Português">
   </a>
   <a href="README.fr.md">
      <img src="https://img.shields.io/badge/Français-README-purple?style=for-the-badge" alt="Français">
   </a>
   <a href="README.de.md">
      <img src="https://img.shields.io/badge/Deutsch-README-orange?style=for-the-badge" alt="Deutsch">
   </a>
</p>

---

> [!WARNING]
> **⚠️ Wichtig**
> 
> Dokumente in *lunchSTEM* werden von externen Autoren erstellt, nicht von uns. Wir unterstützen die Aufnahme von nicht verteilbaren Dokumenten ohne Autorenerlaubnis nicht (für nicht verteilbare Dokumente: prüfen Sie `author_permissions.jsonl`).
> 
> Jedes Dokument würdigt seine(n) Autor(en) in einer entsprechenden `<dateiname>.<dateierweiterung>.source.json` Datei.
> 
> Autoren können jederzeit die Entfernung von Inhalten beantragen. Nach Befolgen unseres vereinfachten Protokolls für *Inhaltsverwendungsanträge* entfernen wir Inhalte innerhalb von 24 Stunden. Diese Option ist schneller und freundlicher als eine *Digital Millennium Copyright Act (DMCA)* Benachrichtigung (die das Projekt schließen kann).

> [!NOTE]
> **🟩 Demnächst Verfügbar**
> 
> • **Website** mit Autorenseiten, Schlagwort-/semantischer Suche, Diskussionsforen zu Dokumenten, Inhaltsvorschauen, interaktiven Inhaltsvisualisierungen, Inhaltsmartierung/-markierung/-favorisierung, Notizen zu Dokumenten, trendige/beliebte Dokumente, Statistiken für Dokumente und Autoren, und mehr.
> 
> • **MCP Server:** nützlich für KI-Agenten, die komplexe Ingenieurarbeit oder wissenschaftliche Forschung durchführen.
> 
> • **Ordnungsgemäße CLI** wo Benutzer Schlagwort- und semantische Suche durchführen können.

## 🔍 Überblick

Dies ist eine sich entwickelnde *STEM* (Science, Technology, Engineering and Mathematics) Wissensbasis, die mit der Anstrengung der Gemeinschaft überprüft und verbessert werden soll. Sie kann von Menschen und KI-Agenten genutzt und verbessert werden.

Ihr idealer Anwendungsfall ist, **tief in ein *STEM*-Thema (und verwandte Themen) einzutauchen, nachdem Sie ein anfängliches Verständnis davon haben** (das Sie leicht über Google Search oder KI-Assistenten erhalten können).

Sie sollte organisierter und von höherer Qualität (Signal-Rausch-Verhältnis) sein als die Standard-Google-Suche/KI-Tiefenforschung für diesen Anwendungsfall.

Das Ziel ist es, später KI-Agenten zu ermöglichen, sie einfach als Werkzeug zu nutzen, indem ein *lunchSTEM MCP Server* erstellt wird.

## 📊 Projektstatistiken

- **Größe:** 60+ GB (einschließlich vieler Links)
- **Anzahl der PDF-Dateien** 10k+
- **Anzahl der Unterthemen** 6k+
- **Sprache der Materialien:** Englisch

## 🗑️ Inhaltsverwendungs- und Autorenkredit-Anfragen

Es wurde ein großer Aufwand betrieben, um urheberrechtlich geschützte (nicht verteilbare) Inhalte zu erkennen und zu entfernen und die Autoren/Verlage/Universitäten der verbleibenden Materialien zu würdigen. Eine manuelle Überprüfung jeder Datei konnte aufgrund der schieren Anzahl von Dateien nicht durchgeführt werden (aber wir begrüßen die Gemeinschaft, uns dabei zu helfen, indem sie Issues und PRs öffnet).
1. Wir führten Skripte aus, um jede Datei zu löschen, die eine andere Erweiterung außerhalb von enthält: `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. Wir führten Skripte zur automatisierten Erkennung urheberrechtsbezogener Schlüsselwörter in Dokumenten und Löschung solcher Dokumente aus
3. Wir führten Skripte zur automatisierten Entfernung akademischer Papiere aus.
4. Wir ersetzten manuell jedes Buch-PDF durch einen Link darauf.
5. Wir führten Skripte zur automatisierten Erstellung einer Autorenkredit-Datei (`.source.json`) für jedes verbleibende PDF aus, mit Informationen wie: Autoren, Link zur Quelle, modifiziert oder nicht, etc. Standardwert der Felder ist `null`, mit Ausnahme des Standardwerts des `changes_were_made` Feldes, welcher `False` ist. Standardwerte werden verwendet, wenn die Information im PDF selbst nicht gefunden werden kann.

Wir können jedoch keine Perfektion in diesem Prozess garantieren, daher, wenn Sie urheberrechtlich geschützte Inhalte oder Inhalte ohne ordnungsgemäße Autorenkredit-Daten finden, öffnen Sie bitte ein Issue und/oder machen Sie eine PR und/oder senden Sie eine E-Mail an bruno.c.scaglione@gmail.com. Wir zielen darauf ab, das Problem in 24h zu lösen. Beziehen Sie sich auf die `CONTRIBUTING.md` Datei für die Richtlinien dazu.

> **Vereinfachtes Protokoll für Inhaltsverwendungsanträge (Empfohlen über _DMCA_)**
   > 1. Lesen Sie CONTRIBUTING.md, um Issue-Richtlinien zu sehen
   > 2. Öffnen Sie ein *Inhaltsverwendungsantrag* Issue
   > 3. Senden Sie eine E-Mail an bruno.c.scaglione@gmail.com mit dem Betreff "[lunchSTEM] Inhaltsverwendungsantrag: #GITHUB_ISSUE_NUMMER_PLATZHALTER" und erklären Sie: wer Sie sind, den Pfad des/der Inhalts/Inhalte, die entfernt werden müssen, und Link zum spezifischen Issue, das Sie geöffnet haben.

<br>

> Diese Option ist __schneller und freundlicher als eine *DMCA*__ Benachrichtigung. Wenn wir mehrere *DMCA* Benachrichtigungen erhalten, riskiert das Projekt, von *Github* entfernt zu werden (auch nach Entfernung der Inhalte) und viele Menschen, die davon profitieren könnten, werden betroffen sein.

**Einhaltung des *Digital Millennium Copyright Act* (*DMCA*):** wir halten uns an den Digital Millennium Copyright Act (DMCA). Für formelle Takedown-Anfragen folgen Sie bitte dem *DMCA* Prozess.

## 📝 Autorenkredit

Autorenkredit-Daten einer PDF-Datei werden in `[dateiname].pdf.source.json` gespeichert, welche direkt geöffnet werden sollte (ohne `dvc pull`). Diese Datei kann Autoren, Universität, Verleger, Link zur Quelle und andere Metadaten über die spezifische Datei enthalten, auf die sie sich bezieht. Standardwert der Felder ist `null`, mit Ausnahme des Standardwerts des `changes_were_made` Feldes, welcher `False` ist.

## ⚙️ Anforderungen für die Nutzung

Stellen Sie sicher, dass Sie diese Tools installiert haben:

- `git`
- `rclone`

Diese können installiert werden, indem Sie deren jeweilige Installationsanleitung auf ihren Websites befolgen.

- [git Installationsanleitung](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [rclone Installationsanleitung](https://rclone.org/install/)

> [!NOTE]
> Bei der Konfiguration eines Remote-Speichers für _rclone_, stellen Sie sicher, dass Sie die Service-Account-Option und `lunch-stem-fadf503639fe.json` als Service-Account-Datei verwenden.

## 🚀 Wie zu Verwenden

1. **Öffnen Sie ein Terminal**: Um das Terminal zu öffnen, verwenden Sie die Suchfunktion Ihres Betriebssystems (durch Drücken der Windows-Taste oder Cmd + Leertaste auf Mac) und tippen Sie "terminal", "Eingabeaufforderung" oder "Windows Terminal" und wählen Sie die App

2. **Klonen Sie das Repo mit git** (dieser Befehl erstellt einen `lunch-stem` Ordner in Ihrem aktuellen Verzeichnis)

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > Wenn Sie Windows verwenden, ist es wichtig, in einem Verzeichnis der obersten Ebene zu klonen, um potenzielle Fehler im Zusammenhang mit der Erstellung zu langer Dateipfade zu vermeiden. Windows hat typischerweise eine maximale Dateipfadlänge von 260 Zeichen.

3. Betreten Sie den `lunch-stem` Ordner

   ```bash
   cd lunch-stem
   ```

4. Das Projekt einrichten

   **Für Linux**

   Skriptausführung aktivieren

   ```bash
   chmod +x scripts/setup 
      ```

   Setup-Skript ausführen

   ```bash
   source scripts/setup 
      ```

   **Für Windows:**

   Skriptausführung innerhalb der Terminal-Sitzung aktivieren

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   Setup-Skript ausführen

   ```powershell
   scripts/setup.ps1
      ```

5. **Durchsuchen Sie innerhalb des `ai2f` Ordners**

6. **Laden Sie PDF-Dateien herunter:**

   - Für `.pdf.dvc` Dateien

      **Laden Sie spezifische PDF-Dateien herunter mit:**

      ```bash
      lunch files "<erster_dvc_file_path_placeholder>" "[zweiter_dvc_file_path_placeholder]" ...
      ```

      Dieser Befehl holt die `.pdf`-Dateien und platziert sie in Ihrem aktuellen Verzeichnis.

      Wenn Sie Dateien am gleichen Ort wie die `pdf.dvc ` Datei platzieren möchten dann verwenden Sie:

      ```bash
      lunch files "<erster_dvc_file_path_placeholder>" "[zweiter_dvc_file_path_placeholder]" --in-place ...
      ```

      - _Hinweis 1:_ das erste Dateipfad-Argument ist erforderlich, der Rest ist optional.
      - _Hinweis 2:_ der in diesem Befehl verwendete Dateipfad sollte nicht `.source.json` am Ende haben. er sollte mit `.pdf.dvc` enden.
      - _Hinweis 3:_ andere Dateitypen (z.B. `.txt`) sollten direkt geöffnet werden, ohne dvc.
      - _Hinweis 4:_ wenn `.web.txt` vorhanden ist, dann sollten Sie diesen Befehl nicht versuchen, kopieren und fügen Sie einfach den Link innerhalb von `.web.txt` in Ihren Browser ein. Wir werden später ein `lunch get` implementieren, um Dateien aus dem Web zu holen.
      - _Hinweis 5:_ die `.pdf` Datei sollte nicht sichtbar sein, bevor Sie diesen Befehl ausführen.
      - _Hinweis 6:_ Sie können die Dateipfade über die grafische Benutzeroberfläche Ihres Betriebssystems erhalten, jedes Betriebssystem hat eine einfache Möglichkeit.


      **Laden Sie alle Dateien aus einem spezifischen Ordner herunter über:**

      ```bash
      lunch folder "<folder_path_placeholder>"
      ```

      Wenn Sie die neuen PDF-Dateien am gleichen Ort wie ihre entsprechenden `pdf.dvc` Dateien platzieren möchten dann verwenden Sie:

      ```bash
      lunch folder "<folder_path_placeholder>" --in-place
      ```

      Wenn Sie alle Dateien aus allen Unterverzeichnissen (rekursiv) herunterladen möchten dann verwenden Sie:

      ```bash
      lunch folder "<folder_path_placeholder>" --recursive
      ```

      Wenn Sie Dateien am gleichen Ort wie die `pdf.dvc ` Datei und für alle Unterverzeichnisse platzieren möchten dann verwenden Sie:

      ```bash
      lunch folder "<folder_path_placeholder>" --in-place --recursive
      ```
      Für Debugging verwenden Sie das `--verbose` Flag.

   - Für `pdf.web.txt` Dateien:

      Öffnen Sie einfach die Datei und folgen Sie dem Weblink darin.

   - Für `.sym.txt` Dateien:

      Öffnen Sie einfach die Datei und navigieren Sie zu dem darin geschriebenen Datei- oder Ordnerpfad. Diese Datei oder dieser Ordner befindet sich im `__Loopback`.

## 📁 Verzeichnisstruktur und Namenskonventionen

- Das **`__Loopback`** Verzeichnis enthält Dateien, die einen zu langen Pfad hatten. Eine Zeiger `.sym.txt` Datei wurde anstelle dieser Dateien erstellt, die auf die tatsächliche Datei im `__Loopback` Verzeichnis zeigt. Diese Zeiger-txt-Dateien folgen dieser Namenskonvention: `dateiname.dateierweiterung.sym.txt` und befinden sich im selben Verzeichnis, wo die tatsächliche Datei sein sollte.

- Die **`to-add.txt`** Datei im Root enthält Links zu Materialien, die später in lunchSTEM aufgenommen werden sollen.

- Dateien oder Ordner, die mit **MEGA** beginnen, zeigen Aggregator-Materialien an (Materialien, die eine Menge von Links zu einem spezifischen Thema aggregieren).

- Dateien oder Ordner, die mit **Awesome** beginnen, zeigen super hochqualitative Inhalte an.

## 🔬 Abdeckung der _STEM_ Bereiche

### Stärkste Bereiche

*lunchSTEM* ist im Moment vollständiger in den Bereichen `Computer Science & Engineering` und `AI` speziell.

### Schwächste Bereiche

Die Bereiche von `Hardcore Science` (Physik, Chemie, Biologie, Wirtschaft) sind bemerkenswert oberflächlicher in Bezug auf die Tiefe ihres Themenbaums.

## 🗺️ Roadmap-Versuch

> **Hinweis:** Schritte mit demselben **[buchstaben]** können parallel durchgeführt werden.

### Phase A: Fundamentale Probleme

1. **[b][a]** Branch-Namenskonvention und Branch-Regeln erstellen.

2. **[a]** Lösen Sie dringende Urheberrechts- und Autorenkredit-Probleme im Zusammenhang mit tatsächlich gespeicherten Dateien
   - Erstellen Sie ein CI-Skript, das eine Liste von `.source.json` Pfaden erstellt, die keine Autoreninformationen haben - diese sollten Priorität haben.

3. **[a]** Ersetzen Sie tatsächliche Dateien (und Homepage/Einstiegspunkt-Links) mit Links, um die Dateien direkt von ihrem ursprünglichen Host zu erhalten (verwenden Sie einen Browser-nutzenden KI-Agenten, um dabei zu helfen). Das Ziel ist, dass die meisten Dateien `dateiname.dateierweiterung.web.txt` mit dem Link darin sind (d.h., extern gehostete Datei). Benutzer können immer noch mit tatsächlichen Dateien beitragen, wenn sie die Autoren dieser Dateien sind (wie es *arXiv* tut), weil wir im Hintergrund immer noch DVC für tatsächliche Dateien verwenden werden.

4. **[a]** Implementieren Sie ordnungsgemäße Symlinks, die betriebssystemübergreifend funktionieren. Kein manuelles Nachschauen des Pfads in der `.sym.txt` Datei und manuelles Gehen zu diesem Verzeichnis mehr. Implementieren Sie auch einfache Weblinks, um manuelles Kopieren/Einfügen von Pfaden in `.web.txt` zum Browser zu vermeiden.

### Phase B: Wichtige Ergänzungen

5. **[b][a]** Erstellen Sie eine ordnungsgemäße *lunchSTEM CLI* (nicht in bash, mit Docstrings, modular, mit Tests, kompiliert) Paket/installierbar, wo Sie können:
   1. Dateien oder Verzeichnisse erhalten (bereits in grundlegender Weise implementiert)
   2. Bestimmte Dateitypen verstecken/anzeigen (z.B., verstecken: .dvc, .source.json, .prerequisites.json, Symlinks für andere Betriebssysteme, etc)
   3. Suche durchführen: Schlagwortsuche und semantische Suche

6. **[b]** Erstellen Sie einen *lunchSTEM MCP Server*: zuerst müssen Sie eine `.md` Version jeder `.pdf` erstellen

7. **[b][a]** Erstellen Sie eine Website, um den *lunchSTEM* Verbrauch durch Menschen zu erleichtern, wo Benutzer können:
   1. Das Repo als Diagramm visualisieren und navigieren
   2. Schlagwort-, filter-basierte und semantische Suche verwenden
   3. Vorschau von Dokumenten sehen, ohne sie öffnen zu müssen
   4. Dokumente direkt im Browser öffnen
   5. Ein Dokument mit einem Stern markieren
   6. Ihre eigene Markierung/Favorisierung der Materialien machen, die nur für sie sichtbar ist.
   7. Hervorhebungen und Notizen zu Materialien machen, die nur für sie sichtbar sind
   8. Autorenseiten sehen, die zu allen Materialien eines spezifischen Autors verlinken.
   9. In Diskussionsforen zu spezifischen Dokumenten teilnehmen
   10. Trendige/beliebte Dokumente und Autoren sehen
   11. Statistiken für Dokumente und Autoren sehen

8. **[b]** Sponsoren und Zuschüsse erhalten für: (1) Unterstützung unseres App-Hostings; (2) Aufbau eines dedizierten Teams von *lunchSTEM* Betreuern; (3) Bezahlung von Experten für Peer-Review-Prozesse; und (4) Weiterleitung eines Prozentsatzes des Geldes an beitragende Autoren. Alles Sponsoring-Geld würde in das Projekt reinvestiert werden, es ist ein gemeinnütziges Projekt.

9. CI Workflows erstellen

   1. **[b][a]** Tatsächliche `.pdf` Dateien durch `.pdf.dvc` Dateien ersetzen, um tatsächliche Wissensdateien im Repo zu vermeiden.

   2. **[b][a]** Hinzufügung von bösartiger Dateiverwendung, großer Dateiverwendung, Git-Repo-Verwendung, Entfernung von Dateien mit nicht akzeptierten Erweiterungen, urheberrechtlich geschütztem Material-Verwendung, etc um automatisch schlechte PRs zu vermeiden.

   3. **[b][a]** Hinzufügung von Standard-Konventionen-Durchsetzung in CI, um die Wissensbasis konsistent zu halten und inkonsistente PRs zu vermeiden.

### Phase C: Mehr Kernfunktionen

10. **[b][c][d]** Funktionen zu *lunchSTEM* hinzufügen, möglicherweise mit *AgentPool* zur Hilfe (parallel: weitere Materialien aus `to_add.txt` hinzufügen, aber als `dateiname.dateierweiterung.web.txt` mit dem HTTPS-Link in der Datei hinzufügen):
    - **Voraussetzungen:** `[dateiname.[dateierweiterung].prerequisites.json` hinzufügen, das eine hierarchische Liste von Voraussetzungen für jede Datei enthält
    - **Übungen:** Übungen mit Lösungen in jedem Themenverzeichnis innerhalb von `__Exercises` platzieren
    - **Werkzeuge:** Software-Werkzeuge in jedem Thema innerhalb von `__Tools` platzieren. Können Werkzeuge zum Tun oder Verstehen von etwas themenreliertem sein.
    - **Lern- und Zertifizierungspfade:** geführte sequenzielle Pfade (z.B., ML-Ingenieur-Pfad) mit geschätzter Abschlusszeit von 3 oder 6 Monaten und mit einer internen oder externen Prüfung/Zertifizierung am Ende.
    - **Beispielprojekte:** Beispielprojekte in jedem Themenverzeichnis innerhalb von `__Sample Projects` platzieren
    - **KI-Assistent innerhalb der lunchSTEM CLI, um Ihr Dokument leichter verständlich zu machen**: kann Diagramme, Notebook hinzufügen, wir schreiben in leichter verständlichen Worten, machen Beispiele, etc. Ein Trainings-/Prompting-Datensatz kann durch synthetisches absichtliches Verschlechtern guter Lernmaterialien generiert werden.
    - **KI-Tutor, der lunchSTEM als seine Wissensbasis verwendet**: Tutor, der benutzerdefinierte Studienführer erstellen kann, Textblöcke erklären und alle erforderlichen Voraussetzungen lehren, benutzerdefinierte interaktive Materialien erstellen, etc
    - **KI-Peer-Reviewer, der lunchSTEM als seine Wissensbasis verwendet**: einen KI-Agenten aufbauen, der neue *STEM* Dokumente in PRs überprüfen kann (und die nicht in der Liste respektierter Quellen stehen), um nicht auf menschliche Peer-Reviews angewiesen zu sein, die langsam und kostspielig sind. Menschliche Peer-Reviews sollten dann jährlich durchgeführt werden, um KI-Peer-Reviewer-Fehler zu fangen und Daten zu generieren, um den KI-Peer-Reviewer in seinen schwachen Punkten zu verbessern.
    - **lunchSTEM Universität:** kostenlose Online-Universität für Menschen, die strikte Fristen, Verantwortlichkeiten und Lernen mit anderen bevorzugen. Keine Prüfungen. Jedes Jahr werden Studenten bestehende Technologien oder Methoden von Grund auf bauen, inspiriert von [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) zusammen mit einer Monographie mit allen wichtigen Details und sie mit der Gemeinschaft über einen Blog-Post teilen. Studenten beenden die Universität mit einem stellaren Portfolio zum Zeigen. Top-down-Lernansatz, wo wir Studenten helfen, Themen on-demand zu lernen, wenn sie es brauchen, um etwas zu bauen.

### Phase D: Schöne Verbesserungen

11. **[d]** Von *Google Drive* (ich zahlte bereits für 2TB, deshalb habe ich es verwendet) zu einer besseren Speicheroption migrieren (z.B., *S3*).

12. **[d]** *AgentPool* erstellen: Team diverser Agenten, die PRs zum *lunchSTEM* Repo nach internen Diskussionen machen, Menschen Fragen stellen und vorgeschlagene Änderungen durch Finetuning von SLMs bewerten. Agenten werden kontinuierlich modifiziert, um Diversität sicherzustellen und ihre Intelligenz basierend auf genehmigtem neuem Wissen zu verbessern, das zu *lunchSTEM* hinzugefügt wird.

## ⚖️ Haftungsausschluss & Bedingungen

**WIE-IST-BASIS:** Dieses Projekt wird "wie es ist" ohne Gewährleistungen jeglicher Art bereitgestellt. Wir machen keine Darstellungen über die Genauigkeit, Vollständigkeit oder Rechtmäßigkeit des Inhalts.

**HAFTUNGSBESCHRÄNKUNG:** Im größtmöglichen gesetzlich zulässigen Umfang haften die Projektbetreuer nicht für Schäden, die aus der Nutzung dieses Repositorys entstehen.

**NUTZUNGSBEDINGUNGEN:** Durch die Nutzung dieses Repositorys stimmen Sie zu, Urheberrechtsgesetze zu respektieren, Inhalte nur für Bildungszwecke zu verwenden und alle anwendbaren Gesetze in Ihrer Gerichtsbarkeit einzuhalten.

**KEINE RECHTSBERATUNG:** Nichts in diesem Repository stellt Rechts-, Finanz- oder professionelle Beratung dar.

**Bildungszweck:** Dieses Projekt zielt darauf ab, organisierten Zugang zu Bildungsmaterialien für nicht-kommerzielle, Bildungszwecke zu bieten. Wir glauben, dass viele Nutzungen des Inhalts für Fair-Use-Schutz qualifiziert sein könnten, aber Fair-Use-Bestimmungen werden von Gerichten von Fall zu Fall getroffen.

## 💎 Sponsoren

__Möchten Sie Sponsor werden? Senden Sie eine E-Mail an bruno.c.scaglione@gmail.com mit dem Betreff "[lunchSTEM] Sponsoring"__ 

## [Freelunch](https://freelunch.dev)

![Freelunch Logo](./sponsors/freelunch/logo_freelunch_with_name.png)

## 🙏 Anerkennungen

