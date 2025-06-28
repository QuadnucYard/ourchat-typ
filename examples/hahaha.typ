#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

// Define reusable users with custom avatars
#let alice = oc.user(name: [Alice], avatar: circle(
  fill: gradient.radial(purple.lighten(60%), purple),
  text(white, size: 10pt, weight: "bold")[A],
))

#let bob = oc.user(name: [Bob], avatar: circle(
  fill: gradient.radial(orange.lighten(60%), orange),
  text(white, size: 10pt, weight: "bold")[B],
))

#let charlie = oc.user(name: [Charlie], avatar: circle(
  fill: gradient.radial(green.lighten(60%), green),
  text(white, size: 10pt, weight: "bold")[C],
))

= Custom Content Showcase

== Rich Text and Formatting

#wechat.chat(
  theme: "dark",
  width: 350pt,

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

== Custom Blocks and Shapes

#wechat.chat(
  theme: "light",
  width: 350pt,

  oc.time[15:15],

  oc.message(left, alice)[
    Here's a progress bar:

    #let progress = 75%
    #stack(dir: ttb, spacing: 4pt, text(size: 0.8em)[Progress: #progress], rect(
      inset: 0pt,
      width: 150pt,
      height: 8pt,
      fill: gray.lighten(80%),
      rect(width: 150pt * progress, height: 8pt, fill: blue),
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
)

== Interactive Elements

#wechat.chat(
  theme: "dark",
  width: 400pt,

  oc.time[16:00],

  oc.message(left, alice)[
    Code snippets with syntax highlighting:

    ```python
    def fibonacci(n):
        if n <= 1:
            return n
        return fibonacci(n-1) + fibonacci(n-2)
    ```
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

  oc.message(left, charlie)[
    Lists and nested content:

    1. *Primary features*
      - Message bubbles
      - Custom avatars
      - Multiple themes

    2. *Advanced features*
      - Rich content embedding
      - Custom styling
      - Theme customization

    3. *Developer friendly*
      - Simple API
      - Extensible design
      - Great documentation
  ],
)

== Theme Comparison

#grid(
  columns: 2,
  gutter: 1em,
  [
    *Light Theme*
    #wechat.chat(
      width: 200pt,
      theme: "light",
      oc.message(left, alice)[Beautiful light theme! ☀️],
      oc.message(right, bob)[Clean and modern],
    )
  ],
  [
    *Dark Theme*
    #wechat.chat(
      width: 200pt,
      theme: "dark",
      oc.message(left, alice)[Sleek dark theme! 🌙],
      oc.message(right, bob)[Perfect for night mode],
    )
  ],
)

== Complex Layout Example

#wechat.chat(
  theme: "light",
  width: 400pt,

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
