/// Social media style conversation with QQNT theme
/// Features: Social interaction, emojis, casual conversation
/// Layout: QQNT's characteristic three-column layout with side spacing

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: white)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let alice_qq = user(name: [Alice], title: qqnt.title[College Student], avatar: circle(
  fill: gradient.radial(rgb("#FF9800"), rgb("#F57C00")),
  text(white, size: 9pt, weight: "bold")[A],
))

#let bob_qq = user(name: [Bob], title: qqnt.title[Designer], avatar: circle(
  fill: gradient.radial(rgb("#E91E63"), rgb("#C2185B")),
  text(white, size: 9pt, weight: "bold")[B],
))

#let charlie_qq = user(name: [Charlie], title: qqnt.title[Developer], avatar: circle(
  fill: gradient.radial(rgb("#2196F3"), rgb("#1976D2")),
  text(white, size: 9pt, weight: "bold")[C],
))

#qqnt.chat(
  theme: "light",
  layout: (
    content-width: 300pt,
    message-text-size: 12pt,
  ),

  time[Today 3:30 PM],

  message(left, alice_qq)[
    What's everyone up to this weekend? 😊
  ],

  message(center, bob_qq)[
    Planning to see a movie! Heard the new sci-fi film is great 🎬
  ],

  message(right, charlie_qq)[
    I have to work overtime... 😭

    Project deadline is next week
  ],

  message(left, alice_qq)[
    That's rough! Want to grab dinner together to unwind? 🍜
  ],

  message(center, bob_qq)[
    Great idea! I know a new hotpot place that just opened 🔥
  ],

  message(right, charlie_qq)[
    Sounds perfect! What time? I'll try to finish work early
  ],

  message(left, alice_qq)[
    How about 7 PM? I'll send the location to everyone 📍
  ],

  message(center, bob_qq)[
    Perfect! Looking forward to our weekend hangout 🎉
  ],
)
