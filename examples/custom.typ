#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 1em, fill: none)

#wechat.chat(
  theme: "dark",
  oc.message(left, wechat.default-user(name: [AAA]))[
    *strong* _emph_
  ],
  oc.message(right, wechat.default-user(name: [bbb]))[
    $lambda f. (lambda x. f (x x)) (lambda x. f (x x))$
  ],
  oc.message(left, wechat.default-user(name: [wasd]))[
    #rect(width: 1em, height: 1em, fill: blue)
  ],
  oc.plain(right,wechat.default-user(name: [qwer]))[
    #rect(width: 3em, height: 4em, fill: blue)
  ],
  oc.plain(left, wechat.default-user(name: [qwer]))[
    #rect(width: 5em, height: 4em, fill: orange)
  ],
)
