/// Casual hobby discussion with friends using QQNT
/// Features: Hobby sharing, casual conversation, friend interactions
/// Layout: Relaxed spacing perfect for informal chat

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: white)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let alice_hobby = user(name: [Alice], title: qqnt.title[Photography], avatar: circle(
  fill: gradient.radial(rgb("#FFD700"), rgb("#FFA000")),
  text(white, size: 8pt, weight: "bold")[📸],
))

#let bob_hobby = user(name: [Bob], title: qqnt.title[Cooking], avatar: circle(
  fill: gradient.radial(rgb("#FF69B4"), rgb("#E91E63")),
  text(white, size: 8pt, weight: "bold")[👨‍🍳],
))

#let charlie_hobby = user(name: [Charlie], title: qqnt.title[Music], avatar: circle(
  fill: gradient.radial(rgb("#8BC34A"), rgb("#4CAF50")),
  text(white, size: 8pt, weight: "bold")[🎵],
))

#qqnt.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#E8F5E8"),
    bubble-right: rgb("#FFF8DC"),
  ),
  layout: (
    content-width: 300pt,
    message-text-size: 12pt,
  ),

  time[Sunday Evening 7:30 PM],

  message(left, alice_hobby)[
    Just got back from the park! Took some amazing sunset photos �
  ],

  message(center, bob_hobby)[
    Nice! I spent the afternoon trying a new pasta recipe 🍝
  ],

  message(right, charlie_hobby)[
    Sounds relaxing! I've been practicing guitar for 3 hours straight 🎸
  ],

  message(left, alice_hobby)[
    Bob, how did the pasta turn out? You've been experimenting a lot lately!
  ],

  message(center, bob_hobby)[
    It was amazing! Homemade pesto with fresh basil from my garden 🌿

    Want me to share the recipe?
  ],

  message(right, charlie_hobby)[
    Yes please! I'll cook it while practicing - good background activity 👏
  ],

  message(left, alice_hobby)[
    Count me in! We should have a hobby share session sometime 🌟
  ],

  message(center, bob_hobby)[
    Great idea! I'll cook, Alice can document with photos, Charlie provides the soundtrack 😊

    Perfect creative collaboration!
  ],

  message(right, charlie_hobby)[
    Love it! Next weekend at my place? I have a good sound system 🚀
  ],
)
