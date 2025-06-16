#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 0em, fill: none)
#set text(font: ("gg sans", "IBM Plex Sans SC"))

#let yau = discord.newbie-user(name: [丘成桐（囯內）], profile: wechat.default-profile)

#let me = discord.user(name: text(fill: rgb("#009692"))[Anonymous])

#discord.chat(
  oc.time[11月3日 中午12:05],
  oc.message(left, yau, time: [03/11/2025, 22:45])[
    那場大雨毀了我的上學夢
  ],
  oc.time[14:00],
  oc.message(left, yau, time: [14:00])[
    这是你们学习的一个極小部分！
  ],
  oc.message(right, me, time: [Yesterday at 14:07])[
    我沒有説過這種話！

    ——發自我的手機
  ],
)
