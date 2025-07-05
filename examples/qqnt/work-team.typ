/// Work team coordination using QQNT for business communication

#import "../mod.typ": *

#show: example-style

#let manager = user(name: [Sarah Wilson], title: qqnt.title[Project Manager], avatar: circle(
  fill: gradient.radial(rgb("#1976D2"), rgb("#0D47A1")),
  text(white, size: 9pt, weight: "bold")[SW],
))

#let designer = user(name: [Mike Chen], title: qqnt.title[UI Designer], avatar: circle(
  fill: gradient.radial(rgb("#E91E63"), rgb("#AD1457")),
  text(white, size: 9pt, weight: "bold")[MC],
))

#let developer = user(name: [Alex Kim], title: qqnt.title[Frontend Dev], avatar: circle(
  fill: gradient.radial(rgb("#4CAF50"), rgb("#2E7D32")),
  text(white, size: 9pt, weight: "bold")[AK],
))

#qqnt.chat(
  theme: (
    inherit: "dark",
    bubble-left: rgb("#FF9500"), // Orange bubble
    bubble-right: rgb("#34C759"), // Green bubble
    text-left: white,
  ),
  layout: (
    message-text-size: 12pt,
  ),
  width: 360pt,

  time[Today 9:30 AM],

  message(left, manager)[
    Good morning team! Let's discuss the new project timeline 📋
  ],

  message(left, designer)[
    UI designs are 80% complete, should be finished by tomorrow 🎨
  ],

  message(right, developer)[
    Frontend framework is ready, waiting for designs to start development
  ],

  message(left, manager)[
    Perfect! Here's our schedule:

    - Design completion: Tomorrow
    - Frontend dev: Monday start
    - Backend API: Wednesday completion
    - Testing: Friday
  ],

  message(left, designer)[
    Got it! I'll push to finish this afternoon 💪
  ],

  message(right, developer)[
    Sounds good! I'll prepare the component library and base architecture
  ],

  message(left, manager)[
    Thanks everyone! Feel free to discuss any issues here 👍
  ],
)
