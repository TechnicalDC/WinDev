Import-Module oh-my-posh
Import-Module posh-git
Import-Module -Name Terminal-Icons

# Add auto complete (requires PSReadline 2.2.0-beta1+ prerelease)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode vi
Set-PSReadLineOption -ViModeIndicator None

oh-my-posh.exe --init --shell pwsh --config="~\mytheme.omp.json" | Invoke-Expression
clear
