/// [Featured]
/// Gaming community discussion with Discord's characteristic features

#import "mod.typ": *

#show: example-style

#let gamer1 = user(name: [PixelWarrior], avatar: circle(
  fill: gradient.radial(rgb("#FF6B6B"), rgb("#E55353")),
  text(white, size: 8pt, weight: "bold")[🎮],
))

#let gamer2 = user(name: [CodeNinja], avatar: circle(
  fill: gradient.radial(rgb("#4ECDC4"), rgb("#44A08D")),
  text(white, size: 8pt, weight: "bold")[🥷],
))

#let gamer3 = user(name: [DragonSlayer99], avatar: circle(
  fill: gradient.radial(rgb("#FFE66D"), rgb("#FF8B94")),
  text(white, size: 8pt, weight: "bold")[🐉],
))

#discord.chat(
  time[Today at 8:30 PM],

  message(left, gamer1)[
    Anyone up for a raid tonight? Need 2 more DPS for Mythic+15 🗡️
  ],

  message(left, gamer2)[
    I'm down! My mage is 470 ilvl, should be good for M+15
  ],

  message(left, gamer3)[
    Count me in! Tank main here, 475 ilvl 🛡️

    What time are we thinking?
  ],

  message(left, gamer1)[
    Perfect! Let's start at 9 PM.

    Dungeon: Halls of Valor \
    Goal: Weekly chest + practice for next week's +16
  ],

  message(left, gamer2)[
    Sounds good! I'll prep some consumables 🧪

    @everyone raid starting in 30 mins!
  ],
)
