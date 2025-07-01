/// Simple Discord theme

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

#discord.chat(
  width: 400pt,
  oc.time[Today at 3:30 PM],
  oc.message(left, alice, time: [Today at 3:30 PM])[
    Welcome to our Discord-style chat!
  ],
  oc.message(
    left,
    discord.newbie-user(name: [Charlie], avatar: alice.avatar),
    time: [Today at 3:31 PM],
  )[
    Thanks! This looks just like Discord.
  ],
  oc.message(left, bob, time: [Today at 3:32 PM])[
    You can even add custom titles and timestamps!
  ],
)
