/// [Featured]
/// Title: Yau QQ NT

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 0em, fill: none)
#set text(font: "IBM Plex Sans SC")

#let yau = oc.message.with(left, oc.user(
  name: [丘成桐（囯內）],
  title: qqnt.title(text(weight: 600)[LV100 群主]),
  avatar: wechat.default-avatar,
))
#let me = oc.message.with(right, oc.user(name: [丘成桐（囯內）], avatar: wechat.default-avatar))

#qqnt.chat(
  theme: "dark",
  oc.time[11月3日 中午12:15],
  yau[
    為了激励大家，並且自律，希望你们成為數学领袖，必须要的一步
  ],
  oc.time[昨天 12:31],
  yau[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
  oc.time[16:04],
  yau[
    這個機遇不可特意去求！
  ],
  me[
    我沒有説過這種話！

    ——發自我的手機
  ],
)
