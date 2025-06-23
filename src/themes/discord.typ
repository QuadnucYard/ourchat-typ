/// Discord theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme

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

#let builtin-themes = (
  default: default-theme,
)

/// Layout constants that can be overridden
#let default-constants = (
  // Overall layout
  content-width: 500pt,
  content-inset: 8pt,
  // Grid layout
  profile-width: 27pt,
  row-gutter: 1.5em,
  column-gutter: 10pt,
  // Text sizing
  message-text-size: 11.5pt,
  name-text-size: 1em,
  time-text-size: 0.8em,
  // Paragraph formatting
  par-leading: 0.575em,
  par-spacing: 1em,
  // Profile styling
  profile-radius: 100pt,
  // Element styling
  element-radius: 2.5pt,
  // Element heights
  name-height: 1em,
  // Time separator styling
  time-line-stroke: 0.5pt,
  time-gutter: 1em,
)

#let newbie = stack(dir: ltr, image(width: 15pt, height: 15pt, "../assets/discord-newbie.svg"), h(
  5pt,
))

#let newbie-user = user.with(title: newbie)

#let chat(
  ..messages,
  theme: auto,
  constants: (:),
) = {
  let color-theme = resolve-theme(builtin-themes, theme, default: "default")

  // Merge default constants with user overrides
  let const = default-constants + constants

  let theme = (
    text-color: color-theme.text-color,
    link-color: color-theme.link-color,
    sign: -1,
    profile-x: 2,
  )

  set par(leading: const.par-leading, spacing: const.par-spacing)

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      let time-block = {
        set text(
          fill: color-theme.secondary-text-color,
          size: const.time-text-size,
          weight: 600,
        )
        let div-line = line(length: 100%, stroke: color-theme.line-color + const.time-line-stroke)
        grid(
          columns: (1fr, auto, 1fr),
          align: horizon,
          gutter: const.time-gutter,
          div-line, msg.body, div-line,
        )
      }
      cells.push(grid.cell(x: 0, y: i, align: center, colspan: 2, time-block))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user

      let sender-block = {
        stack(
          dir: ltr,
          if user.name != none {
            set text(
              size: const.name-text-size,
              fill: color-theme.name-color,
              cjk-latin-spacing: none,
              weight: 500,
            )
            block(height: const.name-height, align(bottom, user.name))
          },
          h(2pt, weak: true),
          user.title,
          h(2pt, weak: true),
          if msg.time != none {
            set text(
              fill: color-theme.secondary-text-color,
              size: .8em,
              weight: 500,
            )
            block(height: 1em, align(bottom, msg.time))
          },
        )
      }

      let message-block = {
        set text(size: const.message-text-size)
        show link: set text(theme.link-color)

        if msg.kind == "message" {
          set text(
            cjk-latin-spacing: none,
            fill: theme.text-color,
          )
          block(align(left, msg.body))
        } else if msg.kind == "plain" {
          block(radius: const.element-radius, clip: true, msg.body)
        }
      }

      let body-block = {
        sender-block
        v(6pt, weak: true)
        message-block
      }

      let profile-block = block(width: 100%, radius: const.profile-radius, clip: true, align(
        center,
        user.profile,
      ))

      cells.push(grid.cell(x: 0, y: i, profile-block))
      cells.push(grid.cell(x: 1, y: i, align: left, body-block))
    }
  }

  show: block.with(
    width: const.content-width,
    fill: color-theme.bg-color,
    inset: const.content-inset,
  )
  grid(
    columns: (const.profile-width, 1fr),
    row-gutter: const.row-gutter,
    column-gutter: const.column-gutter,
    ..cells
  )
}
