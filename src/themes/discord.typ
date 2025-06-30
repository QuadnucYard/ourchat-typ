/// Discord theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme, resolve-layout, stretch-cover

// discord peeps only use da dak deme
#let default-theme = (
  background: oklab(21.9499%, 0.00211129, -0.00744916),
  text-normal: oklab(95.2331%, 0.000418991, -0.00125992),
  text-muted: oklab(61.1686%, 0.00218612, -0.0118227),
  text-link: oklab(67.0158%, -0.038477, -0.141411),
  text-username: oklab(98.8044%, 0.0000450313, 0.0000197887),
  divider-color: rgb(151, 151, 159, 12%),
)

#let builtin-themes = (
  default: default-theme,
)

/// Layout constants that can be overridden
#let default-layout = (
  // Overall layout
  content-scale: 75%,
  content-width: 640pt,
  content-inset: (y: 16pt),
  group-spacing-start: 1.0625em,
  message-margin-left: 72pt,
  avatar-size: 40pt,
  // Text sizing
  main-text-size: 17pt,
  message-text-size: 1em,
  username-text-size: 1em,
  timestamp-text-size: 0.75em,
  // Paragraph formatting
  par-leading: 0.375em,
  par-spacing: 0.25em + 0.375em,
  markup-line-height: 1.375em,
  username-line-height: 1.375em,
  // Time divider styling
  divider-above: 1.5em,
  divider-below: 0.5em,
  divider-left: 1.0em,
  divider-right: 0.875em,
  time-line-stroke: 0.8pt,
)

#let newbie = image(width: 15pt, "../assets/discord-newbie.svg")

#let newbie-user = user.with(title: newbie)

#let chat(
  theme: auto,
  layout: (:),
  validate: true,
  ..messages,
) = {
  let theme = resolve-theme(builtin-themes, theme, default: "default", validate: validate)
  let sty = resolve-layout(layout, default-layout, validate: validate)

  show: scale.with(sty.content-scale, reflow: true)
  show: block.with(
    width: sty.content-width,
    inset: sty.content-inset,
    fill: theme.background,
  )
  set text(size: sty.main-text-size)
  set par(leading: sty.par-leading, spacing: sty.par-spacing)

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      show: block.with(
        width: 100%,
        height: 0pt,
        above: sty.divider-above,
        below: sty.divider-below,
        inset: (
          left: sty.divider-left,
          right: sty.divider-right,
        ),
      )
      show: block.with(width: 100%, stroke: (top: theme.divider-color + sty.time-line-stroke))
      set align(horizon + center)
      show: block.with(height: 13pt, inset: (x: 4pt, y: 2pt), fill: theme.background)
      set text(
        fill: theme.text-muted,
        cjk-latin-spacing: none,
        size: 12pt,
        weight: 600,
      )
      msg.body
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user

      let avatar-block = {
        set align(center)
        show: block.with(width: sty.avatar-size, height: sty.avatar-size, radius: 50%, clip: true)
        stretch-cover(user.avatar)
      }

      let header-block = {
        show: block.with(height: sty.username-line-height)
        set align(horizon)
        set text(
          size: sty.username-text-size,
          fill: theme.text-username,
          cjk-latin-spacing: none,
          weight: 500,
        )
        let items = (
          if user.name != none {
            text(
              fill: theme.text-username,
              user.name,
            )
          },
          user.title,
          if msg.time != none {
            text(
              fill: theme.text-muted,
              size: sty.timestamp-text-size,
              msg.time,
            )
          },
        )
        stack(dir: ltr, spacing: 0.5em, ..items.filter(it => it != none))
      }

      let message-block = {
        set text(size: sty.message-text-size, fill: theme.text-normal, cjk-latin-spacing: none)
        show link: set text(fill: theme.text-link)

        if msg.kind == "message" {
          block(width: 100%, align(left, msg.body))
        }
      }

      show: block.with(above: sty.group-spacing-start)
      place(left, dx: sty.message-margin-left / 2, dy: 4pt - 0.125em, place(center, avatar-block))
      show: pad.with(left: sty.message-margin-left, y: 0.125em)
      header-block
      v(6pt, weak: true)
      message-block
    }
  }
}
