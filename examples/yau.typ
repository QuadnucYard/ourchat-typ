#import "../src/lib.typ" as ourchat: default-profile

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: "Microsoft YaHei")

#ourchat.chat(
  ourchat.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    已經到了無恥的地步。
  ],
)

#ourchat.chat(
  ourchat.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    我宣布他已經不是我的學生了
  ],
)

#ourchat.chat(
  theme: "dark",
  ourchat.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
)

#ourchat.chat(
  theme: "dark",
  ourchat.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
)

#ourchat.chat(
  left-profile: default-profile,
  ourchat.datetime[11月3日 中午12:05],
  ourchat.message(left, name: [丘成桐（囯內）])[
    已經到了無恥的地步。
  ],
  ourchat.datetime[11月9日 凌晨00:06],
  ourchat.message(left, name: [丘成桐（囯內）])[
    我宣布他已經不是我的學生了
  ],
  ourchat.datetime[昨天 12:31],
  ourchat.message(left, name: [丘成桐（囯內）])[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
  ourchat.datetime[14:00],
  ourchat.message(left, name: [丘成桐（囯內）])[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
  ourchat.message(right, profile: default-profile)[
    我沒有説過這種話！

    ——發自我的手機
  ],
)
