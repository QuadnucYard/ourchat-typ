
#import "../mod.typ": *

#show: example-style

#let alice = oc.user(name: [Alice], avatar: box(
  width: 27pt,
  height: 27pt,
  fill: gradient.radial(blue.lighten(60%), blue),
  align(center + horizon, text(white, size: 12pt, weight: "bold")[A]),
))

#let bob = oc.user(name: [Bob], avatar: box(
  width: 27pt,
  height: 27pt,
  fill: gradient.radial(green.lighten(60%), green),
  align(center + horizon, text(white, size: 12pt, weight: "bold")[B]),
))

#wechat.chat(
  oc.time[16:30],
  oc.message(left, alice)[
    You can embed *any* content:

    #align(center, rect(fill: blue.lighten(80%), inset: 4pt, radius: 4pt)[
      Custom blocks work great!
    ])
  ],
  oc.plain(right, alice)[
    #align(center, stack(
      rect(width: 60pt, height: 40pt, fill: red.lighten(70%), radius: 4pt),
      v(4pt),
      text(size: 0.8em)[Custom shapes and layouts],
    ))
  ],
  oc.message(left, alice)[
    Even tables and lists:

    1. Feature-rich messaging
    2. Multiple themes
    3. Easy customization
    4. Typst integration
  ],
)
