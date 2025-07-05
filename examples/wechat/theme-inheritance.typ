/// Your first example of theme inheritance

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

#let custom-dark = (
  inherit: "dark",
  bubble-right: rgb("#9B59B6"), // Purple bubble
  background: rgb("#2C3E50"), // Custom background
)

#wechat.chat(
  theme: custom-dark,
  oc.time[Today 15:00],
  oc.message(left, alice)[
    This inherits from dark theme with purple bubbles!
  ],
  oc.message(right, bob)[
    Love the custom purple and blue combination! 💜
  ],
)
