#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 0em, fill: none)
#set text(font: "IBM Plex Sans SC")

#let yau = wechat.default-user(name: [丘成桐（囯內）])

#wechat.chat(
  theme: "dark",
  ..oc.with-side-user(
    left,
    yau,
    oc.time[5月16日 上午10:23],
    oc.free-message[
      已經到了無恥的地步。
    ],
    oc.time[6月18日 凌晨00:06],
    oc.free-message[
      我宣布他已經不是我的學生了
    ],
    oc.time[14:00],
    oc.free-message[
      這種成績，使人汗顏！如此成績，如何招生？
    ],
  ),
  oc.message(right, yau)[
    我沒有説過這種話！

    ——發自我的手機
  ],
)
