Cfg = {}

--REQUIRED

Cfg.PhotoWebhook = 'DISCORD WEBHOOK' --Webhook for photo app
Cfg.VoiceMailWebhook = 'DISCORD WEBHOOK' --Webhook for voicemail


--OPTIONAL
Cfg.CryptoWebhook = 'DISCORD WEBHOOK' --Webhook for crypto app
Cfg.MessageWebhook = 'DISCORD WEBHOOK' --Webhook for messages app
Cfg.ValetWebhook = 'DISCORD WEBHOOK' --Webhook for valet app
Cfg.TwitterWebhook = 'DISCORD WEBHOOK' --Webhook for twitter app
Cfg.MailWebhook = 'DISCORD WEBHOOK' --Webhook for mail app
Cfg.BankWebhook = 'DISCORD WEBHOOK' --Webhook for bank app
Cfg.YellowPageWebhook = 'DISCORD WEBHOOK' --Webhook for yellow page app
Cfg.InstagramWebhook = 'DISCORD WEBHOOK' --Webhook for instagram app
Cfg.ServiceWebhook = 'DISCORD WEBHOOK' --Webhook for service app

Cfg.YellowPageFee = 0 --Yellow page fee
Cfg.BankPayTax = 0.05 --Bank pay tax 0.05 = 5%
Cfg.MinimumBankTransfer = 10000 --Minimum bank transfer to send a webhook