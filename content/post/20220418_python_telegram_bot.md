---
title: "Bot de Telegram en Python"
date: "2022-11-07"
creation: "2022-04-18"
description: "Aquí los pasos que he ido dando hasta crear mi bot de telegram en Python."
thumbnail: "images/20220418_python_telegram_bot_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "python"
- "telegram"
draft: true
weight: 5
---
Resumen de introducción
<!--more--
https://www.geeksforgeeks.org/create-a-telegram-bot-using-python/

pip3 install python-telegram-bot


@BotFather
/newbot
poner nombre y usuario
 name yt2pd
 username yt2pdbot
 token 5584141312:AAHGTgp5KTFaI6exIfDqJzW_mZAE2PZYgpk
 url t.me/yt2pdbot


https://github.com/python-telegram-bot/python-telegram-bot/wiki/Extensions-%E2%80%93-Your-first-Bot

```python
import logging
from telegram import Update
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler

TOKEN='token'

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(
        chat_id=update.effective_chat.id,
        text="Soy un bot, dime lo que quieras¡¡"
    )

if __name__ == '__main__':
    application = ApplicationBuilder().token(TOKEN).build()
    start_handler = CommandHandler('start', start)
    application.add_handler(start_handler)
    application.run_polling()
```

![image-01]

### Enlaces de interés
- [Python Telegram Bot](https://python-telegram-bot.org)
- [Telegram BotFather](https://core.telegram.org/bots#6-botfather)


[link]: https://www.google.es

[image-01]: /images/20220418_python_telegram_bot_01.jpg



