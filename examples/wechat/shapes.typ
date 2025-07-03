/// Using shapes in messages

#import "../mod.typ": *

#show: example-style

#wechat.chat(
  theme: "light",
  layout: (content-width: 240pt),

  oc.time[15:15],

  oc.message(left, alice)[
    Here's a progress bar:

    #let progress = 75%
    #stack(dir: ttb, spacing: 4pt, text(size: 0.8em)[Progress: #progress], rect(
      inset: 0pt,
      width: 100%,
      height: 8pt,
      fill: gray.lighten(80%),
      rect(width: 100% * progress, height: 8pt, fill: blue),
    ))
  ],

  oc.plain(right, bob)[
    #grid(
      columns: 3,
      gutter: 8pt,
      rect(width: 2em, height: 2em, fill: red, radius: 2pt),
      rect(width: 2em, height: 2em, fill: green, radius: 50%),
      rect(width: 2em, height: 2em, fill: blue, radius: (top-left: 8pt)),
    )

    #align(center, text(size: 0.8em, fill: gray)[Custom shapes gallery])
  ],

  oc.message(left, charlie)[
    Tables work too:

    #table(
      columns: 2,
      stroke: 0.5pt + gray,
      inset: 6pt,
      [Feature], [Status],
      [Rich text], [✅],
      [Math], [✅],
      [Custom blocks], [✅],
      [Tables], [✅],
    )
  ],

  oc.plain(right, bob)[
    #align(center, stack(
      spacing: 8pt,
      rect(
        width: 120pt,
        height: 80pt,
        fill: gradient.linear(blue.lighten(80%), blue.lighten(60%)),
        radius: 8pt,
        stroke: 1pt + blue,
        align(center + horizon, stack(
          text(weight: "bold", size: 1.2em)[📊],
          text(size: 0.9em)[Chart Widget],
          text(size: 0.7em, fill: gray.darken(20%))[Click to view],
        )),
      ),
      text(size: 0.8em, fill: gray)[Interactive components],
    ))
  ],
)
