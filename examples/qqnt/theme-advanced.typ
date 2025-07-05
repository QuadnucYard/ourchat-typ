/// [Featured]
/// Fancy custom themes with gradient bubbles

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

#let advanced-theme = (
  inherit: "light",
  text-right: rgb("#fffff1"),
  text-left: rgb("#2C3E50"),
  bubble-right: gradient.linear(rgb("#667eea"), rgb("#764ba2")),
  bubble-left: gradient.linear(rgb("#f093fb"), rgb("#f5576c")),
  background: rgb("#F8F9FA"),
  text-username: rgb("#6C757D"),
)

#qqnt.chat(
  theme: advanced-theme,
  width: 360pt,

  oc.time[Today 17:00],
  oc.message(left, alice)[
    This theme uses gradient bubbles and custom typography!
  ],
  oc.message(right, bob)[
    The gradient bubbles create such a modern look! 🚀
  ],
  oc.message(left, alice)[
    Theme inheritance makes customization so much easier while keeping all the base functionality.
  ],
)
