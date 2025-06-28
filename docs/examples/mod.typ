#import "/src/lib.typ" as oc

// Re-export everything for convenient wildcard import
#import oc: *
#import oc.themes: *

// Common users for examples
#let alice = oc.user(
  name: [Alice Chen],
  avatar: circle(
    fill: gradient.radial(blue.lighten(60%), blue),
    text(white, size: 10pt, weight: "bold")[A],
  )
)

#let bob = oc.user(
  name: [Bob Smith],
  avatar: circle(
    fill: gradient.radial(green.lighten(60%), green),
    text(white, size: 10pt, weight: "bold")[B],
  )
)

#let charlie = oc.user(
  name: [Charlie Wang],
  avatar: circle(
    fill: gradient.radial(orange.lighten(60%), orange),
    text(white, size: 10pt, weight: "bold")[C],
  )
)

#let diana = oc.user(
  name: [Diana Rodriguez],
  avatar: circle(
    fill: gradient.radial(purple.lighten(60%), purple),
    text(white, size: 10pt, weight: "bold")[D],
  )
)
