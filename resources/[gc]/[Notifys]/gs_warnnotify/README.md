Wie benutzt man es:
- SERVER SIDE - TriggerClientEvent('gs_warningnotification:notify', source, message, duration)
- CLIENT SIDE - TriggerEvent('igs_warningnotification:notify', message, duration)

 (1 sekunde = 1000 millisekunden)

Beispiel:
- SERVER SIDE - TriggerClientEvent('gs_warningnotification:notify', xPlayer.source, 'Test server side', 5000)
- CLIENT SIDE - TriggerEvent('gs_warningnotification:notify', 'Test client side', 5000)
