using namespace System.Management.Automation

# Import-Module oh-my-posh
# Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module -Name PSFzf

$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"
$env:FZF_DEFAULT_OPTS="--margin 10%  --prompt='>>> ' --layout=reverse --no-scrollbar
--color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
"
$env:_PSFZF_FZF_DEFAULT_OPTS="--margin 0% --border=rounded --prompt='>>> ' --layout=reverse --no-scrollbar
--color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
"

# Add auto complete (requires PSReadline 2.2.0-beta1+ prerelease)
Set-PSReadLineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator None
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PsFzfOption -TabExpansion

# Set-Alias n nvim
Set-Alias ll ls

# You need to either copy the content of this file to $PROFILE or call this
# script directly.
Register-ArgumentCompleter -Native -CommandName 'lf' -ScriptBlock {
    param($wordToComplete)
    $completions = @(
        [CompletionResult]::new('-command ', '-command', [CompletionResultType]::ParameterName, 'command to execute on client initialization')
        [CompletionResult]::new('-config ', '-config', [CompletionResultType]::ParameterName, 'path to the config file (instead of the usual paths)')
        [CompletionResult]::new('-cpuprofile ', '-cpuprofile', [CompletionResultType]::ParameterName, 'path to the file to write the CPU profile')
        [CompletionResult]::new('-doc', '-doc', [CompletionResultType]::ParameterName, 'show documentation')
        [CompletionResult]::new('-last-dir-path ', '-last-dir-path', [CompletionResultType]::ParameterName, 'path to the file to write the last dir on exit (to use for cd)')
        [CompletionResult]::new('-log ', '-log', [CompletionResultType]::ParameterName, 'path to the log file to write messages')
        [CompletionResult]::new('-memprofile ', '-memprofile', [CompletionResultType]::ParameterName, 'path to the file to write the memory profile')
        [CompletionResult]::new('-remote ', '-remote', [CompletionResultType]::ParameterName, 'send remote command to server')
        [CompletionResult]::new('-selection-path ', '-selection-path', [CompletionResultType]::ParameterName, 'path to the file to write selected files on open (to use as open file dialog)')
        [CompletionResult]::new('-server', '-server', [CompletionResultType]::ParameterName, 'start server (automatic)')
        [CompletionResult]::new('-single', '-single', [CompletionResultType]::ParameterName, 'start a client without server')
        [CompletionResult]::new('-version', '-version', [CompletionResultType]::ParameterName, 'show version')
        [CompletionResult]::new('-help', '-help', [CompletionResultType]::ParameterName, 'show help')
    )

    if ($wordToComplete.StartsWith('-')) {
        $completions.Where{ $_.CompletionText -like "$wordToComplete*" } | Sort-Object -Property ListItemText
    }
}

function n() {
	$file = $(fzf --preview 'bat {}')
	if ("$file" -ne "") {
		nvim $file
	}
}
function open-ssh() {
	py 'C:\Users\Dilip Chauhan\Desktop\WORK\ssh_fzf.py'
}

Invoke-Expression (&starship init powershell)
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
# clear
