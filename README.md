# macai
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/Renset/macai"> <img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/Renset/macai"> <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/Renset/macai/swift-xcode.yml"> <img alt="GitHub" src="https://img.shields.io/github/license/Renset/macai">
<img alt="GitHub all releases" src="https://img.shields.io/github/downloads/Renset/macai/total"> 

macai (macOS AI) is a simple yet powerful native macOS client made with the help of ChatGPT to interact with modern AI tools (currently, only ChatGPT is supported). 

> Please note that macai can currently work only with your API token for ChatGPT. See how you can get your own token [here](https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key)

## Downloads
You can download latest signed binary on [Releases](https://github.com/Renset/macai/releases) page. 

You can also support project on [Gumroad](https://renset.gumroad.com/l/macai).

## Build from source
Checkout main branch and open project in Xcode 14.3 or later

## Features
- Organized with chats, where each chat has its own context
- Customized system messages (instructions) per chat
- System-defined light/dark theme
- Backup and restore your chats
- Customized context size
- Select one of the supported models (including GPT-4)
- Formatted code blocks
- Formatted tables, copy as JSON
- With tabs, one can easily work with multiple chats simultaneously
- Data is stored using CoreData

## Project status
The code still has weak structure and not documented. However, I'm working on improving it now. Initially, code was generated by ChatGPT, but most parts were rewritten/changed. Advises and contributions are welcomed.

## Contributions
Contributions are welcomed. Take a look at [macai project page](https://github.com/users/Renset/projects/1) and [Issues page](https://github.com/Renset/macai/issues) to see planned features/bug fixes, or create a new one.

## Screenshots

### Starting screen

<img width="924" alt="Welcome Screen: an image with abstract robo-austronaut sitting before laptop" src="https://user-images.githubusercontent.com/364877/233807727-3ace9764-010a-4f59-bd87-6743f10b723b.png">

### Customized system message
An example of custom system message and ChatGPT responses:

<img width="924" alt="CleanShot 2023-04-23 at 00 29 53@2x" src="https://user-images.githubusercontent.com/364877/233807991-4f8ae79a-2342-4cff-a23b-3a29e0273048.png">

### Code formatting and syntax highlighting
The syntax of the code provided in ChatGPT response will be highlighted ([185 languages](https://github.com/raspu/Highlightr) supported)

<img width="924" alt="Syntax highlighting in dark mode" src="https://user-images.githubusercontent.com/364877/233807820-ce7df706-7330-49a3-a79f-3c5fa41e4145.png">
<img width="924" alt="Syntax highlighting in light mode" src="https://user-images.githubusercontent.com/364877/233807839-16e86b5d-3b9c-4d00-8a6d-88242867bfbf.png">

### Table formatting
In most cases, tables in ChatGPT repsonses can be formatted as follows:

<img width="924" alt="An application window with formatted table" src="https://user-images.githubusercontent.com/364877/233807858-97e7dbd5-3051-45bd-bc90-51f7e0123ebc.png">

### Settings

<img width="532" alt="A window with settings" src="https://user-images.githubusercontent.com/364877/233808020-aeff883f-1b9d-4d44-8897-edfbf03a8cd3.png">


## License
[MIT](https://github.com/Renset/macai/blob/main/LICENSE.md)
