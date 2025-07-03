/// Display something complex inside bubbles

#import "../mod.typ": *

#show: example-style

#wechat.chat(
  theme: "light",
  layout: (content-width: 300pt),

  oc.time[16:45],

  oc.plain(left, alice)[
    #grid(
      columns: (1fr, auto),
      gutter: 8pt,
      [
        #stack(
          spacing: 4pt,
          text(weight: "bold")[Project Status Report],
          text(size: 0.9em, fill: gray)[Generated on #datetime.today().display()],
          line(length: 100%, stroke: 0.5pt + gray),
          grid(
            columns: (auto, 1fr),
            gutter: 8pt,
            [*Tasks:*], [12/15 completed],
            [*Progress:*], [80%],
            [*Due:*], [Tomorrow],
          ),
        )
      ],
      circle(fill: green, text(white, size: 0.8em)[✓]),
    )
  ],

  oc.message(right, bob)[
    Looks great! The combination of custom layouts with chat bubbles is really powerful. 🚀
  ],
)
