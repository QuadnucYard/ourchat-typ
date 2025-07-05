/// Using rich text in messages

#import "../mod.typ": *

#show: example-style

#wechat.chat(
  theme: "dark",
  width: 300pt,

  oc.time[Today 14:30],

  oc.message(left, alice)[
    Check out these formatting options:

    *Bold text*, _italic text_, and `inline code`

    You can even use #text(fill: red)[colored text]!
  ],

  oc.message(right, bob)[
    Math expressions work great too:

    $integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2$

    And block equations:

    $ sum_(n=1)^infinity 1/n^2 = pi^2/6 $
  ],
)
