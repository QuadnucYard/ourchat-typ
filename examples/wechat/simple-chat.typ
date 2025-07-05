/// Simple casual conversation between friends

#import "mod.typ": *

#show: example-style

#let alice = oc.user(name: [Alice Chen], avatar: circle(
  fill: gradient.radial(blue.lighten(60%), blue),
  text(white, size: 10pt, weight: "bold")[A],
))

#let bob = oc.user(name: [Bob Smith], avatar: circle(
  fill: gradient.radial(green.lighten(60%), green),
  text(white, size: 10pt, weight: "bold")[B],
))

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
