#import "../src/lib.typ" as oc
#import oc.themes: wechat
#import wechat: default-profile

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: "Microsoft YaHei")

#wechat.chat(
  oc.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    已經到了無恥的地步。
  ],
)

#wechat.chat(
  oc.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    我宣布他已經不是我的學生了
  ],
)

#wechat.chat(
  theme: "dark",
  oc.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
)

#wechat.chat(
  theme: "dark",
  oc.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
)

#wechat.chat(
  left-profile: default-profile,
  oc.time[11月3日 中午12:05],
  oc.message(left, name: [丘成桐（囯內）])[
    已經到了無恥的地步。
  ],
  oc.time[11月9日 凌晨00:06],
  oc.message(left, name: [丘成桐（囯內）])[
    我宣布他已經不是我的學生了
  ],
  oc.time[昨天 12:31],
  oc.message(left, name: [丘成桐（囯內）])[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
  oc.time[14:00],
  oc.message(left, name: [丘成桐（囯內）])[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
  oc.message(right, profile: default-profile)[
    我沒有説過這種話！

    ——發自我的手機
  ],
)
