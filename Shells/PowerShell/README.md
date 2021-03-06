# PowerShell

<div align="center">
  <img
    alt="PowerShell logo"
    width="200px"
    src="https://raw.githubusercontent.com/PowerShell/PowerShell/master/assets/ps_black_128.svg"
  />
</div>

> [PowerShell] is a cross-platform **task automation and configuration
> management framework, consisting of a command-line shell and scripting
> language**.
> Unlike most shells, which accept and return text,
> **PowerShell is built on top of the `.NET`** _(also known as `dotnet`)_
> **Common Language Runtime** _(CLR)_, and accepts and returns .NET objects.

[_Modified from this source_](https://docs.microsoft.com/powershell/scripting/overview)

[PowerShell]: https://docs.microsoft.com/powershell/

## Official resources

- **[Documentation]**
- **[Repository]**
- **[PowerShell Gallery]** - central repository for sharing code

[Documentation]: https://docs.microsoft.com/powershell/
[Repository]: https://github.com/PowerShell/PowerShell/
[PowerShell Gallery]: https://www.powershellgallery.com/

---

## Communities

- **[PoshCode]** -  PowerShell projects for power users
- **[Reddit]** - /r/PowerShell/

[PoshCode]: https://poshcode.org/
[Reddit]: https://www.reddit.com/r/PowerShell/

---

## Code style guides & best practices

- [Style guides & best practices] - unofficial

---

[Style guides & best practices]: https://github.com/PoshCode/PowerShellPracticeAndStyle/

## Tools for development

- **[PSScriptAnalyzer]** - static code checker
- **[Pester]** - testing & mocking framework
- **[Plaster]** - project generator

[Pester]: https://pester.dev/
[Plaster]: https://github.com/PowerShellOrg/Plaster
[PSScriptAnalyzer]: https://github.com/PowerShell/PSScriptAnalyzer

## Integrations with editors

- [Visual Studio Code]
- (Neo)vim - ?

[Visual Studio Code]: https://code.visualstudio.com/docs/languages/powershell

---

## Hotkeys

Available default hotkeys to use within PowerShell shell.

Hotkey | Explanation
:----: | :----------
<kbd>Esc</kbd> | Clear the current line.
<kbd>Ctrl</kbd> + <kbd>End</kbd> | Deletes characters from (and including) the current cursor position to the end of the current command line.
<kbd>Tab</kbd> | Use the completion.
<kbd>&uarr;</kbd> | Scan backward through your command history.
<kbd>&darr;</kbd> | Scan forward through your command history.
<kbd>&larr;</kbd> | Move cursor one character to the left on your command line.
<kbd>Ctrl</kbd> + <kbd>&larr;</kbd> | Move the cursor one word to the left on your command line.
<kbd>&rarr;</kbd> | Move cursor one character to the right on your command line. If at the end of the line, inserts a character from the text of your last command at that position.
<kbd>Ctrl</kbd> + <kbd>&rarr;</kbd> | Move the cursor one word to the right on your command line.
<kbd>Page up</kbd> | Display the first command in your command history.
<kbd>Page down</kbd> | Display the last command in your command history.
<kbd>Home</kbd> | Move the cursor to the beginning of the command line.
<kbd>End</kbd> | Move the cursor to the end of the command line.
<kbd>F1</kbd> | Move cursor one character to the right on your command line. If at the end of the line, inserts a character from the text of your last command at that position.
<kbd>F2</kbd> | Creates a new command line by copying your last command line up to the character that you type.
<kbd>F3</kbd> | Complete the command line with content from your last command line, from the current cursor position to the end.
<kbd>F4</kbd> | Deletes characters from your cursor position up to (but not including) the character that you type.
<kbd>F5</kbd> | Scan backward through your command history.
<kbd>F7</kbd> | Interactively select a command from your command history. Use the arrow keys to scroll through the window that appears. Press the Enter key to execute the command, or use the right arrow key to place the text on your command line instead.
<kbd>Alt</kbd> + <kbd>F7</kbd> | Clear the command history list.
<kbd>F8</kbd> | Scan backward through your command history, only displaying matches for commands that match the text you’ve typed so far on the command line.
<kbd>F9</kbd> | Invoke a specific numbered command from your command history. The numbers of these commands correspond to the numbers that the command-history selection window (F7) shows.
<kbd>Ctrl</kbd> + <kbd>c</kbd> | Cancel the current operation.
<kbd>Ctrl</kbd> + <kbd>Break</kbd> | Forcefully close the Windows PowerShell window.
<kbd>Ctrl</kbd> + <kbd>Home</kbd> | Deletes characters from the beginning of the current command line up to (but not including) the current cursor position.

[_Credits & modified form this source_](https://www.zerrouki.com/powershell-cheatsheet-powershell-hotkeys/)

---

## Learning notes

### :exclamation:NOTE: NOT case-sensitive

You can write any commands, options, variables in **any case**.
Example:

```powershell
$eXamPleVarIabLe = "Hello World!"
wRite-hoSt "$exampleVARIABLE" # Output: "Hello World!"
```

---

### :exclamation:NOTE: Paths format in Windows environment

In Windows environment, unlike in UNIX, any path needs to have a **forward
slash**.\
For example: `C:\Users\xeho91\.dotfiles`.

---

### :exclamation:NOTE: Output returns an object

When you see an example output like this:

```log
PS > Get-ChildItem

    Directory: C:\Users\xeho91\.dotfiles

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          18/01/2021  2:34 PM                .vscode
d----          17/01/2021 10:04 AM                Editors
d----          18/01/2021 12:41 AM                Git
d----          16/01/2021 11:00 PM                Linters
d----          15/01/2021  7:28 PM                Linux
d----          16/01/2021 12:55 PM                Media
d----          16/01/2021 11:00 PM                Prompts
d----          17/01/2021 11:38 AM                Tools
d----          18/01/2021  3:14 PM                Windows
-a---          15/01/2021  7:28 PM              5 .gitignore
-a---          15/01/2021  7:28 PM           1211 LICENSE
-a---          15/01/2021  7:28 PM           3925 README.md
```

**This is an object**. \
The desired column _(property)_ can be accessed by wrapping the command with
parentheses, dot and its property name.\
Example:

```powershell
(Get-ChildItem).Name # Returns a list of items separated by row
```

**The results will be an array** _(list)_.\
Each row _(item)_ can be accessed with its index number.\
Example:

```powershell
 (get-ChildItem).Name[5] # From the example, the output is: "Media"
 ```

 ---

### :question:Q: How to expand Windows Environment Variables?

:books:A: The variables we know from Windows command line _(`cmd`)_ surrounded by
percentages `%ENVIRONMENT_VARIABLE%`,\
**in PowerShell can be expanded by using `$Env:ENVIRONMENT_VARIABLE`**.

---

### :question:Q: What is a "cmdlet"?

:books:A:
> `cmdlet` _(command let)_ is a **special type of command provided in the
> PowerShell command line environment**.
> They allow users to put certain enhanced operating system functions into
> effect. \
> Cmdlets are especially useful when used as part of a script or batch file,
> but they can also be typed at the command prompt. \
> **Their command names take the form of a capitalized verb-and-noun pair
> conjoined with a dash, for instance, `Get-Help`**.

[_Credits & modified from this source_](https://www.computerhope.com/jargon/c/cmdlet)

[**More information about cmdlets**](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-overview/)

**:exclamation: NOTE:**\
To list all of the available **cmdlets**, use the following command:

```powershell
Get-Command
# or, shorter with alias
gcm
```

Or, find by name, like this:

```powershell
Get-Command -Name "New*"
```

And to print information about specific cmdlet _(like `man` on Linux)_:

```powershell
Get-Help "Get-Command"
```

---

### :question:Q: What are "modules" in PowerShell?

:books:A: A self-contained reusable unit that allows you to partition, organize,
and abstract your PowerShell code. \
**A module can contain cmdlets, providers, functions, variables,
and other types of resources that can be imported as a single unit**.

[**More information**](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/writing-a-windows-powershell-module/)

**:exclamation:NOTE:**\
Modules are saved with `*.psm1` extension.

---

### :question:Q: What is the file extension "psd1" about?

:books:A: The file extension `*.psd1` are for **PowerShell data files**.

[**More information**](https://docs.microsoft.com/powershell/scripting/learn/ps101/10-script-modules#module-manifests/)

---

### :question:Q: How to list all environment variables?

:books:A: Use these following command(s):

```powershell
Get-ChildItem "Env:*"
# Or, shorter, with alias, you can omit quotes as well
gci Env:*
```

---

### :question:Q: How to escape special characters in PowerShell?

:books:A: Use the backtick (**`**).

Example:

```powershell
"Some string with `$variable which will not be parsed, because it was escaped.".
```

:exclamation:**NOTE**: Variables in strings wrapped with single quote
characters (`'`) will not be parsed. Only with double quotes (`"`).
