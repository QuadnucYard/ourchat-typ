#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 0em, fill: none)
#set text(font: "Arial")

#let left-profile = box(width: 27pt, height: 27pt, fill: green, scale(200%, move(dx: 3pt, dy: 5pt)[🤣]))
#let right-profile = box(width: 27pt, height: 27pt, fill: blue, scale(200%, move(dx: 3pt, dy: 5pt)[😆]))

#let left-user = oc.user(name: [Han Meimei], profile: left-profile)
#let right-user = oc.user(name: [Li Lei], profile: right-profile)

#wechat.chat(
  theme: (left-text-color: purple),
  oc.message(left, left-user)[
    Hello!
  ],
  oc.message(right, right-user)[
    Hello!
  ],
  oc.message(left,left-user)[
    My name is Han Meimei. What's your name?
  ],
  oc.message(right, right-user)[
    My name is Li Lei.
  ],
)
