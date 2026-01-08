# Ce script ajoute les faux domaines dans votre Windows pour tester
# CLIC DROIT -> Exécuter avec PowerShell (En Admin)

$hosts = "$env:SystemRoot\System32\drivers\etc\hosts"
$entry = "127.0.0.1 ciel.lan files.ciel.lan tools.ciel.lan monitor.ciel.lan adguard.ciel.lan"

if (Get-Content $hosts | Select-String "ciel.lan") {
    Write-Host "Déjà configuré ! Vous pouvez tester." -ForegroundColor Green
}
else {
    try {
        Add-Content -Path $hosts -Value "`r`n$entry"
        Write-Host "Succès ! Domaines ajoutés." -ForegroundColor Green
        Write-Host "Testez maintenant : http://ciel.lan" -ForegroundColor Cyan
    }
    catch {
        Write-Host "ERREUR : Lancez ce script en Administrateur !" -ForegroundColor Red
    }
}

Read-Host "Appuyez sur Entrée pour quitter..."
