/// Simple casual conversation between friends
/// Features: Basic message exchange, emojis, minimal customization
/// Layout: Default WeChat styling with standard bubble sizes

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 0em, fill: white)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#wechat.chat(
  theme: "light",
  time[Today 14:30],

  message(left, alice)[
    Hey! How's your day going? 😊
  ],

  message(right, bob)[
    Pretty good! Just finished my morning workout 💪
  ],

  message(left, alice)[
    Nice! What did you do?
  ],

  message(right, bob)[
    Went for a 5km run, then some strength training
  ],

  message(left, alice)[
    Awesome! Want to grab lunch later?
  ],

  message(right, bob)[
    Sure! How about that new sushi place? 🍣
  ],

  message(left, alice)[
    Perfect! See you at 12:30 👍
  ],
)
