#import "/src/lib.typ" as oc

// Re-export everything for convenient wildcard import
#import oc: *
#import oc.themes: *

// Define reusable users with custom avatars
#let alice = oc.user(name: [Alice], avatar: circle(
  fill: gradient.radial(purple.lighten(60%), purple),
  text(white, size: 10pt, weight: "bold")[A],
))

#let bob = oc.user(name: [Bob], avatar: circle(
  fill: gradient.radial(orange.lighten(60%), orange),
  text(white, size: 10pt, weight: "bold")[B],
))

#let charlie = oc.user(name: [Charlie], avatar: circle(
  fill: gradient.radial(green.lighten(60%), green),
  text(white, size: 10pt, weight: "bold")[C],
))
