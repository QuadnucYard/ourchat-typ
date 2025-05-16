// discord peeps only use da dak deme
#let default-theme = (
  text-color: rgb("#DEDFE2"),
  secondary-text-color: rgb("#9A9BA2"),
  link-color: rgb("#375082"),
  name-color: rgb("#FCF9F6"),
  bg-color: rgb("#2F3137"),
  time-block-color: rgb("#000000").transparentize(70%),
  line-color: rgb("#43444B"),
)

#let discord-newbie = stack(
  dir: ltr,
  block(
    height: 15pt,
    width: 15pt,
    image(
      width: 100%,
      height: 100%,
      bytes("<svg aria-hidden=\"true\" role=\"img\" xmlns=\"http://www.w3.org/2000/svg\" width=\"20\" height=\"20\" fill=\"#6FC381\" viewBox=\"0 0 24 24\"><path fill=\"#6FC381\" d=\"M11.55 14.4c.28.17.62.17.9 0 1.6-.96 6.88-4.46 6.88-8.57A3.83 3.83 0 0 0 15.5 2c-1.56 0-2.58.6-3.5 1.5A4.66 4.66 0 0 0 8.5 2a3.83 3.83 0 0 0-3.83 3.83c0 4.1 5.29 7.61 6.88 8.57Z\" class=\"\"></path><path fill=\"#6FC381\" d=\"M3.11 14.86a1 1 0 0 0-.83 1.24l.23.89a6 6 0 0 0 6.46 4.45l2.03-.22V22a1 1 0 1 0 2 0v-.78l2.03.22A6 6 0 0 0 21.5 17l.23-.89a1 1 0 0 0-.83-1.24l-2.05-.29a6 6 0 0 0-6.1 3.07L12 19l-.74-1.36a6 6 0 0 0-6.1-3.07l-2.05.29ZM2.93 9.4a.6.6 0 0 1 1.14 0l.1.25a2 2 0 0 0 1.18 1.19l.25.1a.6.6 0 0 1 0 1.13l-.25.1a2 2 0 0 0-1.19 1.18l-.1.25a.6.6 0 0 1-1.13 0l-.1-.25a2 2 0 0 0-1.18-1.19l-.25-.1a.6.6 0 0 1 0-1.13l.25-.1a2 2 0 0 0 1.19-1.18l.1-.25ZM21.46 9.82a.49.49 0 0 0-.92 0v.03a2 2 0 0 1-1.19 1.18l-.03.01a.49.49 0 0 0 0 .92h.03a2 2 0 0 1 1.18 1.19l.01.03c.16.43.76.43.92 0v-.03a2 2 0 0 1 1.19-1.18l.03-.01a.49.49 0 0 0 0-.92h-.03a2 2 0 0 1-1.18-1.19l-.01-.03Z\" class=\"\"></path></svg>"),
    ),
  ),
  h(5pt),
)

#let discord(
  ..messages,
  default-profile: none,
  show-profile: false,
  theme: none,
  width: 500pt,
) = {
  // prepare theme
  let color-theme = if theme == none { default-theme } else {
    assert(type(theme) == dictionary, message: "the custom theme should be a dictionary!")
    default-theme + theme
  }
  let theme = (
    text-color: color-theme.text-color,
    link-color: color-theme.link-color,
    sign: -1,
    profile-x: 2,
  )

  set par(leading: 0.575em, spacing: 1em)

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "datetime" {
      let cell = grid(
        columns: (1fr, auto, 1fr),
        align: horizon,
        gutter: 1em,
        line(stroke: color-theme.line-color + .5pt, length: 100%),
        text(fill: color-theme.secondary-text-color, size: .8em, weight: 600)[#msg.body],
        line(stroke: color-theme.line-color + .5pt, length: 100%),
      )
      cells.push(grid.cell(x: 0, y: i, align: center, cell, colspan: 2))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let profile = msg.profile
      if profile == none { profile = default-profile }

      let body-block = {
        set block(spacing: 1pt)
        set text(size: 11.5pt)
        show link: set text(theme.link-color)

        // sender name
        stack(
          dir: ltr,
          if msg.name != none {
            block(
              height: 1em,
              align(
                bottom,
                text(size: 1em, fill: color-theme.name-color, cjk-latin-spacing: none, text(weight: 500)[#msg.name]),
              ),
            )
          },
          h(2pt),
          if msg.title != none {
            msg.title
          },
          h(2pt),
          if msg.time != none {
            block(
              height: 1em,
              align(bottom, (text(fill: color-theme.secondary-text-color, size: .8em, weight: 500)[#msg.time])),
            )
          },
        )
        if msg.kind == "message" {
          pad(top: 6pt, text(cjk-latin-spacing: none, fill: theme.text-color, align(left, msg.body)))
        } else if msg.kind == "plain" {
          block(radius: 2.5pt, clip: true, msg.body)
        }
      }

      let profile-block = align(center, block(width: 100%, radius: 100pt, clip: true, profile))
      cells.push(grid.cell(x: 0, y: i, profile-block))
      cells.push(grid.cell(x: 1, y: i, align: left, body-block))
    }
  }

  show: block.with(width: width, fill: color-theme.bg-color, inset: 8pt)
  grid(columns: (27pt, 1fr), row-gutter: 1.5em, column-gutter: 10pt, ..cells)
}
