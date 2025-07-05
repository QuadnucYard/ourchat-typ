/// Simple Discord conversation showcasing basic features

#import "mod.typ": *

#show: example-style

#let user1 = user(name: [alex_dev], avatar: circle(
  fill: gradient.radial(rgb("#5865F2"), rgb("#4752C4")),
  text(white, size: 8pt, weight: "bold")[AD],
))

#let user2 = user(name: [sarah_pm], avatar: circle(
  fill: gradient.radial(rgb("#57F287"), rgb("#3BA55D")),
  text(white, size: 8pt, weight: "bold")[SP],
))

#discord.chat(
  theme: (
    inherit: "default",
    text-normal: rgb("#FFD700"), // Gold text
    text-username: rgb("#FF69B4"), // Pink names
  ),
  time[Today at 2:30 PM],

  message(left, user1)[
    Hey team! Just pushed the latest changes to main 🚀
  ],

  message(left, user2)[
    Great work! The new features look amazing
  ],

  message(left, user1)[
    Thanks! Next up is the mobile optimization
  ],

  message(left, user2)[
    Perfect timing, we have the client demo on Friday
  ],

  message(left, user1)[
    I'll have it ready by Thursday EOD 👍
  ],

  message(left, user2)[
    Awesome! You're the best ⭐
  ],
)
