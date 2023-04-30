New-Module -Name "Custom.Cmdlets" -ScriptBlock {
	function Get-CurrentTheme {
	<#
	.SYNOPSIS
		Returns the name of current theme.

	.DESCRIPTION
		It checks an object in Windows Registry, to see if the current windows theme
		is a light one (a boolean value). The results are based on this value.

	.EXAMPLE
		Get-CurrentTheme

	.OUTPUTS
		String ("Dark" or "Light")

	.NOTES
		Author:  xeho91
		Website: https://github.com/xeho91
	#>
		[CmdletBinding()]

		$options = @{
			Path = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
			Name = "SystemUsesLightTheme"
		}
		$isThemeLight = (Get-ItemProperty @options).SystemUsesLightTheme

		Write-Output (($isThemeLight) ? "Light" : "Dark")
	}
	function Edit-WindowsTheme {
	<#
	.SYNOPSIS
		Change Windows (system) theme to "Dark" or "Light" mode.

	.DESCRIPTION
		It uses a program "Auto Dark Mode" executable file and passes specific
		option name (this function parameter) to change current theme to desired
		mode.

	.PARAMETER ThemeName
		The name of the theme you want to switch to. "Dark" or "Light".

	.EXAMPLE
		Edit-WindowsTheme -ThemeName "Dark"

	.EXAMPLE
		Edit-WindowsTheme light

	.INPUTS
		String

	.NOTES
		Author:  xeho91
		Website: https://github.com/xeho91
	#>

		[CmdletBinding()]
		param(
			[string[]]$ThemeName
		)
		$ThemeName = $ThemeName.ToLower()

		if (("$ThemeName" -eq "dark") -or ("$ThemeName" -eq "light")) {
			$AutoDarkModeExePath = "$Env:LOCALAPPDATA\Auto-Dark-Mode\AutoDarkMode.exe"
			Invoke-Expression "$AutoDarkModeExePath /$ThemeName"
		} else {
			Write-Error 'Accepted arguments are either "Dark" or "Light"!'
		}
	}

	function Edit-WindowsTerminalTheme {
	<#
	.SYNOPSIS
		Change Windows Terminal theme to "Dark" or "Light" mode.

	.DESCRIPTION
		It edits an line in Windows Terminal settings file where is defined a
		property of currently used color scheme. It changes the mode of this
	    scheme whis defined between the square brackets. Example of the theme
	    name: "Ubuntu [Dark]".

	.PARAMETER ThemeName
		The name of the theme you want to switch to. "Dark" or "Light".

	.EXAMPLE
		Edit-WindowsTerminalTheme -ThemeName "Dark"

	.EXAMPLE
		Edit-WindowsTerminalTheme light

	.INPUTS
		String

	.NOTES
		Author:  xeho91
		Website: https://github.com/xeho91
	#>

		[CmdletBinding()]
		param(
			[string[]]$ThemeName
		)

		$ThemeName = (Get-Culture).TextInfo.ToTitleCase($ThemeName)

		if (("$ThemeName" -eq "Dark") -or ("$ThemeName" -eq "Light")) {
			$currentContent = Get-Content -Path "$Env:WT_SETTINGS_PATH" -Raw

			$optionsSelectString = @{
				Path    = "$Env:WT_SETTINGS_PATH"
				Pattern = "colorScheme"
				Raw     = $TRUE
			}
			$currentSettingLine = Select-String @optionsSelectString

			$newSettingLine = [regex]::Replace(
				"$currentSettingLine",
				"(?<=\[).*?(?=\])",
				"$ThemeName"
			)

			$newContent = $currentContent.Replace(
				"$currentSettingLine",
				"$newSettingLine"
			)

			$optionsSetContent = @{
				Path      = "$Env:WT_SETTINGS_PATH"
				Value     = "$newContent"
				NoNewLine = $TRUE
			}
			Set-Content @optionsSetContent
		} else {
			Write-Error 'Accepted arguments are either "Dark" or "Light"!'
		}
	}

	function Switch-Theme {
	<#
	.SYNOPSIS
		Automatically switch the current theme mode to the opposiste one.

	.DESCRIPTION
		It determines currently used theme mode and changes it to the opposite.
		It uses the following cmdlets:
		"Get-CurrentTheme", "Edit-WindowsTheme", "Edit-WindowsTerminalTheme".
		It also outputs the information to which theme is was switched.

	.EXAMPLE
		Switch-Theme

	.NOTES
		Author:  xeho91
		Website: https://github.com/xeho91
	#>
		[CmdletBinding()]

		$currentTheme = Get-CurrentTheme
		$newTheme = "$currentTheme" -eq "Dark" ? "Light" : "Dark"

		Edit-WindowsTheme -ThemeName "$newTheme"
		Edit-WindowsTerminalTheme -ThemeName "$newTheme"

		# Output about change
		Write-Host "Switched to - " -NoNewline
		$optionsWriteHost = @{
			NoNewline       = $TRUE
			BackgroundColor = ("$newTheme" -eq "Dark") ? "Gray" : "Black"
			ForegroundColor = ("$newTheme" -eq "Dark") ? "Black" : "Gray"
		}
		Write-Host "$newTheme" @optionsWriteHost
		Write-Host " - theme."
	}
}
