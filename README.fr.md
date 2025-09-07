<p align="center">
   <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="Logo lunchSTEM" width="300"/>
</p>

<h1 align="center">Démocratiser la connaissance <i>STEM</i> de manière organisée</h1><br>

<p align="center">
   <strong>🌟 Projet à but non lucratif et open source 🌟</strong>
</p>

<p align="center">
   <em>Pensez à un meilleur Wikipédia pour <i>STEM</i>.<br>
   C'est comme FreeCodeCamp, mais pour les documents (et pas seulement pour l'Ingénierie Logicielle).</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Rejoignez%20Notre%20Communauté-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
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

<br>

> [!WARNING]
> **⚠️ Important**
> 
> Les documents dans *lunchSTEM* sont créés par des auteurs externes, pas par nous. Nous ne soutenons pas l'inclusion de documents non distribuables sans l'autorisation de l'auteur (pour les documents non distribuables : vérifiez `author_permissions.jsonl`).
> 
> Chaque document crédite son/ses auteur(s) dans un fichier correspondant `[nom_fichier].[extension_fichier].source.json`.
> 
> Les auteurs peuvent demander la suppression de contenu à tout moment. Après avoir suivi notre protocole simplifié pour les *Demandes de Suppression de Contenu*, nous supprimons le contenu dans les 24 heures. Cette option est plus rapide et plus conviviale qu'une notification de la *Loi sur les Droits d'Auteur du Millénaire Numérique (DMCA)* (qui peut fermer le projet).

<br>

> [!NOTE]
> **🟩 Bientôt Disponible**
> 
> • **Site web** avec des pages d'auteurs, recherche par mots-clés/sémantique, forums de discussion sur les documents, aperçus de contenu, visualisations interactives de contenu, marquage/étiquetage/mise en favoris de contenu, prise de notes sur les documents, documents tendance/populaires, statistiques pour les documents et auteurs, et plus.
> 
> • **Serveur MCP :** utile pour les Agents IA effectuant du travail d'ingénierie complexe ou de la recherche scientifique.
> 
> • **CLI** où les utilisateurs peuvent faire des recherches par mots-clés et sémantiques.

## Aperçu

Ceci est une base de connaissances *STEM* (Science, Technologie, Ingénierie et Mathématiques) en évolution, destinée à être examinée et améliorée avec l'effort de la communauté. Elle peut être utilisée et améliorée par les humains et les agents IA.

Son cas d'usage idéal est d'être utilisée pour **approfondir un sujet *STEM* (et des sujets connexes) après avoir une compréhension initiale de celui-ci** (que vous pouvez facilement obtenir via Google Search ou les Assistants IA).

Elle devrait être plus organisée et de meilleure qualité (rapport signal/bruit) que la recherche Google par défaut/recherche IA approfondie pour ce cas d'usage.

L'objectif est, plus tard, de permettre aux agents IA de l'utiliser facilement comme outil en créant un *Serveur MCP lunchSTEM*.

## Demandes de Suppression de Contenu et d'Attribution de Crédits

Un grand effort a été fait pour détecter et supprimer le contenu protégé par des droits d'auteur (non distribuable), et pour reconnaître les auteurs/éditeurs/universités des matériaux restants. L'examen manuel de chaque fichier n'a pas pu être fait à cause du nombre énorme de fichiers (mais nous accueillons la communauté pour nous aider avec cela en ouvrant des issues et des PRs).
1. Nous avons exécuté des scripts pour supprimer tout fichier contenant toute autre extension en dehors de : `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. Nous avons exécuté des scripts pour la détection automatisée de mots-clés liés aux droits d'auteur dans les documents et la suppression de ces documents
3. Nous avons exécuté des scripts pour la suppression automatisée d'articles académiques.
4. Nous avons remplacé manuellement chaque pdf de livre par un lien vers celui-ci.
5. Nous avons exécuté des scripts pour la création automatisée d'un fichier d'attribution de crédits (`.source.json`) pour chaque pdf restant, avec des informations telles que : auteurs, lien vers la source, modifié ou non, etc. La valeur par défaut des champs est `null`, à l'exception de la valeur par défaut du champ `changes_were_made` qui est `False`. Les valeurs par défaut sont utilisées quand l'information ne peut pas être trouvée dans le pdf lui-même.

Cependant, nous ne pouvons pas garantir la perfection dans ce processus, donc, si vous trouvez du contenu protégé par des droits d'auteur ou du contenu sans données d'attribution de crédits appropriées, veuillez ouvrir une issue et/ou faire une PR et/ou envoyer un email à bruno.c.scaglione@gmail.com. Nous visons à résoudre le problème en 24h. Référez-vous au fichier `CONTRIBUTING.md` pour les directives à ce sujet.

> **Protocole Simplifié pour les Demandes de Suppression de Contenu (Recommandé par rapport à _DMCA_)**
   > 1. Lisez CONTRIBUTING.md pour voir les directives d'issues
   > 2. Ouvrez une issue de *demande de suppression de contenu*
   > 3. Envoyez un email à bruno.c.scaglione@gmail.com avec le sujet "[lunchSTEM] Demande de Suppression de Contenu : #NUMERO_ISSUE_GITHUB_PLACEHOLDER" expliquant : qui vous êtes, le chemin du/des contenu(s) que vous devez faire supprimer et le lien vers l'issue spécifique que vous avez ouverte.

<br>

> Cette option est __plus rapide et plus conviviale qu'une notification *DMCA*__. Si nous recevons plusieurs notifications *DMCA*, le projet risque d'être supprimé de *Github* (même après avoir retiré les contenus) et beaucoup de gens qui pourraient en bénéficier seront affectés.

**Conformité à la *Loi sur les Droits d'Auteur du Millénaire Numérique* (*DMCA*) :** nous nous conformons à la Loi sur les Droits d'Auteur du Millénaire Numérique (DMCA). Pour les demandes formelles de retrait, veuillez suivre le processus *DMCA*.

## Attribution de Crédits

Les données d'attribution de crédits d'un fichier pdf sont stockées dans `[nom_fichier].pdf.source.json` qui devrait être ouvert directement (sans `dvc pull`). Ce fichier peut contenir des auteurs, université, éditeur, lien vers la source, et d'autres métadonnées sur le fichier spécifique qu'il référence. La valeur par défaut des champs est `null`, à l'exception de la valeur par défaut du champ `changes_were_made` qui est `False`.

## Exigences pour l'Utilisation

Assurez-vous d'avoir ces outils installés :

- `git`
- `rclone`

Ceux-ci peuvent être installés en suivant leur guide d'installation respectif sur leurs sites web.

- [guide d'installation de git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [guide d'installation de rclone](https://rclone.org/install/)

> [!NOTE]
> Lors de la configuration d'un stockage distant pour _rclone_, assurez-vous d'utiliser l'option de compte de service et `lunch-stem-fadf503639fe.json` comme fichier de compte de service.

## Comment Utiliser

1.  **Ouvrez un terminal**: Pour ouvrir le terminal, utilisez la fonctionnalité de recherche de votre système d'exploitation (en appuyant sur la touche Windows ou Cmd + Espace sur Mac) et tapez "terminal", "invite de commandes" ou "Windows Terminal" et sélectionnez l'application.

2.  **Clonez le dépôt avec git** (cette commande créera un dossier `lunch-stem` dans votre répertoire actuel).

    ```bash
    git clone https://github.com/Freelunch-AI/lunch-stem.git
    ```
> [!NOTE]
> Si vous utilisez Windows, il est important de cloner dans un répertoire de niveau supérieur, pour éviter les erreurs potentielles liées à la création de chemins de fichiers trop longs. Windows a généralement un chemin de fichier maximum de 260 caractères.

3.  Entrez dans le dossier `lunch-stem`.

    ```bash
    cd lunch-stem
    ```

4.  **Parcourez le dossier `ai2f`**

5.  **Téléchargez un fichier pdf spécifique via:**

    ```bash
    dvc pull [placeholder_chemin_fichier_pdf]
    ```

    Cette commande récupérera le fichier `.pdf` et le placera au même endroit que le fichier `.pdf.dvc`.

    - _Note 1:_ le chemin de fichier utilisé dans cette commande ne doit pas avoir `.source.json` à la fin. il doit se terminer par `.pdf.dvc`.
    - _Note 2:_ les autres types de fichiers (par ex., `.txt`) doivent être ouverts directement, sans dvc.
    - _Note 3:_ si `.web.txt` est présent, alors vous ne devriez pas essayer cette commande, copiez et collez simplement le lien à l'intérieur de `.web.txt` dans votre navigateur. Nous implémenterons plus tard un `lunchstem pull` pour récupérer les fichiers du web.
    - _Note 4:_ le fichier `.pdf` ne devrait pas être visible avant que vous n'exécutiez cette commande.
    - _Note 5:_ vous pouvez obtenir le chemin du fichier via l'interface utilisateur graphique, chaque système d'exploitation a un moyen facile.

    Vous pouvez aussi télécharger plusieurs fichiers à la fois :

    ```bash
    dvc pull [premier_placeholder_fichier_pdf] [deuxième_placeholder_fichier_pdf]
    ```

## Structure des Répertoires et Conventions de Nommage

- Le répertoire **`__Loopback`** contient des fichiers qui avaient un chemin trop long. Un fichier pointeur `.sym.txt` a été créé à la place de ces fichiers pointant vers le fichier réel situé dans le répertoire `__Loopback`. Ces fichiers txt pointeurs suivent cette convention de nommage : `nom_fichier.extension_fichier.sym.txt` et sont situés dans le même répertoire où le fichier réel devrait être.

- Le fichier **`to-add.txt`** à la racine contient des liens vers des matériaux à inclure plus tard dans lunchSTEM.

- Les fichiers ou dossiers commençant par **MEGA** indiquent des matériaux agrégateurs (matériaux qui agrègent un tas de liens concernant un sujet spécifique).

- Les fichiers ou dossiers commençant par **Awesome** indiquent du contenu de super haute qualité.

## Notes

- *lunchSTEM* est pour le moment plus complet dans les domaines de l'Informatique et de l'IA spécifiquement. Les domaines de `Hardcore Science` sont notamment plus superficiels en termes d'arbre de sujets.

## Tentative de Feuille de Route

> **Note :** Les étapes avec la même **[lettre]** peuvent être faites en parallèle.

### Phase A : Problèmes Fondamentaux

1. **[a]** Résoudre les problèmes urgents de droits d'auteur et d'attribution de crédits liés aux fichiers réels étant stockés
   - Faire un script CI qui construit une liste de chemins `.source.json` qui n'ont pas d'informations d'auteur - ceux-ci devraient être prioritaires.

2. **[a]** Remplacer les fichiers réels (et les liens de page d'accueil/point d'entrée) par des liens pour obtenir les fichiers directement depuis leur hôte original (utiliser un agent IA utilisant un navigateur pour aider avec cela). L'objectif est que la plupart des fichiers soient `nom_fichier.extension_fichier.web.txt` avec le lien à l'intérieur (c'est-à-dire, fichier hébergé externement). Les utilisateurs peuvent toujours contribuer avec des fichiers réels s'ils sont les auteurs de ces fichiers (comme le fait *arXiv*) car en arrière-plan nous utiliserons toujours DVC pour les fichiers réels.

3. **[a]** Implémenter des liens symboliques appropriés qui fonctionnent sur tous les Systèmes d'Exploitation. Plus besoin de chercher manuellement le chemin dans le fichier `.sym.txt` et d'aller manuellement à ce répertoire. Aussi implémenter des liens web faciles, pour éviter le copier/coller manuel de chemins dans `.web.txt` vers le navigateur.

### Phase B : Ajouts Importants

4. **[b][a]** Créer un *CLI lunchSTEM* où vous pouvez :
   1. Tirer des fichiers/répertoires réels localement
   2. Cacher/Afficher certains types de fichiers (ex., cacher : .dvc, .source.json, .prerequisites.json, liens symboliques pour d'autres systèmes d'exploitation, etc)
   3. Faire une recherche : recherche par mots-clés et recherche sémantique

5. **[b]** Faire un *Serveur MCP lunchSTEM* : d'abord, besoin de créer une version `.md` de chaque `.pdf`

6. **[b][a]** Faire un site web pour faciliter la consommation de *lunchSTEM* par les humains, où les utilisateurs peuvent :
   1. Visualiser et naviguer dans le dépôt comme un graphique
   2. Utiliser la recherche par mots-clés, basée sur des filtres et sémantique
   3. Voir un aperçu des documents sans avoir à les ouvrir
   4. Ouvrir des documents directement dans le navigateur
   5. Mettre une étoile sur un document
   6. Faire leur propre étiquetage/mise en favoris sur les matériaux, qui ne sera visible que pour eux.
   7. Faire des surlignages et des notes sur les matériaux qui ne seront visibles que pour eux
   8. Voir des pages d'auteurs qui lient à tous les matériaux d'un auteur spécifique.
   9. S'engager dans des forums de discussion sur des documents spécifiques
   10. Voir des documents et auteurs tendance/populaires
   11. Voir des statistiques pour les documents et auteurs

7. **[b]** Obtenir des sponsors et des subventions pour : (1) soutenir notre hébergement d'application ; (2) construire une équipe dédiée de mainteneurs *lunchSTEM* ; (3) payer des experts pour les processus d'évaluation par les pairs ; et (4) router un pourcentage de l'argent vers les auteurs contributeurs. Tout l'argent de sponsoring serait réinvesti dans le projet, c'est un projet à but non lucratif.

8. **[b][a]** Ajouter la suppression de fichiers malveillants, la suppression de gros fichiers, la suppression de dépôts git, la suppression de fichiers de code, la suppression de matériel protégé par des droits d'auteur, etc dans CI via *GitHub Actions* pour éviter automatiquement les mauvaises PRs.

9. **[b][a]** Ajouter l'application de conventions standards dans CI pour garder la base de connaissances cohérente, évitant les PRs incohérentes.

### Phase C : Plus de Fonctionnalités Principales

10. **[b][c][d]** Ajouter des fonctionnalités à *lunchSTEM*, potentiellement en utilisant *AgentPool* pour aider (en parallèle : continuer à ajouter plus de matériaux depuis `to_add.txt`, mais ajouter comme `nom_fichier.extension_fichier.web.txt` avec le lien HTTPS à l'intérieur du fichier) :
    - **Prérequis :** Ajouter `[nom_fichier.[extension_fichier].prerequisites.json` contenant une liste hiérarchique de prérequis pour chaque fichier
    - **Exercices :** Mettre des exercices avec des solutions dans chaque répertoire de sujet à l'intérieur de `__Exercises`
    - **Outils :** mettre des outils logiciels dans chaque sujet à l'intérieur de `__Tools`. Peuvent être des outils pour faire ou comprendre quelque chose lié au sujet.
    - **Pistes d'Apprentissage et de Certification :** pistes séquentielles guidées (ex., piste Ingénieur ML) avec un temps de completion estimé de 3 ou 6 mois, et avec un examen/certification interne ou externe à la fin.
    - **Projets d'Exemple :** Mettre des projets d'exemple dans chaque répertoire de sujet à l'intérieur de `__Sample Projects`
    - **Assistant IA à l'intérieur du CLI lunchSTEM pour rendre votre document plus facile à comprendre** : peut ajouter des diagrammes, notebook, nous écrivons dans des mots plus faciles à comprendre, faire des exemples, etc. Un jeu de données d'entraînement/prompting peut être généré en dégradant synthétiquement de bons matériaux d'apprentissage exprès.
    - **Tuteur IA qui utilise lunchSTEM comme sa base de connaissances** : tuteur qui peut faire des guides d'étude personnalisés, expliquer des blocs de texte enseignant tous ses prérequis requis, faire des matériaux interactifs personnalisés, etc
    - **Évaluateur par les Pairs IA qui utilise lunchSTEM comme sa base de connaissances** : construire un Agent IA capable d'examiner de nouveaux documents *STEM* inclus dans les PRs (et qui ne sont pas dans la liste des sources respectées), pour éviter de devoir compter sur des évaluations par les pairs humaines qui sont lentes et coûteuses. Les Évaluations par les Pairs Humaines devraient alors être faites annuellement pour attraper les erreurs de l'Évaluateur par les Pairs IA et générer des données pour améliorer l'Évaluateur par les Pairs IA sur ses points faibles.
    - **Université lunchSTEM :** université gratuite en ligne pour les gens qui préfèrent des échéances strictes, des responsabilités et apprendre avec d'autres. Pas d'examens. Chaque année, les étudiants construiront des technologies ou méthodes existantes depuis zéro, inspirés par [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) ensemble avec une monographie avec tous les détails importants et la partageront avec la communauté via un article de blog. Les étudiants terminent l'université avec un portfolio stellaire à montrer. Approche d'enseignement top-down où nous aidons les étudiants à apprendre des sujets à la demande quand ils en ont besoin pour construire quelque chose.

### Phase D : Améliorations Agréables à Avoir

11. **[d]** Migrer de *Google Drive* vers une meilleure option de stockage (ex., *S3*).

12. **[d]** Faire *AgentPool* : équipe d'agents divers qui font des PRs au dépôt *lunchSTEM* après des discussions internes, posant des questions aux humains et évaluant les changements proposés par fine-tuning de SLMs. Les agents sont continuellement modifiés pour assurer la diversité et pour améliorer leur intelligence basée sur de nouvelles connaissances approuvées ajoutées à *lunchSTEM*.

## Avertissement et Conditions

**BASE EN L'ÉTAT :** Ce projet est fourni "en l'état" sans garanties d'aucune sorte. Nous ne faisons aucune représentation sur l'exactitude, la complétude ou la légalité du contenu.

**LIMITATION DE RESPONSABILITÉ :** Dans la mesure maximale permise par la loi, les mainteneurs du projet ne seront pas responsables de tout dommage découlant de l'utilisation de ce dépôt.

**CONDITIONS DE SERVICE :** En utilisant ce dépôt, vous acceptez de respecter les lois sur les droits d'auteur, d'utiliser le contenu à des fins éducatives uniquement, et de vous conformer à toutes les lois applicables dans votre juridiction.

**PAS DE CONSEIL JURIDIQUE :** Rien dans ce dépôt ne constitue un conseil juridique, financier ou professionnel.

**Objectif Éducatif :** Ce projet vise à fournir un accès organisé aux matériaux éducatifs à des fins éducatives non commerciales. Nous croyons que de nombreuses utilisations du contenu peuvent se qualifier pour les protections d'usage équitable, mais les déterminations d'usage équitable sont faites au cas par cas par les tribunaux.

## Sponsors

__Vous voulez être un sponsor ? Envoyez un email à bruno.c.scaglione@gmail.com avec le sujet "[lunchSTEM] Sponsoring"__ 

## [Freelunch](https://freelunch.dev)

![Logo Freelunch](./sponsors/freelunch/logo_freelunch_with_name.png)

## Remerciements

