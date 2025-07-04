/// Dark theme example with custom styling and modern appearance

#import "mod.typ": *

#show: example-style

#let alice_dark = user(name: [Alice], avatar: circle(
  fill: gradient.radial(rgb("#E91E63"), rgb("#AD1457")),
  text(white, size: 9pt, weight: "bold")[A],
))

#let bob_dark = user(name: [Bob], avatar: circle(
  fill: gradient.radial(rgb("#00BCD4"), rgb("#00838F")),
  text(white, size: 9pt, weight: "bold")[B],
))

#wechat.chat(
  theme: (
    inherit: "dark",
    bubble-left: rgb("#2C2C2E"),
    bubble-right: rgb("#007AFF"),
    text-left: rgb("#FFFFFF"),
    text-right: rgb("#FFFFFF"),
    background: rgb("#1C1C1E"),
  ),
  layout: (
    message-text-size: 13pt,
    bubble-radius: 12pt,
    bubble-inset: 1em,
    row-gutter: 0.7em,
  ),
  width: 320pt,

  time[Tonight 23:45],

  message(left, alice_dark)[
    Still working on the project? 🌙
  ],

  message(right, bob_dark)[
    Yeah, trying to finish this feature tonight 💻
  ],

  message(left, alice_dark)[
    Don't stay up too late!

    Remember we have the presentation tomorrow morning ☀️
  ],

  message(right, bob_dark)[
    Good point! Almost done anyway

    Just need to test this last function 🧪
  ],

  message(left, alice_dark)[
    Nice! The dark theme looks great btw ✨
  ],

  message(right, bob_dark)[
    Thanks! Much easier on the eyes for late night coding 👀
  ],
)
