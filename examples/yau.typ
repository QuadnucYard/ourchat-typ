#import "../src/lib.typ" as oc: default-profile

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: "IBM Plex Sans SC")

/*
#oc.wechat(
  oc.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    已經到了無恥的地步。
  ],
)

#oc.wechat(
  oc.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    我宣布他已經不是我的學生了
  ],
)

#oc.wechat(
  theme: "dark",
  oc.message(left, name: [丘成桐（囯內）], profile: default-profile)[
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
)

#oc.wechat(
  theme: "dark",
  oc.message(right, name: [丘成桐（囯內）], profile: default-profile)[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
)
*/

#grid(
  columns: 2,
  gutter: 1em,
  oc.qqnt(
    theme: "dark",
    left-profile: default-profile,
    oc.datetime[11月3日 中午12:05],
    oc.message(left, name: [丘成桐（囯內）], title: oc.qqnt-title(text(weight: 600)[LV100 群主]))[
      已經到了無恥的地步。
    ],
    oc.datetime[11月9日 凌晨00:06],
    oc.message(left, name: [丘成桐（囯內）], title: oc.qqnt-title(text(weight: 600)[LV100 群主]))[
      我宣布他已經不是我的學生了
    ],
    oc.datetime[昨天 12:31],
    oc.message(left, name: [丘成桐（囯內）], title: oc.qqnt-title(text(weight: 600)[LV100 群主]))[
      告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
    ],
    oc.datetime[14:00],
    oc.message(left, name: [丘成桐（囯內）], title: oc.qqnt-title(text(weight: 600)[LV100 群主]))[
      這種成績，使人汗顏！如此成績，如何招生？
    ],
    oc.message(
      right,
      profile: default-profile,
    )[
      我沒有説過這種話！

      ——發自我的手機
    ],
  ),
  oc.wechat(
    theme: "dark",
    left-profile: default-profile,
    oc.datetime[11月3日 中午12:05],
    oc.message(left, name: [丘成桐（囯內）])[
      已經到了無恥的地步。
    ],
    oc.datetime[11月9日 凌晨00:06],
    oc.message(left, name: [丘成桐（囯內）])[
      我宣布他已經不是我的學生了
    ],
    oc.datetime[昨天 12:31],
    oc.message(left, name: [丘成桐（囯內）])[
      告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
    ],
    oc.datetime[14:00],
    oc.message(left, name: [丘成桐（囯內）])[
      這種成績，使人汗顏！如此成績，如何招生？
    ],
    oc.message(
      right,
      profile: default-profile,
    )[
      我沒有説過這種話！

      ——發自我的手機
    ],
  ),
)

#set text(font: "gg sans")

#oc.discord(
  default-profile: default-profile,
  oc.datetime[11月3日 中午12:05],
  oc.message(left, name: [丘成桐（囯內）], time: [03/11/2025, 22:45], title: oc.discord-newbie)[
    已經到了無恥的地步。\
    我宣布他已經不是我的學生了\
    告诉学生們，去修 birkar 的課，交論文，得分最高的，獎一个华为手表。
  ],
  oc.datetime[14:00],
  oc.message(left, name: [丘成桐（囯內）], time: [14:00], title: oc.discord-newbie)[
    這種成績，使人汗顏！如此成績，如何招生？
  ],
  oc.message(
    right,
    name: text(fill: rgb("#009692"))[Anonymous],
    time: [Yesterday at 14:07],
  )[
    我沒有説過這種話！

    ——發自我的手機
  ],
)

#oc.discord(
  default-profile: default-profile,
  oc.message(left, name: [WenSim], time: [27/04/2025, 15:49])[
    This version should work better

    #v(1em)

    #block(fill: rgb("#323547"), inset: 7pt, radius: 4pt, stroke: rgb("#464859"))[```makefile
      .PHONY: all clean
      .PRECIOUS: %.nml

      all: JPtracks.grf

      clean:
              rm -f JPtracks.grf
              rm -f JPtracks.nml

      PNML_FILES := $(shell find -type f -name '*.pnml')
      IMAGE_FILES := $(shell find -type f -name '*.png')
      LNG_FILES := $(shell find -type f -name '*.lng')

      %.grf: %.nml custom_tags.txt $(IMAGE_FILES) $(LNG_FILES)
              nmlc $< -p LEGACY -o $@

      %.nml: $(PNML_FILES)
              gcc -E -x c src/index.pnml > $@
      ```]
  ],
)
