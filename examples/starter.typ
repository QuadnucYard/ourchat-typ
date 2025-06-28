#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

// Define users with custom avatars
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

= Ourchat Examples

== WeChat Style

#wechat.chat(
  oc.time[Today 14:30],
  oc.message(left, alice)[
    Hey Bob! 👋 How's your day going?
  ],
  oc.message(right, bob)[
    Hi Alice! Pretty good, just working on some *Typst* documents.

    How about you?
  ],
  oc.message(left, alice)[
    Same here! I'm learning this chat library. It's pretty cool! 🚀
  ],
  oc.message(right, bob)[
    Nice! Check out this formula: $E = m c^2$
  ],
)

== WeChat Dark Theme

#wechat.chat(
  theme: "dark",
  oc.time[15:45],
  oc.message(left, alice)[
    The dark theme looks great too!
  ],
  oc.message(right, bob)[
    Absolutely! Perfect for late-night coding sessions. 🌙
  ],
)

== Discord Style

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

== QQ Style

#let admin = oc.user(
  name: [Admin],
  title: qqnt.title([群主], text-color: red),
  avatar: wechat.default-avatar,
)

#qqnt.chat(
  theme: "light",
  oc.time[16:00],
  oc.message(left, admin)[
    Welcome to the QQ-style chat!
  ],
  oc.message(right, alice)[
    The gradient background looks amazing! ✨
  ],
  oc.message(left, admin)[
    You can customize titles, themes, and much more.
  ],
)

== Custom Content

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

== Multiple Themes Comparison

#grid(
  columns: 2,
  gutter: 1em,
  [
    *Light Theme*
    #wechat.chat(width: 200pt, theme: "light", oc.message(left, alice)[Hello!], oc.message(
      right,
      bob,
    )[Hi there!])
  ],
  [
    *Dark Theme*
    #wechat.chat(width: 200pt, theme: "dark", oc.message(left, alice)[Hello!], oc.message(
      right,
      bob,
    )[Hi there!])
  ],
)
