
<p align="center">
   <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="lunchSTEM Logo" width="300"/>
</p>

<h1 align="center">Democratizing <i>STEM</i> knowledge in an organized manner</h1><br>

<p align="center">
   <strong>🌟 Non-profit, open source project (v0.1.0) 🌟</strong>
</p>

<p align="center">
   <em>Think of a better Wikipedia for <i>STEM</i>.<br>
   It's like FreeCodeCamp, but for documents (and not just for Software Engineering).</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Join%20Our%20Community-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
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

<h2 align="center">⭐ Star the Project</h2>

If you find lunchSTEM useful, please consider giving us a star on GitHub! It helps us reach more people and keeps us motivated.

<p align="center">
   <a href="https://github.com/Freelunch-AI/lunch-stem">
      <img src="assets/star-github.png" alt="Give a star to a Github project" width=200>
   </a> <br>
   <em>Example Image</em>
</p>

---

## 📚 Table of Contents

- [🔍 Overview](#-overview)
- [🎯 Who is this for?](#-who-is-this-for)
- [� Project Statistics](#-project-statistics)
- [⚙️ Requirements for Usage](#-requirements-for-usage)
- [🚀 How to Use](#-how-to-use)
- [📁 Directory Structure and Naming Conventions](#-directory-structure-and-naming-conventions)
- [🔬 Coverage of STEM Fields](#-coverage-of-stem-fields)
- [🤝 Contributions](#-contributions)
- [🗺️ Roadmap Attempt](#-roadmap-attempt)
- [🗑️ Content Removal and Credit Attribution Requests](#-content-removal-and-credit-attribution-requests)
- [📝 Credit Attribution](#-credit-attribution)
- [⚖️ Disclaimer & Terms](#-disclaimer--terms)
- [💎 Sponsors](#-sponsors)
- [🙏 Acknowledgements](#-acknowledgements)

## 🔍 Overview

This is an evolving *STEM* (Science, Technology, Engineering and Mathematics) knowledge base, meant to be reviewed and improved with the effort of the community. It can be used and improved by humans and AI agents.

Its ideal use-case is to be used to **go deep into a *STEM* topic (and related topics) after you have an initial understanding of it** (which you can easily get via Google Search or AI Assistants).

It should be more organized and higher-quality (signal-to-noise ratio) than default Google search/AI deep research for this use-case. 

The goal is to, later on, enable AI agents to easily use it as a tool by making a *lunchSTEM MCP Server*.

## 🎯 Who is this for?

- **Students** looking for supplementary learning materials
- **Professionals** wanting to deepen their STEM knowledge
- **Researchers** needing organized reference materials
- **Educators** searching for teaching resources
- **Self-learners** pursuing independent study

## 📊 Project Statistics

- **Size:** 60+ GB (including a lot of links)
- **Number of pdf files** 10k+
- **Number of sub-topics** 6k+
- **Language of materials:** English

## ⚙️ Requirements for Usage

Make sure you have these tools installed:

- `git`
- `rclone`

These can be installed by following their respective installation guide on their websites.

- [git installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [rclone installation guide](https://rclone.org/install/)

> [!NOTE]
> When configuring a remote storage for _rclone_, make shure to use the service account option and `lunch-stem-fadf503639fe.json` as the service account file.
>
> Also, when installing *rclone*, *Windows* users might see a security warning, it's normal.

## 🚀 How to Use

1. **Open a terminal**: To open the terminal, use your operating system's search function (by pressing the Windows key or Cmd + Space bar on Mac) and type "terminal," "Command Prompt," or "Windows Terminal" and select the app

2. **Clone the repo with git** (this command will create a `lunch-stem` folder in your current directory)

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > If you are using Windows, it's important to clone inside a top-level directory, to avoid potential errors related to the creating file paths that are too long. Windows typically has a maximum file path of 260 characters.

   > [!NOTE]
   > The `git clone` command will copy the project in your machine with the entire folder structure already in place.

3. Enter the `lunch-stem` folder

   ```bash
   cd lunch-stem
   ```

4. Setup the project

   **For Linux**

   Configure rclone

   Enable script execution

   ```bash
   chmod +x scripts/setup 
      ```

   Run setup script

   ```bash
   source scripts/setup 
      ```

   You should see `Setup complete!` message printed in the terminal, along with other details.

   **For Windows:**

   Enable execution of scripts within the terminal session

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   Run setup script

   ```powershell
   scripts/setup.ps1
      ```

   You should see `Setup complete!` message printed in the terminal, along with other details.

5. **Browse inside the `ai2f` folder**

   `ai2f` folder structure:

         ├── __Loopback
         ├── Computer Science and Engineering 
         ├── Hardcore Engineering 
         ├── Hardcore Science  
         └── Mathematics

6. **Download pdf files:**

   - For `.pdf.dvc` files

      **Download specific pdf files with:**

      ```bash
      lunch files "<first/dvc/file/path/placeholder.pdf.dvc>" "[second/dvc/file/path/placeholder.pdf.dvc]"
      ```

      where you can put multiple file paths, only the first is required.

      This command will get the `.pdf` files and put it in your current directory.

      > [!TIP]
      > **Example Usage:**
      > 
      > ```bash
      > lunch files "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > Downloads `3 - OS, Virtual Memory, OS Abstractions.pdf`, `4 - Bounded Buffers, Concurrency, Locks.pdf` and `5 - Threads, Condition Variables, Preemption.pdf` in the directory the command was run.


      If you want to put files in the same place as the `pdf.dvc ` file then use:

      ```bash
      lunch files "<first/dvc/file/path/placeholder.pdf.dvc>" "[second/dvc/file/path/placeholder.pdf.dvc]" --in-place
      ```

      - _Note 1:_ first file path argument is required, the rest are optional.
      - _Note 2:_ the file path used in this command shouldn't have `.source.json` at the end of it. it should end with `.pdf.dvc`.
      - _Note 3:_ other types of files (e.g. `.txt`) should be opened directly, without using the lunch CLI.
      - _Note 4:_ if `.web.txt` is present, then you shouldn't try this command, just copy and paste the link inside `.web.txt` in your browser. We will implement a `lunch get` later on to get files from the web.
      - _Note 5:_ the `.pdf` file shouldn't be visible before you run this command.
      - _Note 6:_ you can get the file paths via the graphical user interface of your Operating System, each operating system has an easy way.


      **Download all the files from a specific folder via:**

      ```bash
      lunch folder "<folder/path/placeholder>"
      ```

      If you want to put the new pdf files in the same place as ther corresponding `pdf.dvc` files then use:

      ```bash
      lunch folder "<folder/path/placeholder>" --in-place
      ```

      If you want to download all the files from all subdirectories (recursively) then use:

      ```bash
      lunch folder "<folder/path/placeholder>" --recursive
      ```

      If you want to put files in the same place as the `pdf.dvc ` file and for all subdirectories then use:

      ```bash
      lunch folder "<folder/path/placeholder>" --in-place --recursive
      ```
      For debugging, use the `--verbose` flag.

   - For `pdf.web.txt` files:

      Simply open the file and follow the web link inside it.

   - For `.sym.txt` files:

      Simply open the file and navigate to the file or folder path written inside it. This file or folder will be inside the `__Loopback`.

> [!WARNING]
> **⚠️ Important**
> 
> Documents in *lunchSTEM* are created by external authors, not by us. We don't support inclusion of non-distributable documents without author permission (for non-distributable documents: check `author_permissions.jsonl`).
> 
> Each document credits its author(s) in a corresponding `<file_name>.<file_extension>.source.json` file.
> 
> Authors may request content removal at any time. After following our streamlined protocol for *Content Removal Requests*, we remove content within 24 hours. This option is faster and more friendly than a *Digital Millennium Copyright Act (DMCA)* notification (which can shutdown the project).

> [!NOTE]
> **🟩 Coming Soon**
> 
> • **Website** with author homepages, keyword/semantic search, discussion forums on top of documents, content previews, interactive content visualizations, content starring/tagging/favouriting, making notes on top of documents, trending/popular documents, statistics for documents and authors, and more.
> 
> • **MCP Server:** useful for AI Agents doing complex engineering work or scientific research.
> 
> • **Proper CLI** where users can do keyword and semantic search.

## 📁 Directory Structure and Naming Conventions

- **`__Loopback`** directory contains files that had a path that was too long. A pointer `.sym.txt` file was created in place of these files pointing to the actual file located inside the `__Loopback` directory. These pointer txt files follow this naming convention: `file_name.file_extension.sym.txt` and are located in the same directory where the actual file should be.

- **`to_add.txt`** file at root contains links to materials to be included later in lunchSTEM.

- Files or folders starting with **MEGA** indicate aggregator materials (materials that aggregate a bunch of links regarding a specific topic).

- Files or folders starting with **Awesome** indicate super high quality content.

## 🔬 Coverage of _STEM_ Fields

### Strongest Fields

*lunchSTEM* is at the moment more complete in the fields of `Computer Science & Engineering` and `AI` specifically. 

### Weakest Fields

The fields of `Hardcore Science` (Physics, Chemistry, Biology, Economics) are notably more superficial in terms of the depth of their tree of topics.

## 🤝 Contributions

If you want to contribute to the project, check out our [CONTRIBUTING.md](https://github.com/Freelunch-AI/lunch-stem/blob/main/CONTRIBUTING.md).

> [!WARNING]
> The GCP service account file is purposely public in this repo, it only has read rights to the Google Drive folder containing the pdfs.
>
> We know it's not good practice to make them publicly available, but it was the way to be able to leverage our existing Google Drive subscription (without having to make globally scalable backend).
>
> We will soon move to a public S3 bucket, and then, this little "hack" will be removed.

## 🗺️ Roadmap Attempt

> **Note:** Steps with the same **[letter]** can be done in parallel.

### Phase A: Fundamental Problems

1. **[b][a]** Create branch naminging convention and branch rules.

2. **[a]** Solve urgent copyright and credit attribution issues related to actual files being stored
   - Make CI script that builds a list of `.source.json` paths that don't have author info - these should be priority.

3. **[a]** Replace actual files (and homepage/entrypoint links) with links to get the files directly from their original host (use a browser-using AI agent to help with this). The goal is for most files to be `file_name.file_extension.web.txt` with the link inside of it (i.e., file hosted externally). Users can still contribute with actual files if they are the authors of these files (like *arXiv* does) because under the hood we will still be using DVC for actual files.

4. **[a]** Implement proper symlinks that work across Operating Systems. No more manually looking the path inside the `.sym.txt` file and manually going to that directory. Also implementing easy weblinks, to avoid manual copy/paste of paths inside `.web.txt` to the browser.

### Phase B: Important Additions

5. **[b][a]** Create a proper (not in bash, with docstrings, modular, with tests, compiled) *lunchSTEM CLI* package/installable where you can:
   1. Get files or directories (already implemented in a basic way)
   2. Hide/Show certain file types (e.g., hide: .dvc, .source.json, .prerequisites.json, symlinks for other operating systems, etc)
   3. Do search: keyword search and semantic search

6. **[b]** Make a *lunchSTEM MCP Server*: first, need to create a `.md` version of each `.pdf`

7. **[b][a]** Make a website to ease *lunchSTEM* consumption by humans, where users can:
   1. Visualize and navigate the repo as a graph
   2. Use keyword, filter-based and semantic search
   3. See preview of documents without having to open them
   4. Open documents directly in the browser
   5. Star a document
   6. Make their own tagging/favouriting on top of the materials, that will only be visible to them.
   7. Make highlights and notes on materials that will only be visible to them
   8. See author homepages that link to all materials of a specific author.
   9. Engage in discussions forums on top of specific documents
   10. See trending/popular documents and authors
   11. See statistics for documents and authors

8. **[b]** Get sponsors and grants to: (1) support our app hosting; (2) build a dedicated team of *lunchSTEM* maintainers; (3) pay experts for peer-review processes; and (4) to route a percentage of the money to contributing authors. All sponsorship money would be reinvested in the project, it's a non-profit project.

9. Make CI Workflows

   1. **[b][a]** Replace actual `.pdf` files with `.pdf.dvc` files, avoiding actual knowledge files in the repo.

   2. **[b][a]** Add malicious file removal, large file removal, git repo removal, removal of files with not-accepted extensions, copyrighted material removal, etc to automatically avoid bad PRs.

   3. **[b][a]** Add standard conventions enforcement in CI to keep the knowledge base consistent, avoiding inconsistent PRs.

### Phase C: More Core Features

10. **[b][c][d]** Add features to *lunchSTEM*, potentially using *AgentPool* to help (in parallel: keep adding more materials from `to_add.txt`, but add as `file_name.file_extension.web.txt` with the HTTPS link inside the file):
    - **Prerequisites:** Add `<file_name>.<file_extension>.prerequisites.json` containing hierarchical list of prerequisites for each file
    - **Exercises:** Put exercises with solutions in every topic directory inside `__Exercises`
    - **Tools:** put software tools in very topic inside `__Tools`. Can be tools for doing or understanding something related to the topic.
    - **Learning & Certification tracks:** guided sequential tracks (e.g., ML Engineer track) with estimated completion time of 3 or 6 months, and with an internal or external exam/certification in the end.
    - **Sample Projects:** Put sample projects in every topic directory inside `__Sample Projects`
    - **AI Assistant inside lunchSTEM CLI for making your doc easier to understand**: can add diagrams, notebook, we write in easier to understand words, make examples, etc. A training/prompting dataset can be generated by synthetically worsening good learning materials on purpose.
    - **AI Tutor that uses lunchSTEM as it's knowledge base**: tutor that can make custom study guides, explain blobs of text giving teaching all its requires prerequisites, make custom interactive materials, etc
    - **AI Peer-Reviewer that uses lunchSTEM as it's knowledge base**: build an AI Agent capable of reviewing new *STEM* documents included in PRs (and that aren't in the list of respected sources), to avoid having to rely on human peer reviews which are slow and constly. Human Peer Reviews should then be done annually to catch AI Peer Reviewer mistakes and generate data to improve the AI Peer Reviewer on it's weak points.
    - **lunchSTEM University:** free, online university for people that prefer strict deadlines, responsabilities and learning with others. No exams. Each year, students will build existing technologies or methods from scratch, inspired by [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) together with a monography with all the important details and share it with the community via a blog post. Students finish the university with a stellar portfolio to show. Top-down teaching approach where we help students learn topics on-demand when they need it to build something.

### Phase D: Nice to Have Improvements

11. **[d]** Migrate from *Google Drive* (I was already paying for 2TB, so that's why I used it) to a better storage option (e.g., *S3*).

12. **[d]** Make *AgentPool*: team of diverse agents that make PRs to the *lunchSTEM* repo after internal discussions, asking humans questions and evaluating proposed changes by finetuning SLMs. Agents are continually modified to ensure diversity and to improve their intelligence based on approved new knowledge added to *lunchSTEM*.

## 🗑️ Content Removal and Credit Attribution Requests

A big effort was made to detect and remove copyrighted (non-distributable) content, and to recognize the authors/publishers/universities of the remaining materials. Manual review of each file couldn't be done because of the sheer amount of files (but we welcome the community to help us with this by, opening issues and PRs).
1. We ran scripts to delete any file containing any other extension outside of: `.pdf`, `.txt`, `.md`, `.ipynb`, `.json`
2. We ran scripts for automated detection of copyright-related keywords in documents and deletion of such documents
3. We ran scripts for automated removal of academic papers.
4. We manually replaced each book pdf for a link to it.
5. We ran scripts for automated creation of a credit attribution file (`.source.json`) for each remaining pdf, with info such as: authors, link to source, modified or not, etc. Default value of fields are `null`, with the exception of the default value of the `changes_were_made` field which is `False`. Default values are used when the info can't be found in the pdf itself.

However, we cannot guarantee perfection in this process, therefore, if you find any copyrighted content or content without proper credit attribution data, please open an issue and/or make a PR and/or send an email to bruno.c.scaglione@gmail.com. We aim to resolve the problem in 24h. Refer to the `CONTRIBUTING.md` file for the guidelines for this.

> **Streamlined Protocol for Content Removal Requests (Recommended over _DMCA_)**
   > 1. Read CONTRIBUTING.md to see issue guidelines
   > 2. Open a *content removal request* issue
   > 3. Send an email to bruno.c.scaglione@gmail.com with the subject "[lunchSTEM] Content Removal Request: #GITHUB_ISSUE_NUMBER_PLACEHOLDER" explaining: who you are, the path of the content(s) you need to be removed and link to the specific issue you opened.

<br>

> This option is __faster and more friendly than a *DMCA*__ notification. If we receive multiple *DMCA* notifications, the project risks being removed from *Github* (even after taking down the contents) and a lot of people that could benefit from it will be affected.

***Digital Millennium Copyright Act* (*DMCA*) Compliance:** we comply with the Digital Millennium Copyright Act (DMCA). For formal takedown requests, please follow the *DMCA* process.

## 📝 Credit Attribution 

Credit attribution data of a pdf file is stored in `<file_name>.pdf.source.json` which should be opened directly (without `dvc pull`). This file can contain authors, university, publisher, link do the source, and other metadata about the specific file it references. Default value of fields are `null`, with the exception of the default value of the `changes_were_made` field which is `False`.

## ⚖️ Disclaimer & Terms

**AS-IS BASIS:** This project is provided "as-is" without warranties of any kind. We make no representations about the accuracy, completeness, or legality of the content.

**LIMITATION OF LIABILITY:** To the maximum extent permitted by law, the project maintainers shall not be liable for any damages arising from the use of this repository.

**TERMS OF SERVICE:** By using this repository, you agree to respect copyright laws, use content for educational purposes only, and comply with all applicable laws in your jurisdiction.

**NO LEGAL ADVICE:** Nothing in this repository constitutes legal, financial, or professional advice.

**Educational Purpose:** This project aims to provide organized access to educational materials for non-commercial, educational purposes. We believe many uses of the content may qualify for fair use protections, but fair use determinations are made on a case-by-case basis by courts.

## 💎 Sponsors

__Want to be a sponsor? Send an email to bruno.c.scaglione@gmail.com with the subject "[lunchSTEM] Sponsorship"__ 

## [Freelunch](https://freelunch.dev)

![Freelunch Logo](./sponsors/freelunch/logo_freelunch_with_name.png)

## 🙏 Acknowledgements

To all the authors that made their content publicly available.

To our early testers.

To our contributors, maintainers and sponsors that keep the project alive and evolving.

