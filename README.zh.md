<div align="center">

| | |
|:---:|:---:|
| <img src="./assets/logos/lunch_stem_light_logo_with_name.png" alt="lunchSTEM Logo" width="300"/> | <img src="./assets/lunch-stem-promotion-meme.jpg" alt="lunchSTEM meme" width="300"/> |

</div>

<h1 align="center">以有组织的方式民主化 <i>STEM</i> 知识</h1><br>

<p align="center">
   <strong>🌟 非营利开源项目 (v0.1.0) 🌟</strong>
</p>

<p align="center">
   <em>想象一个更好的 <i>STEM</i> 维基百科。<br>
   就像 FreeCodeCamp，但适用于文档（不仅仅是软件工程）。</em>
</p>

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-加入我们的社区-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
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

<h2 align="center">⭐ 为项目点赞</h2>

如果您觉得 lunchSTEM 有用，请考虑在 GitHub 上给我们点个赞！这有助于我们接触更多人，并保持我们的动力。

<p align="center">
   <a href="https://github.com/Freelunch-AI/lunch-stem">
      <img src="assets/star-github.png" alt="为 Github 项目点赞" width=200>
   </a> <br>
   <em>示例图片</em>
</p>

---

## 📚 目录

- [🔍 概述](#-概述)
- [🎯 这个项目适合谁？](#-这个项目适合谁)
- [📊 项目统计](#-项目统计)
- [⚙️ 使用要求](#-使用要求)
- [🚀 如何使用](#-如何使用)
- [📁 目录结构和命名约定](#-目录结构和命名约定)
- [🔬 STEM 领域覆盖](#-stem-领域覆盖)
- [🤝 贡献](#-贡献)
- [🗺️ 路线图尝试](#-路线图尝试)
- [🗑️ 内容删除和学分归属请求](#-内容删除和学分归属请求)
- [📝 学分归属](#-学分归属)
- [⚖️ 免责声明和条款](#-免责声明和条款)
- [💎 赞助商](#-赞助商)
- [🙏 致谢](#-致谢)

## 🔍 概述

这是一个不断发展的 *STEM*（科学、技术、工程和数学）知识库，旨在通过社区的努力进行审查和改进。它可以被人类和 AI 代理使用和改进。

其理想的使用案例是**在您对某个 *STEM* 主题（及相关主题）有了初步了解后，深入研究该主题**（您可以通过 Google 搜索或 AI 助手轻松获得初步了解）。

对于这种使用案例，它应该比默认的 Google 搜索/AI 深度研究更有组织、更高质量（信噪比更高）。

目标是稍后通过制作 *lunchSTEM MCP 服务器*，使 AI 代理能够轻松地将其用作工具。

## 🎯 这个项目适合谁？

- **学生** 寻找补充学习材料
- **专业人士** 希望加深他们的 STEM 知识
- **研究人员** 需要有组织的参考材料
- **教育工作者** 寻找教学资源
- **自学者** 进行独立学习

## 📊 项目统计

- **大小：** 60+ GB（包括大量链接）
- **PDF 文件数量：** 10k+
- **子主题数量：** 6k+
- **材料语言：** 英语

## ⚙️ 使用要求

确保您已安装这些工具：

- `git`
- `rclone`

这些可以通过在其网站上遵循各自的安装指南来安装。

- [git 安装指南](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [rclone 安装指南](https://rclone.org/install/)

> [!NOTE]
> 为 _rclone_ 配置远程存储时，确保使用服务账户选项和 `lunch-stem-fadf503639fe.json` 作为服务账户文件。
>
> 此外，安装 *rclone* 时，*Windows* 用户可能会看到安全警告，这是正常的。

## 🚀 如何使用

1. **打开终端**：要打开终端，请使用操作系统的搜索框。

- 对于 *Linux*：搜索"terminal"
- 对于 *Windows*：搜索"powershell"并点击"Windows Powershell"

2. **使用 git 克隆仓库**（此命令将在您当前目录中创建一个 `lunch-stem` 文件夹）

   ```bash
   git clone https://github.com/Freelunch-AI/lunch-stem.git
   ```
   > [!NOTE]
   > 如果您使用 Windows，重要的是在顶级目录内克隆，以避免与创建过长文件路径相关的潜在错误。Windows 通常有 260 个字符的最大文件路径。

   > [!NOTE]
   > `git clone` 命令将在您的机器上复制项目，整个文件夹结构已经就位。

3. 进入 `lunch-stem` 文件夹

   ```bash
   cd lunch-stem
   ```

4. 设置项目

   **对于 Linux**

   配置 rclone

   启用 _bash_ 脚本执行

   ```bash
   chmod +x scripts/setup 
      ```

   运行设置脚本

   ```bash
   source scripts/setup 
      ```

   您应该在终端中看到打印的 `Setup complete!` 消息，以及其他详细信息。

   **对于 Windows：**

   在 _powershell_ 会话中启用脚本执行

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
      ```

   运行设置脚本

   ```powershell
   scripts/setup.ps1
      ```

   您应该在终端中看到打印的 `Setup complete!` 消息，以及其他详细信息。

5. **浏览 `ai2f` 文件夹内部**

   `ai2f` 文件夹结构：

         ├── __Loopback
         ├── Computer Science and Engineering 
         ├── Hardcore Engineering 
         ├── Hardcore Science  
         └── Mathematics

6. **下载 PDF 文件：**

   - 对于 `.pdf.dvc` 文件

      **下载特定的 PDF 文件：**

      ```bash
      lunch files "<第一个/dvc/文件/路径/占位符.pdf.dvc>" "[第二个/dvc/文件/路径/占位符.pdf.dvc]"
      ```

      您可以放置多个文件路径，只有第一个是必需的。

      此命令将获取 `.pdf` 文件并将其放在您当前的目录中。

      > [!WARNING]
      > **路径中使用 `/` 还是 `\` 作为分隔符？**
      >
      > `Linux` 只接受 `/`
      >
      > `Windows` 两者都接受。

      > [!WARNING]
      > 是否需要将路径放在 `""` 引号内？
      >
      > 是的，这是必要的。因为许多路径的目录和/或文件名中有空格。**如果不将路径放在 `""` 引号内，命令将无法工作。**

      > [!TIP]
      > **绝对路径使用示例：**
      > 假设 `当前路径` == `"D:\coding-workspace\lunch-stem"`
      > 
      > ```bash
      > lunch files "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b\5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > 在 `当前路径` 中下载 `3 - OS, Virtual Memory, OS Abstractions.pdf`、`4 - Bounded Buffers, Concurrency, Locks.pdf` 和 `5 - Threads, Condition Variables, Preemption.pdf`。

      > [!TIP]
      > **相对路径使用示例（相对于您运行命令的当前路径）：**
      > 假设 `当前路径` == `"D:\coding-workspace\lunch-stem\ai2f\__Loopback\1 - OS Fundamentals_56b97b"`
      > 
      > ```bash
      > lunch files "3 - OS, Virtual Memory, OS Abstractions.pdf.dvc" "4 - Bounded Buffers, Concurrency, Locks.pdf.dvc" "5 - Threads, Condition Variables, Preemption.pdf.dvc"
      > ```
      > 在 `当前路径` 中下载 `3 - OS, Virtual Memory, OS Abstractions.pdf`、`4 - Bounded Buffers, Concurrency, Locks.pdf` 和 `5 - Threads, Condition Variables, Preemption.pdf`。


      如果您想将文件放在与 `pdf.dvc` 文件相同的位置，请使用：

      ```bash
      lunch files "<第一个/dvc/文件/路径/占位符.pdf.dvc>" "[第二个/dvc/文件/路径/占位符.pdf.dvc]" --in-place
      ```

      - _注意 1：_ 第一个文件路径参数是必需的，其余是可选的。
      - _注意 2：_ 此命令中使用的文件路径末尾不应有 `.source.json`。它应该以 `.pdf.dvc` 结尾。
      - _注意 3：_ 其他类型的文件（例如 `.txt`）应该直接打开，而无需使用 lunch CLI。
      - _注意 4：_ 如果存在 `.web.txt`，那么您不应该尝试此命令，只需复制并粘贴 `.web.txt` 内的链接到您的浏览器中。我们稍后将实现 `lunch get` 来从网络获取文件。
      - _注意 5：_ 在运行此命令之前，`.pdf` 文件不应该可见。
      - _注意 6：_ 您可以通过操作系统的图形用户界面获取文件路径，每个操作系统都有简单的方法。


      **通过以下方式下载特定文件夹中的所有文件：**

      ```bash
      lunch folder "<文件夹/路径/占位符>"
      ```

      如果您想将新的 PDF 文件放在与其对应的 `pdf.dvc` 文件相同的位置，请使用：

      ```bash
      lunch folder "<文件夹/路径/占位符>" --in-place
      ```

      如果您想下载所有子目录（递归）中的所有文件，请使用：

      ```bash
      lunch folder "<文件夹/路径/占位符>" --recursive
      ```

      如果您想将文件放在与 `pdf.dvc` 文件相同的位置并用于所有子目录，请使用：

      ```bash
      lunch folder "<文件夹/路径/占位符>" --in-place --recursive
      ```
      对于调试，请使用 `--verbose` 标志。

   - 对于 `pdf.web.txt` 文件：

      只需打开文件并点击其中的网络链接。

   - 对于 `.sym.txt` 文件：

      只需打开文件并导航到其中写入的文件或文件夹路径。此文件或文件夹将在 `__Loopback` 内。

> [!WARNING]
> **⚠️ 重要**
> 
> *lunchSTEM* 中的文档是由外部作者创建的，不是由我们创建的。我们不支持在没有作者许可的情况下包含不可分发的文档（对于不可分发的文档：检查 `author_permissions.jsonl`）。
> 
> 每个文档在相应的 `<文件名>.<文件扩展名>.source.json` 文件中致谢其作者。
> 
> 作者可以随时请求删除内容。遵循我们简化的 *内容删除请求* 协议后，我们在 24 小时内删除内容。此选项比 *数字千年版权法 (DMCA)* 通知更快更友好（后者可能会关闭项目）。

> [!NOTE]
> **🟩 即将推出**
> 
> • **网站**，包含作者主页、关键词/语义搜索、文档讨论论坛、内容预览、交互式内容可视化、内容星标/标记/收藏、在文档上做笔记、热门/流行文档、文档和作者统计等等。
> 
> • **MCP 服务器：** 对进行复杂工程工作或科学研究的 AI 代理有用。
> 
> • **适当的 CLI**，用户可以进行关键词和语义搜索。

## 📁 目录结构和命名约定

- **`__Loopback`** 目录包含路径过长的文件。在这些文件的位置创建了一个指针 `.sym.txt` 文件，指向位于 `__Loopback` 目录内的实际文件。这些指针 txt 文件遵循此命名约定：`文件名.文件扩展名.sym.txt`，并位于实际文件应该在的同一目录中。

- 根目录下的 **`to_add.txt`** 文件包含稍后要包含在 lunchSTEM 中的材料链接。

- 以 **MEGA** 开头的文件或文件夹表示聚合器材料（聚合有关特定主题的大量链接的材料）。

- 以 **Awesome** 开头的文件或文件夹表示超高质量内容。

## 🔬 _STEM_ 领域覆盖

### 最强的领域

*lunchSTEM* 目前在 `计算机科学与工程` 和 `AI` 领域更为完整。

### 最薄弱的领域

`硬核科学`（物理、化学、生物、经济学）领域在其主题树的深度方面明显更浅。

## 🤝 贡献

如果您想为项目做贡献，请查看我们的 [CONTRIBUTING.md](https://github.com/Freelunch-AI/lunch-stem/blob/main/CONTRIBUTING.md)。

> [!WARNING]
> GCP 服务账户文件在此仓库中故意公开，它只对包含 PDF 的 Google Drive 文件夹具有读取权限。
>
> 我们知道公开提供它们不是好的做法，但这是能够利用我们现有的 Google Drive 订阅的方式（无需创建全球可扩展的后端）。
>
> 我们很快将迁移到公共 S3 存储桶，然后，这个小"黑客"将被删除。

## 🗺️ 路线图尝试

> **注意：** 具有相同 **[字母]** 的步骤可以并行完成。

### 阶段 A：基本问题

1. **[b][a]** 创建分支命名约定和分支规则。

2. **[a]** 解决与存储的实际文件相关的紧急版权和学分归属问题
   - 制作 CI 脚本，构建没有作者信息的 `.source.json` 路径列表 - 这些应该是优先级。

3. **[a]** 用链接替换实际文件（和主页/入口点链接），以直接从其原始主机获取文件（使用使用浏览器的 AI 代理来帮助解决此问题）。目标是大多数文件都是 `文件名.文件扩展名.web.txt`，其中包含链接（即，外部托管的文件）。如果用户是这些文件的作者，他们仍然可以贡献实际文件（就像 *arXiv* 所做的那样），因为在底层我们仍将为实际文件使用 DVC。

4. **[a]** 实现跨操作系统工作的适当符号链接。不再手动查找 `.sym.txt` 文件内的路径并手动转到该目录。还实现简单的网络链接，以避免手动复制/粘贴 `.web.txt` 内的路径到浏览器。

### 阶段 B：重要添加

5. **[b][a]** 创建适当的（不是 bash，有文档字符串、模块化、有测试、编译的）*lunchSTEM CLI* 包/可安装包，您可以：
   1. 从网络获取文件或目录。
   2. 隐藏/显示某些文件类型（例如，隐藏：.dvc、.source.json、.prerequisites.json、其他操作系统的符号链接等）
   3. 进行搜索：关键词搜索和语义搜索

6. **[b]** 制作 *lunchSTEM MCP 服务器*：首先，需要为每个 `.pdf` 创建 `.md` 版本

7. **[b][a]** 制作网站以便人类轻松使用 *lunchSTEM*，用户可以：
   1. 将仓库可视化并导航为图形
   2. 使用关键词、基于过滤器和语义搜索
   3. 查看文档预览而无需打开它们
   4. 直接在浏览器中打开文档
   5. 为文档加星标
   6. 在材料上进行自己的标记/收藏，这只对他们可见。
   7. 在材料上进行高亮和笔记，这只对他们可见
   8. 查看链接到特定作者所有材料的作者主页。
   9. 参与特定文档上的讨论论坛
   10. 查看热门/流行文档和作者
   11. 查看文档和作者的统计信息

8. **[b]** 获得赞助商和资助以：(1) 支持我们的应用托管；(2) 建立专门的 *lunchSTEM* 维护团队；(3) 为同行评议流程付费给专家；(4) 将一定比例的资金转给贡献作者。所有赞助资金将重新投资到项目中，这是一个非营利项目。

9. 制作 CI 工作流

   1. **[b][a]** 用 `.pdf.dvc` 文件替换实际的 `.pdf` 文件，避免仓库中的实际知识文件。

   2. **[b][a]** 添加恶意文件删除、大文件删除、git 仓库删除、不接受扩展名的文件删除、版权材料删除等，以自动避免糟糕的 PR。

   3. **[b][a]** 在 CI 中添加标准约定强制执行，以保持知识库一致，避免不一致的 PR。

### 阶段 C：更多核心功能

10. **[b][c][d]** 向 *lunchSTEM* 添加功能，可能使用 *AgentPool* 来帮助（并行：继续从 `to_add.txt` 添加更多材料，但添加为 `文件名.文件扩展名.web.txt`，文件中包含 HTTPS 链接）：
    - **先决条件：** 为每个文件添加包含分层先决条件列表的 `<文件名>.<文件扩展名>.prerequisites.json`
    - **练习：** 在 `__Exercises` 内的每个主题目录中放置带解决方案的练习
    - **工具：** 在 `__Tools` 内的每个主题中放置软件工具。可以是用于做或理解与主题相关的某些事情的工具。
    - **学习和认证轨道：** 引导式顺序轨道（例如，ML 工程师轨道），估计完成时间为 3 或 6 个月，最后进行内部或外部考试/认证。
    - **示例项目：** 在 `__Sample Projects` 内的每个主题目录中放置示例项目
    - **lunchSTEM CLI 内的 AI 助手，使您的文档更容易理解**：可以添加图表、笔记本，我们用更容易理解的词语写作，制作示例等。可以通过故意综合恶化好的学习材料来生成训练/提示数据集。
    - **使用 lunchSTEM 作为其知识库的 AI 导师**：可以制作自定义学习指南、解释文本块教授所有必需先决条件、制作自定义交互材料等的导师
    - **使用 lunchSTEM 作为其知识库的 AI 同行评议员**：构建能够审查 PR 中包含的新 *STEM* 文档（且不在受尊重来源列表中）的 AI 代理，以避免依赖缓慢且昂贵的人工同行评议。然后应该每年进行人工同行评议，以捕捉 AI 同行评议员的错误，并生成数据以改进 AI 同行评议员的弱点。
    - **lunchSTEM 大学：** 为喜欢严格截止日期、责任和与他人一起学习的人提供的免费在线大学。没有考试。每年，学生将从头开始构建现有技术或方法，受 [build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) 启发，并撰写包含所有重要细节的专题论文，并通过博客文章与社区分享。学生以出色的作品集完成大学学业。自上而下的教学方法，我们帮助学生在需要构建某些东西时按需学习主题。

### 阶段 D：很好拥有的改进

11. **[d]** 从 *Google Drive*（我已经为 2TB 付费，所以我使用了它）迁移到更好的存储选项（例如，*S3*）。

12. **[d]** 制作 *AgentPool*：多样化代理团队，在内部讨论后向 *lunchSTEM* 仓库提交 PR，向人类提问并通过微调 SLM 评估提议的更改。代理被持续修改以确保多样性并基于添加到 *lunchSTEM* 的已批准新知识提高其智能。

## 🗑️ 内容删除和学分归属请求

为了检测和删除版权（不可分发）内容，并识别剩余材料的作者/出版商/大学，我们做了大量努力。由于文件数量庞大，无法对每个文件进行手动审查（但我们欢迎社区通过开启问题和 PR 来帮助我们）。
1. 我们运行脚本删除包含除以下扩展名之外的任何其他扩展名的任何文件：`.pdf`、`.txt`、`.md`、`.ipynb`、`.json`
2. 我们运行脚本自动检测文档中与版权相关的关键词并删除此类文档
3. 我们运行脚本自动删除学术论文。
4. 我们手动将每本书的 PDF 替换为其链接。
5. 我们运行脚本为每个剩余的 PDF 自动创建学分归属文件（`.source.json`），其中包含作者、源链接、是否修改等信息。字段的默认值为 `null`，除了 `changes_were_made` 字段的默认值为 `False`。当在 PDF 本身中找不到信息时，使用默认值。

但是，我们无法保证此过程的完美性，因此，如果您发现任何版权内容或没有适当学分归属数据的内容，请开启问题和/或提交 PR 和/或发送电子邮件至 bruno.c.scaglione@gmail.com。我们的目标是在 24 小时内解决问题。有关此方面的指导原则，请参阅 `CONTRIBUTING.md` 文件。

> **内容删除请求的简化协议（推荐而非 _DMCA_）**
   > 1. 阅读 CONTRIBUTING.md 以查看问题指导原则
   > 2. 开启 *内容删除请求* 问题
   > 3. 发送电子邮件至 bruno.c.scaglione@gmail.com，主题为"[lunchSTEM] 内容删除请求：#GITHUB_问题编号_占位符"，解释：您是谁、您需要删除的内容路径以及您开启的特定问题的链接。

<br>

> 此选项 __比 *DMCA* 通知更快更友好__。如果我们收到多个 *DMCA* 通知，项目有被从 *Github* 删除的风险（即使在删除内容后），许多可能从中受益的人将受到影响。

***数字千年版权法* (*DMCA*) 合规性：** 我们遵守数字千年版权法 (DMCA)。对于正式删除请求，请遵循 *DMCA* 流程。

## 📝 学分归属

PDF 文件的学分归属数据存储在 `<文件名>.pdf.source.json` 中，应该直接打开（无需 `dvc pull`）。此文件可以包含作者、大学、出版商、源链接以及它引用的特定文件的其他元数据。字段的默认值为 `null`，除了 `changes_were_made` 字段的默认值为 `False`。

## ⚖️ 免责声明和条款

**按原样提供：** 此项目按"原样"提供，不提供任何形式的保证。我们不对内容的准确性、完整性或合法性做任何陈述。

**责任限制：** 在法律允许的最大范围内，项目维护者不对因使用此仓库而产生的任何损害承担责任。

**服务条款：** 通过使用此仓库，您同意尊重版权法、仅将内容用于教育目的，并遵守您所在司法管辖区的所有适用法律。

**非法律建议：** 此仓库中的任何内容都不构成法律、财务或专业建议。

**教育目的：** 此项目旨在为非商业、教育目的提供对教育材料的有组织访问。我们相信内容的许多用途可能符合合理使用保护，但合理使用的确定是由法院逐案做出的。

## 💎 赞助商

__想成为赞助商？发送电子邮件至 bruno.c.scaglione@gmail.com，主题为"[lunchSTEM] Sponsorship"__ 

## [Freelunch](https://freelunch.dev)

![Freelunch 徽标](./sponsors/freelunch/logo_freelunch_with_name.png)

## 🙏 致谢

感谢所有使其内容公开可用的作者。

感谢我们的早期测试者。

感谢我们的贡献者、维护者和赞助商，他们使项目保持活力和发展。
