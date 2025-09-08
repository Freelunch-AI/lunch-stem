# How to Contribute

## Pull Requests (PRs)

> PRs must be made to the `pre-main` branch. Maintainers will review and then track the new pdf or large files (if any) with dvc and make the corresponding PR to `main`.

We are currently accepting these types of PRs:

1. **Content removal**: remove the `.dvc` file and the `.source.json` file and we will delete the actual `.pdf` file from Google Drive if the PR is accepted. 
2. **Credit attribution information improvement**: `.source.json` files with more accurate info
3. **Substitution of actual content files for `.web.txt` files**
4. **Organization/Cleaning of the repo**
5. **Continuous Integration code**
6. **Content addition suggestions**: add entries to `to_add.txt`.
7. **Addition of content**:
   - **Third-party content**: addition of `.web.txt` + `.source.json` files per content file. Note: we will check to see if the link is to one of blacklisted websites that distribute pirate content, and prevent addition if so.
   - **Owned content**:
     - Addition of content not hosted elsewhere: actual content file + `.source.json` (`"source_link": not hosted anywhere else`). Note: we will check to see if the content infringes copyright and prevent addition is so.
     - Addition of content already hosted elsewhere (e.g., your personal website): `.web.txt` + `.source.json` files per content file

## Guidelines for Addition of New Content

### Content

- **English content**
- **Favor links** instead of actual content, using: `.web.txt` + `.source.json` files per content file
- **The only allowed file types: `.pdf`, `.ipynb`, `.md`, `.source.json`, `.web.txt`, `.sym.txt`**
- **Cannot create new directories of files that full path exceeds 150 characters:** use `.sym.txt` to bypass this.

### Directory Structure

- Go as far as possible in the sub-topic tree of directories, create new sub-topic directories if needed. The goal is for your content to be placed in its exact sub-topic, to keep everything organized for the content consumer.

> Path size shouldn't exceed 180 characters. If path exceeds the limit, then you put the folder/file inside the `__Loopback` folder and put the path inside a `[file_name].[file_extension].sym.txt` file located in the directory the file should have been placed.

### Directory and File Naming Conventions
- **Sub-topic directories** (e.g., Computer Vision): Don't use underline before them
- **Content type directories** (e.g., _Notes): Use underline before them
- **Miscellaneous directories** (e.g., __Miscellaneous): Use double underline before them
- **Directories or Files starting with `MEGA`**: Mean that content inside it are aggregator type content (content that links to a bunch of other content)
- **Directories or Files starting with `Awesome`**: Mean that the content is one of the best for that sub-topic and should be highlighted

### References To Content Within The Repo

- To reference other file or directory in the folder use `<file_name>.<file_extension>.sym.txt` file with the path of that file or directory written inside it, per file/directory. This avoid unnecessary duplication of content.

## How to Submit a Pull Request

1. **Fork** the repository
2. **Pull** your fork locally
3. **Create a new branch** for your changes
4. **Make your changes**
5. **Test** that your changes follow the repo's file, directory and naming conventions
   - **Note**: If many changes were made in automated fashion, also need to write testing code that samples content to test and tests if the content follows conventions and has the right info, using a ground truth dataset
6. **Commit** with a clear, descriptive message
7. **Push** to your fork
8. **Open a Pull Request** with a detailed description of your changes
   - **Note**: If many changes were made in automated fashion, also need to provide (1) the code used to make the changes; (2) testing code that samples content to test and tests if the content follows conventions and has the right information, using a ground truth dataset.

## Example: structural files for a Physics 1 course pdf file.

### `.source.json` example:
```json
{
  "license": "CC-BY",
   "authors": [
      {
         "name": "John Doe",
         "university": "Some University"
      }
   ],
   "university_course_name": "Physics 1",
   "publisher": null,
   "educational_platform": null,
   "source_link": "https://physics-1-course.edu/physics-1-course-notes.pdf",
   "num_of_pages": 50,
   "size_mb": 5,
   "changes_were_made": false,
   "link_to_license": "https://creativecommons.org/licenses/by/4.0/"
}
```

### `.web.txt` example:
Simply contains the URL to the content:
```
https://physics-1-course.edu/physics-1-course-notes.pdf
```

## Issues & Contact

### Issue Types
- **Found a functional bug?** Open a `functional-bug` issue
- **Want to request content removal?** Open a `content-removal` issue
- **Found wrong or missing credit attribution data?** Open a `attribution-correction` issue
- **Want to request a new feature?** Open a `feature-request` issue

### Security & Compliance
- **Found security vulnerability?** Email with the subject `[LunchSTEM] Security Vulnerability`
- **Found compliance problem?** Email with the subject `[LunchSTEM] Compliance Problem`

**Contact email:** bruno.c.scaglione@gmail.com

## Review Process

1. All PRs are reviewed for compliance with these guidelines and content quality.
2. PRs may get closed and requested to make change to comply with the rules.
3. Large PRs may take longer to review
4. Content Addition PRs may take longer to review. If the content is not from a respected source (check `respected_sources.md`), we will need to spawn a peer-review process per document. If possible, always host the content elsewhere and link to it with `<file_name>.<file_extension>.web.txt`. If the content is hosted on a respected source, then the review process can be skipped, thus the PR is accepted super fast.
5. We will respond (and resolve copyright issues, if it's the case) emails within 24 hours.

## Want to be a maintainer?

Enter our discord and send a message in the `want-to-be-a-maintainer` channel, following the channel's guidelines.

<p align="center">
   <a href="https://discord.gg/W6wmJbZx">
      <img src="https://img.shields.io/badge/Discord-Join%20Our%20Community-5865F2?style=for-the-badge&logo=discord&logoColor=white" alt="Discord">
   </a>
</p>