<div align="center">

| | |
|:---:|:---:|
| <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="lunchSTEM Logo" width="350"/> | <img src="./assets/lunch-stem-promotion-meme.jpg" alt="lunchSTEM meme" width="350"/> |

</div>

<h1 align="center">Démocratiser les connaissances <i>STEM</i> de manière organisée</h1><br>

<p align="center">
   <strong>🌟 Projet open source à but non lucratif (v0.1.0) 🌟</strong>
</p>

<p align="center">
   <em>Imaginez une meilleure Wikipédia pour les <i>STEM</i>.<br>
   C'est comme FreeCodeCamp, mais pour les documents (et pas seulement pour l'ingénierie logicielle).</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Rejoindre%20Notre%20Communauté-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
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

<h2 align="center">⭐ Étoiler le Projet</h2>

Si vous trouvez lunchSTEM utile, merci de considérer nous donner une étoile sur GitHub ! Cela nous aide à atteindre plus de personnes et nous garde motivés.

<p align="center">
   <a href="https://github.com/Freelunch-AI/lunch-stem">
      <img src="assets/star-github.png" alt="Donner une étoile à un projet Github" width=200>
   </a> <br>
   <em>Image d'exemple</em>
</p>

---

## 📚 Table des Matières

- [🔍 Aperçu](#-aperçu)
- [🎯 À qui s'adresse ce projet ?](#-à-qui-sadresse-ce-projet-)
- [📊 Statistiques du Projet](#-statistiques-du-projet)
- [⚙️ Prérequis d'Utilisation](#-prérequis-dutilisation)
- [🚀 Comment Utiliser](#-comment-utiliser)
- [📁 Structure des Répertoires et Conventions de Nommage](#-structure-des-répertoires-et-conventions-de-nommage)
- [🔬 Couverture des Domaines STEM](#-couverture-des-domaines-stem)
- [🤝 Contributions](#-contributions)
- [🗺️ Tentative de Feuille de Route](#-tentative-de-feuille-de-route)
- [🗑️ Demandes de Suppression de Contenu et d'Attribution de Crédit](#-demandes-de-suppression-de-contenu-et-dattribution-de-crédit)
- [📝 Attribution de Crédit](#-attribution-de-crédit)
- [⚖️ Clause de Non-responsabilité et Conditions](#-clause-de-non-responsabilité-et-conditions)
- [💎 Sponsors](#-sponsors)
- [🙏 Remerciements](#-remerciements)

## 🔍 Aperçu

Il s'agit d'une base de connaissances *STEM* (Science, Technologie, Ingénierie et Mathématiques) en évolution, destinée à être examinée et améliorée grâce aux efforts de la communauté. Elle peut être utilisée et améliorée par les humains et les agents IA.

Son cas d'usage idéal est d'être utilisé pour **approfondir un sujet *STEM* (et les sujets connexes) après avoir une compréhension initiale de celui-ci** (que vous pouvez facilement obtenir via la recherche Google ou les assistants IA).

Il devrait être plus organisé et de meilleure qualité (ratio signal/bruit) que la recherche Google par défaut/recherche approfondie IA pour ce cas d'usage.

L'objectif est, plus tard, de permettre aux agents IA de l'utiliser facilement comme outil en créant un *Serveur MCP lunchSTEM*.

## 🎯 À qui s'adresse ce projet ?

- **Étudiants** cherchant des matériaux d'apprentissage supplémentaires
- **Professionnels** souhaitant approfondir leurs connaissances STEM
- **Chercheurs** ayant besoin de matériaux de référence organisés
- **Éducateurs** à la recherche de ressources pédagogiques
- **Auto-apprenants** poursuivant des études indépendantes

## 📊 Statistiques du Projet

- **Taille :** 60+ Go (incluant beaucoup de liens)
- **Nombre de fichiers pdf :** 10k+
- **Nombre de sous-sujets :** 6k+
- **Langue des matériaux :** Anglais

## ⚙️ Prérequis d'Utilisation

Assurez-vous d'avoir ces outils installés :

- `git`
- `rclone`

Ceux-ci peuvent être installés en suivant leur guide d'installation respectif sur leurs sites web.

- [Guide d'installation git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Guide d'installation rclone](https://rclone.org/install/)

> [!NOTE]
> Lors de la configuration d'un stockage distant pour _rclone_, assurez-vous d'utiliser l'option de compte de service et `lunch-stem-fadf503639fe.json` comme fichier de compte de service.
>
> De plus, lors de l'installation de *rclone*, les utilisateurs *Windows* pourraient voir un avertissement de sécurité, c'est normal.

## 🚀 Comment Utiliser

1. **Ouvrir un terminal** : Pour ouvrir le terminal, utilisez la zone de recherche de votre système d'exploitation.

- Pour *Linux* : recherchez "terminal"
- Pour *Windows* : recherchez "powershell" et cliquez sur "Windows Powershell"

2. **Cloner le dépôt avec git** (cette commande créera un dossier `lunch-stem` dans votre répertoire actuel)

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > Si vous utilisez Windows, il est important de cloner dans un répertoire de niveau supérieur, pour éviter des erreurs potentielles liées à la création de chemins de fichiers trop longs. Windows a généralement un chemin de fichier maximum de 260 caractères.

   > [!NOTE]
   > La commande `git clone` copiera le projet sur votre machine avec toute la structure de dossiers déjà en place.

3. Entrer dans le dossier `lunch-stem`

   ```bash
   cd lunch-stem
   ```

4. Configurer le projet

   **Pour Linux**

   Configurer rclone

   Activer l'exécution de scripts _bash_

   ```bash
   chmod +x scripts/setup 
      ```

   Exécuter le script de configuration

   ```bash
   source scripts/setup 
      ```

   Vous devriez voir le message `Setup complete!` affiché dans le terminal, avec d'autres détails.

   **Pour Windows :**

   Activer l'exécution de scripts dans la session _powershell_

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   Exécuter le script de configuration

   ```powershell
   scripts/setup.ps1
      ```

   Vous devriez voir le message `Setup complete!` affiché dans le terminal, avec d'autres détails.

5. **Naviguer dans le dossier `ai2f`**

   Structure du dossier `ai2f` :

         ├── __Loopback
         ├── Computer Science and Engineering 
         ├── Hardcore Engineering 
         ├── Hardcore Science  
         └── Mathematics

6. **Télécharger les fichiers pdf :**

   - Pour les fichiers `.pdf.dvc`

      **Télécharger des fichiers pdf spécifiques avec :**

      ```bash
      lunch files "<premier/chemin/fichier/dvc/placeholder.pdf.dvc>" "[deuxième/chemin/fichier/dvc/placeholder.pdf.dvc]"
      ```

      où vous pouvez mettre plusieurs chemins de fichiers, seul le premier est requis.

      Cette commande obtiendra les fichiers `.pdf` et les mettra dans votre répertoire actuel.

      > [!WARNING]
      > **`/` ou `\` comme séparateurs dans les chemins ?**
      >
      > `Linux` n'accepte que `/`
      >
      > `Windows` accepte les deux.

      > [!WARNING]
      > Est-il nécessaire de mettre les chemins entre guillemets `""` ?
      >
      > Oui, c'est nécessaire. Parce que beaucoup de chemins ont des répertoires et/ou des fichiers avec des espaces. **Si vous ne mettez pas le chemin entre guillemets `""`, la commande ne fonctionnera pas.**

      > [!TIP]
      > **Exemple d'Utilisation avec chemins absolus :**
      > Supposons que `chemin_actuel` == `"D:\coding-workspace\lunch-stem"`
      > 
      > ```bash
      > lunch files "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > Télécharge `3 - OS, Virtual Memory, OS Abstractions.pdf`, `4 - Bounded Buffers, Concurrency, Locks.pdf` et `5 - Threads, Condition Variables, Preemption.pdf` dans `chemin_actuel`.

      > [!TIP]
      > **Exemple d'Utilisation avec chemins relatifs (relatifs au chemin actuel dans lequel vous exécutez la commande) :**
      > Supposons que `chemin_actuel` == `"D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b"`
      > 
      > ```bash
      > lunch files "3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > Télécharge `3 - OS, Virtual Memory, OS Abstractions.pdf`, `4 - Bounded Buffers, Concurrency, Locks.pdf` et `5 - Threads, Condition Variables, Preemption.pdf` dans `chemin_actuel`.


      Si vous voulez mettre les fichiers au même endroit que le fichier `pdf.dvc`, utilisez :

      ```bash
      lunch files "<premier/chemin/fichier/dvc/placeholder.pdf.dvc>" "[deuxième/chemin/fichier/dvc/placeholder.pdf.dvc]" --in-place
      ```

      - _Note 1 :_ le premier argument de chemin de fichier est requis, les autres sont optionnels.
      - _Note 2 :_ le chemin de fichier utilisé dans cette commande ne devrait pas avoir `.source.json` à la fin. Il devrait se terminer par `.pdf.dvc`.
      - _Note 3 :_ d'autres types de fichiers (ex. `.txt`) devraient être ouverts directement, sans utiliser le CLI lunch.
      - _Note 4 :_ si `.web.txt` est présent, alors vous ne devriez pas essayer cette commande, copiez et collez simplement le lien dans `.web.txt` dans votre navigateur. Nous implémenterons un `lunch get` plus tard pour obtenir des fichiers depuis le web.
      - _Note 5 :_ le fichier `.pdf` ne devrait pas être visible avant d'exécuter cette commande.
      - _Note 6 :_ vous pouvez obtenir les chemins de fichiers via l'interface graphique de votre Système d'Exploitation, chaque système d'exploitation a une façon facile.


      **Télécharger tous les fichiers d'un dossier spécifique via :**

      ```bash
      lunch folder "<chemin/dossier/placeholder>"
      ```

      Si vous voulez mettre les nouveaux fichiers pdf au même endroit que leurs fichiers `pdf.dvc` correspondants, utilisez :

      ```bash
      lunch folder "<chemin/dossier/placeholder>" --in-place
      ```

      Si vous voulez télécharger tous les fichiers de tous les sous-répertoires (récursivement), utilisez :

      ```bash
      lunch folder "<chemin/dossier/placeholder>" --recursive
      ```

      Si vous voulez mettre les fichiers au même endroit que le fichier `pdf.dvc` et pour tous les sous-répertoires, utilisez :

      ```bash
      lunch folder "<chemin/dossier/placeholder>" --in-place --recursive
      ```
      Pour le débogage, utilisez le flag `--verbose`.

   - Pour les fichiers `pdf.web.txt` :

      Ouvrez simplement le fichier et suivez le lien web à l'intérieur.

   - Pour les fichiers `.sym.txt` :

      Ouvrez simplement le fichier et naviguez vers le chemin de fichier ou de dossier écrit à l'intérieur. Ce fichier ou dossier sera dans le `__Loopback`.

> [!WARNING]
> **⚠️ Important**
> 
> Les documents dans *lunchSTEM* sont créés par des auteurs externes, pas par nous. Nous ne soutenons pas l'inclusion de documents non-distribuables sans autorisation de l'auteur (pour les documents non-distribuables : vérifiez `author_permissions.jsonl`).
> 
> Chaque document crédite son/ses auteur(s) dans un fichier correspondant `<nom_fichier>.<extension_fichier>.source.json`.
> 
> Les auteurs peuvent demander la suppression de contenu à tout moment. Après avoir suivi notre protocole simplifié pour les *Demandes de Suppression de Contenu*, nous supprimons le contenu dans les 24 heures. Cette option est plus rapide et plus conviviale qu'une notification *Digital Millennium Copyright Act (DMCA)* (qui peut fermer le projet).

> [!NOTE]
> **🟩 Bientôt Disponible**
> 
> • **Site Web** avec pages d'accueil d'auteurs, recherche par mots-clés/sémantique, forums de discussion sur les documents, aperçus de contenu, visualisations de contenu interactives, étoiles/tags/favoris de contenu, prise de notes sur les documents, documents tendance/populaires, statistiques pour les documents et auteurs, et plus.
> 
> • **Serveur MCP :** utile pour les Agents IA effectuant des travaux d'ingénierie complexes ou de la recherche scientifique.
> 
> • **CLI approprié** où les utilisateurs peuvent faire des recherches par mots-clés et sémantiques.

## 📁 Structure des Répertoires et Conventions de Nommage

- Le répertoire **`__Loopback`** contient des fichiers qui avaient un chemin trop long. Un fichier pointeur `.sym.txt` a été créé à la place de ces fichiers pointant vers le fichier réel situé dans le répertoire `__Loopback`. Ces fichiers txt pointeurs suivent cette convention de nommage : `nom_fichier.extension_fichier.sym.txt` et sont situés dans le même répertoire où le fichier réel devrait être.

- Le fichier **`to_add.txt`** à la racine contient des liens vers des matériaux à inclure plus tard dans lunchSTEM.

- Les fichiers ou dossiers commençant par **MEGA** indiquent des matériaux agrégateurs (matériaux qui agrègent un tas de liens concernant un sujet spécifique).

- Les fichiers ou dossiers commençant par **Awesome** indiquent un contenu de très haute qualité.

## 🔬 Couverture des Domaines _STEM_

### Domaines les Plus Forts

*lunchSTEM* est pour le moment plus complet dans les domaines de l'`Informatique et Ingénierie` et de l'`IA` spécifiquement.

### Domaines les Plus Faibles

Les domaines des `Sciences Fondamentales` (Physique, Chimie, Biologie, Économie) sont notablement plus superficiels en termes de profondeur de leur arbre de sujets.

## 🤝 Contributions

Si vous voulez contribuer au projet, consultez notre [CONTRIBUTING.md](https://github.com/Freelunch-AI/lunch-stem/blob/main/CONTRIBUTING.md).

> [!WARNING]
> Le fichier de compte de service GCP est volontairement public dans ce dépôt, il n'a que des droits de lecture sur le dossier Google Drive contenant les pdfs.
>
> Nous savons que ce n'est pas une bonne pratique de les rendre publiquement disponibles, mais c'était le moyen de pouvoir exploiter notre abonnement Google Drive existant (sans avoir à créer un backend globalement évolutif).
>
> Nous allons bientôt migrer vers un bucket S3 public, et alors, ce petit "hack" sera supprimé.

## 🗺️ Tentative de Feuille de Route

> **Note :** Les étapes avec la même **[lettre]** peuvent être faites en parallèle.

### Phase A : Problèmes Fondamentaux

1. **[b][a]** Créer une convention de nommage de branches et des règles de branches.

2. **[a]** Résoudre les problèmes urgents de copyright et d'attribution de crédit liés aux fichiers réels stockés
   - Créer un script CI qui construit une liste de chemins `.source.json` qui n'ont pas d'info d'auteur - ceux-ci devraient être prioritaires.

3. **[a]** Remplacer les fichiers réels (et les liens de page d'accueil/point d'entrée) par des liens pour obtenir les fichiers directement depuis leur hôte original (utiliser un agent IA utilisant un navigateur pour aider avec cela). L'objectif est que la plupart des fichiers soient `nom_fichier.extension_fichier.web.txt` avec le lien à l'intérieur (c'est-à-dire, fichier hébergé externement). Les utilisateurs peuvent toujours contribuer avec des fichiers réels s'ils sont les auteurs de ces fichiers (comme le fait *arXiv*) car sous le capot nous utiliserons toujours DVC pour les fichiers réels.

4. **[a]** Implémenter des liens symboliques appropriés qui fonctionnent sur tous les Systèmes d'Exploitation. Plus de recherche manuelle du chemin dans le fichier `.sym.txt` et d'aller manuellement à ce répertoire. Aussi implémenter des liens web faciles, pour éviter le copier/coller manuel des chemins dans `.web.txt` vers le navigateur.

### Phase B : Ajouts Importants

5. **[b][a]** Créer un package/installable *CLI lunchSTEM* approprié (pas en bash, avec docstrings, modulaire, avec tests, compilé) où vous pouvez :
   1. Obtenir des fichiers ou répertoires depuis le web.
   2. Cacher/Montrer certains types de fichiers (ex., cacher : .dvc, .source.json, .prerequisites.json, liens symboliques pour d'autres systèmes d'exploitation, etc)
   3. Faire une recherche : recherche par mots-clés et recherche sémantique

6. **[b]** Créer un *Serveur MCP lunchSTEM* : d'abord, besoin de créer une version `.md` de chaque `.pdf`

7. **[b][a]** Créer un site web pour faciliter la consommation de *lunchSTEM* par les humains, où les utilisateurs peuvent :
   1. Visualiser et naviguer dans le dépôt comme un graphique
   2. Utiliser la recherche par mots-clés, basée sur des filtres et sémantique
   3. Voir un aperçu des documents sans avoir à les ouvrir
   4. Ouvrir des documents directement dans le navigateur
   5. Étoiler un document
   6. Faire leur propre étiquetage/favoris sur les matériaux, qui ne sera visible que pour eux.
   7. Faire des surlignages et notes sur les matériaux qui ne seront visibles que pour eux
   8. Voir les pages d'accueil d'auteurs qui lient à tous les matériaux d'un auteur spécifique.
   9. S'engager dans des forums de discussion sur des documents spécifiques
   10. Voir des documents et auteurs tendance/populaires
   11. Voir des statistiques pour les documents et auteurs

8. **[b]** Obtenir des sponsors et subventions pour : (1) soutenir notre hébergement d'application ; (2) construire une équipe dédiée de mainteneurs *lunchSTEM* ; (3) payer des experts pour des processus de révision par les pairs ; et (4) pour acheminer un pourcentage de l'argent vers les auteurs contributeurs. Tout l'argent de sponsoring serait réinvesti dans le projet, c'est un projet à but non lucratif.

9. Créer des Workflows CI

   1. **[b][a]** Remplacer les fichiers `.pdf` réels par des fichiers `.pdf.dvc`, évitant les fichiers de connaissance réels dans le dépôt.

   2. **[b][a]** Ajouter la suppression de fichiers malveillants, suppression de gros fichiers, suppression de dépôt git, suppression de fichiers avec des extensions non-acceptées, suppression de matériel protégé par copyright, etc pour éviter automatiquement les mauvaises PR.

   3. **[b][a]** Ajouter l'application des conventions standards dans CI pour garder la base de connaissances cohérente, évitant les PR incohérentes.

### Phase C : Plus de Fonctionnalités Principales

10. **[b][c][d]** Ajouter des fonctionnalités à *lunchSTEM*, potentiellement en utilisant *AgentPool* pour aider (en parallèle : continuer à ajouter plus de matériaux depuis `to_add.txt`, mais ajouter comme `nom_fichier.extension_fichier.web.txt` avec le lien HTTPS dans le fichier) :
    - **Prérequis :** Ajouter `<nom_fichier>.<extension_fichier>.prerequisites.json` contenant une liste hiérarchique de prérequis pour chaque fichier
    - **Exercices :** Mettre des exercices avec solutions dans chaque répertoire de sujet dans `__Exercises`
    - **Outils :** mettre des outils logiciels dans chaque sujet dans `__Tools`. Peuvent être des outils pour faire ou comprendre quelque chose lié au sujet.
    - **Parcours d'apprentissage et de certification :** parcours séquentiels guidés (ex., parcours Ingénieur ML) avec temps de completion estimé de 3 ou 6 mois, et avec un examen/certification interne ou externe à la fin.
    - **Projets Exemples :** Mettre des projets exemples dans chaque répertoire de sujet dans `__Sample Projects`
    - **Assistant IA dans le CLI lunchSTEM pour rendre votre doc plus facile à comprendre** : peut ajouter des diagrammes, notebook, nous écrivons avec des mots plus faciles à comprendre, faire des exemples, etc. Un dataset d'entraînement/prompting peut être généré en dégradant synthétiquement exprès de bons matériaux d'apprentissage.
    - **Tuteur IA qui utilise lunchSTEM comme base de connaissances** : tuteur qui peut faire des guides d'étude personnalisés, expliquer des blocs de texte en enseignant tous ses prérequis requis, faire des matériaux interactifs personnalisés, etc
    - **Réviseur par les Pairs IA qui utilise lunchSTEM comme base de connaissances** : construire un Agent IA capable de réviser de nouveaux documents *STEM* inclus dans les PR (et qui ne sont pas dans la liste des sources respectées), pour éviter de devoir s'appuyer sur des révisions par les pairs humaines qui sont lentes et coûteuses. Les Révisions par les Pairs Humaines devraient alors être faites annuellement pour attraper les erreurs du Réviseur par les Pairs IA et générer des données pour améliorer le Réviseur par les Pairs IA sur ses points faibles.
    - **Université lunchSTEM :** université gratuite, en ligne pour les personnes qui préfèrent des délais stricts, responsabilités et apprendre avec d'autres. Pas d'examens. Chaque année, les étudiants construiront des technologies ou méthodes existantes à partir de zéro, inspiré par [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) avec une monographie avec tous les détails importants et la partager avec la communauté via un article de blog. Les étudiants finissent l'université avec un portfolio stellaire à montrer. Approche d'enseignement descendante où nous aidons les étudiants à apprendre des sujets à la demande quand ils en ont besoin pour construire quelque chose.

### Phase D : Améliorations Agréables à Avoir

11. **[d]** Migrer depuis *Google Drive* (je payais déjà pour 2TB, c'est pourquoi je l'ai utilisé) vers une meilleure option de stockage (ex., *S3*).

12. **[d]** Créer *AgentPool* : équipe d'agents divers qui font des PR au dépôt *lunchSTEM* après des discussions internes, posant des questions aux humains et évaluant les changements proposés en affinant des SLM. Les agents sont continuellement modifiés pour assurer la diversité et améliorer leur intelligence basée sur les nouvelles connaissances approuvées ajoutées à *lunchSTEM*.

## 🗑️ Demandes de Suppression de Contenu et d'Attribution de Crédit

Un gros effort a été fait pour détecter et supprimer le contenu protégé par copyright (non-distribuable), et pour reconnaître les auteurs/éditeurs/universités des matériaux restants. La révision manuelle de chaque fichier n'a pas pu être faite à cause de la quantité énorme de fichiers (mais nous accueillons la communauté pour nous aider avec cela en ouvrant des issues et PR).
1. Nous avons exécuté des scripts pour supprimer tout fichier contenant toute autre extension en dehors de : `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. Nous avons exécuté des scripts pour la détection automatisée de mots-clés liés au copyright dans les documents et la suppression de tels documents
3. Nous avons exécuté des scripts pour la suppression automatisée d'articles académiques.
4. Nous avons manuellement remplacé chaque pdf de livre par un lien vers celui-ci.
5. Nous avons exécuté des scripts pour la création automatisée d'un fichier d'attribution de crédit (`.source.json`) pour chaque pdf restant, avec des infos telles que : auteurs, lien vers la source, modifié ou non, etc. La valeur par défaut des champs est `null`, à l'exception de la valeur par défaut du champ `changes_were_made` qui est `False`. Les valeurs par défaut sont utilisées quand l'info ne peut pas être trouvée dans le pdf lui-même.

Cependant, nous ne pouvons pas garantir la perfection dans ce processus, donc, si vous trouvez du contenu protégé par copyright ou du contenu sans données d'attribution de crédit appropriées, merci d'ouvrir une issue et/ou faire une PR et/ou envoyer un email à bruno.c.scaglione@gmail.com. Nous visons à résoudre le problème en 24h. Référez-vous au fichier `CONTRIBUTING.md` pour les directives à ce sujet.

> **Protocole Simplifié pour les Demandes de Suppression de Contenu (Recommandé plutôt que _DMCA_)**
   > 1. Lire CONTRIBUTING.md pour voir les directives d'issue
   > 2. Ouvrir une issue de *demande de suppression de contenu*
   > 3. Envoyer un email à bruno.c.scaglione@gmail.com avec le sujet "[lunchSTEM] Demande de Suppression de Contenu : #NUMÉRO_ISSUE_GITHUB_PLACEHOLDER" expliquant : qui vous êtes, le chemin du/des contenu(s) que vous devez faire supprimer et lien vers l'issue spécifique que vous avez ouverte.

<br>

> Cette option est __plus rapide et plus conviviale qu'une notification *DMCA*__. Si nous recevons plusieurs notifications *DMCA*, le projet risque d'être supprimé de *Github* (même après avoir retiré les contenus) et beaucoup de personnes qui pourraient en bénéficier seront affectées.

***Conformité Digital Millennium Copyright Act* (*DMCA*) :** nous nous conformons au Digital Millennium Copyright Act (DMCA). Pour les demandes de retrait formelles, merci de suivre le processus *DMCA*.

## 📝 Attribution de Crédit 

Les données d'attribution de crédit d'un fichier pdf sont stockées dans `<nom_fichier>.pdf.source.json` qui devrait être ouvert directement (sans `dvc pull`). Ce fichier peut contenir les auteurs, université, éditeur, lien vers la source, et autres métadonnées sur le fichier spécifique qu'il référence. La valeur par défaut des champs est `null`, à l'exception de la valeur par défaut du champ `changes_were_made` qui est `False`.

## ⚖️ Clause de Non-responsabilité et Conditions

**BASE TEL QUEL :** Ce projet est fourni "tel quel" sans garanties d'aucune sorte. Nous ne faisons aucune représentation sur l'exactitude, la complétude ou la légalité du contenu.

**LIMITATION DE RESPONSABILITÉ :** Dans la mesure maximale permise par la loi, les mainteneurs du projet ne seront pas responsables de tout dommage découlant de l'utilisation de ce dépôt.

**CONDITIONS DE SERVICE :** En utilisant ce dépôt, vous acceptez de respecter les lois sur le copyright, d'utiliser le contenu à des fins éducatives uniquement, et de vous conformer à toutes les lois applicables dans votre juridiction.

**AUCUN CONSEIL JURIDIQUE :** Rien dans ce dépôt ne constitue un conseil juridique, financier ou professionnel.

**But Éducatif :** Ce projet vise à fournir un accès organisé aux matériaux éducatifs à des fins non-commerciales et éducatives. Nous croyons que de nombreuses utilisations du contenu peuvent qualifier pour les protections d'usage équitable, mais les déterminations d'usage équitable sont faites cas par cas par les tribunaux.

## 💎 Sponsors

__Vous voulez être un sponsor ? Envoyez un email à bruno.c.scaglione@gmail.com avec le sujet "[lunchSTEM] Sponsorship"__ 

## [Freelunch](https://freelunch.dev)

![Logo Freelunch](./sponsors/freelunch/logo_freelunch_with_name.png)

## 🙏 Remerciements

À tous les auteurs qui ont rendu leur contenu publiquement disponible.

À nos premiers testeurs.

À nos contributeurs, mainteneurs et sponsors qui gardent le projet vivant et en évolution.
