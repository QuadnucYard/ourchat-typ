/// [Featured]
/// Family group chat with photos and mixed content

#import "../mod.typ": *

#show: example-style

#let mom = user(name: [Mom], avatar: circle(
  fill: gradient.radial(rgb("#FFB74D"), rgb("#FF8F00")),
  text(white, size: 9pt, weight: "bold")[👩],
))

#let dad = user(name: [Dad], avatar: circle(
  fill: gradient.radial(rgb("#81C784"), rgb("#388E3C")),
  text(white, size: 9pt, weight: "bold")[👨],
))

#let me = user(name: [Me], avatar: circle(
  fill: gradient.radial(rgb("#64B5F6"), rgb("#1976D2")),
  text(white, size: 9pt, weight: "bold")[😊],
))

#wechat.chat(
  theme: (
    inherit: "light",
    bubble-right: rgb("#FF6B6B"), // Custom red bubble
    bubble-left: rgb("#4ECDC4"), // Custom teal bubble
  ),
  layout: (
    avatar-size: 30pt,
    bubble-radius: 8pt,
    row-gutter: 0.5em,
  ),
  width: 320pt,

  time[Sunday 15:30],

  message(left, mom)[
    Look what I found while cleaning! 📸

    #rect(fill: gray.lighten(90%), inset: 8pt, radius: 4pt, [🖼️ Family_vacation_2018.jpg])
  ],

  message(right, me)[
    Aww that brings back memories! 🥰
  ],

  message(left, dad)[
    Haha, look how young we all looked!
  ],

  time[Sunday 18:00],

  message(left, mom)[
    Dinner's ready! 🍽️

    Made your favorite pasta 🍝
  ],

  message(right, me)[
    Coming! Be there in 5 minutes
  ],

  message(left, dad)[
    Save some for me! Still stuck in traffic 🚗
  ],

  message(left, mom)[
    Don't worry, made plenty for everyone ❤️
  ],
)
