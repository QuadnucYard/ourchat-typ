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

#let newbie = stack(
  dir: ltr,
  block(height: 15pt, width: 15pt, image(
    width: 100%,
    height: 100%,
    "../assets/discord-newbie.svg",
  )),
  h(5pt),
)

#let chat(
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
            block(height: 1em, align(bottom, text(
              size: 1em,
              fill: color-theme.name-color,
              cjk-latin-spacing: none,
              text(weight: 500)[#msg.name],
            )))
          },
          h(2pt),
          if msg.title != none {
            msg.title
          },
          h(2pt),
          if msg.time != none {
            block(height: 1em, align(bottom, (
              text(fill: color-theme.secondary-text-color, size: .8em, weight: 500)[#msg.time]
            )))
          },
        )
        if msg.kind == "message" {
          pad(top: 6pt, text(cjk-latin-spacing: none, fill: theme.text-color, align(
            left,
            msg.body,
          )))
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
