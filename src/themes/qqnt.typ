/// QQNT theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme

/// Default light theme
#let light-theme = (
  right-text-color: rgb("#FFFFFF"),
  left-text-color: rgb("#191919"),
  right-link-color: rgb("#9AE9FF"),
  left-link-color: rgb("#576b95"),
  name-color: rgb("#888888"),
  left-bubble-color: rgb("#ffffff"),
  right-bubble-color: rgb("#0098FF"),
  bg-color: gradient.linear(rgb("#FAF2FF"), rgb("#D8EAFF"), angle: 30deg),
  time-block-color: rgb("#FFFFFF").transparentize(60%),
)

/// Default dark theme
#let dark-theme = (
  right-text-color: rgb("#FFFFFF"),
  left-text-color: rgb("#FFFFFF"),
  right-link-color: rgb("#375082"),
  left-link-color: rgb("#7d90a9"),
  name-color: rgb("#888888"),
  left-bubble-color: rgb("#393939"),
  right-bubble-color: rgb("#0064CD"),
  bg-color: gradient.linear(rgb("#2A252F"), rgb("#021F2E"), angle: 30deg),
  time-block-color: rgb("#000000").transparentize(70%),
)

#let builtin-themes = (
  light: light-theme,
  dark: dark-theme,
)

/// Layout constants that can be overridden
#let default-layout = (
  // Overall layout
  content-width: 270pt,
  content-inset: 8pt,
  // Grid layout
  avatar-width: 27pt,
  row-gutter: 0.65em,
  column-gutter: 7.5pt,
  // Text sizing
  message-text-size: 11.5pt,
  name-text-size: 0.7em,
  time-text-size: 0.7em,
  title-text-size: 0.55em,
  // Paragraph formatting
  par-leading: 0.575em,
  par-spacing: 0.65em,
  // Bubble styling
  bubble-radius: 5pt,
  bubble-inset: 0.8em,
  // avatar styling
  avatar-radius: 100pt,
  avatar-width-1: 90%,
  // Element heights
  name-height: 1em,
  time-height: 1.2em,
  title-height: 1.2em,
  // Time block styling
  time-radius: 0.6em,
  time-inset: 0.6em,
  // Title styling
  title-inset: 2pt,
  title-radius: 2pt,
)

#let title(
  body,
  text-color: rgb("#FF8D37"),
  bg-color: rgb("#FF8D37").transparentize(80%),
) = {
  (
    body: body,
    text-color: text-color,
    bg-color: bg-color,
  )
}

/// Create a qqnt style chat.
///
/// - theme (str, dictionary): The chat theme.
/// - layout (dictionary): Override layout constants.
/// - messages: The items created by `time` or `message`.
///
/// -> content
#let chat(
  theme: auto,
  layout: (:),
  ..messages,
) = {
  let theme = resolve-theme(builtin-themes, theme, default: "light")

  // Merge default constants with user overrides
  let sty = default-layout + layout

  let left-theme = (
    text-color: theme.left-text-color,
    link-color: theme.left-link-color,
    bubble-color: theme.left-bubble-color,
    sign: 1,
    avatar-x: 0,
  )
  let right-theme = (
    text-color: theme.right-text-color,
    link-color: theme.right-link-color,
    bubble-color: theme.right-bubble-color,
    sign: -1,
    avatar-x: 2,
  )

  set par(leading: sty.par-leading, spacing: sty.par-spacing)

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      let time-block = {
        set text(size: sty.time-text-size, fill: theme.name-color, cjk-latin-spacing: none)
        block(
          height: sty.time-height,
          inset: sty.time-inset,
          radius: sty.time-radius,
          fill: theme.time-block-color,
          align(center + horizon, msg.body),
        )
      }
      cells.push(grid.cell(x: 1, y: i, align: center, time-block))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user
      let sub-theme = if msg.side == left {
        left-theme
      } else {
        right-theme
      }

      let sender-block = {
        let title = user.title

        stack(
          dir: if msg.side == left { ltr } else { rtl },
          if user.name != none {
            set text(
              size: sty.name-text-size,
              fill: theme.name-color,
              cjk-latin-spacing: none,
            )
            block(height: 1em, align(horizon, user.name))
          },
          h(2pt, weak: true),
          if title != none {
            set text(size: sty.title-text-size, fill: title.text-color, cjk-latin-spacing: none)
            block(
              height: sty.title-height,
              inset: sty.title-inset,
              radius: sty.title-radius,
              fill: title.bg-color,
              align(horizon, title.body),
            )
          },
        )
      }

      let message-block = {
        set text(size: sty.message-text-size)
        show link: set text(sub-theme.link-color)

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          set text(cjk-latin-spacing: none, fill: sub-theme.text-color)
          block(fill: bubble-color, radius: sty.bubble-radius, inset: sty.bubble-inset, align(
            left,
            msg.body,
          ))
        } else if msg.kind == "plain" {
          block(radius: sty.bubble-radius, clip: true, msg.body)
        }
      }

      let body-block = {
        sender-block
        v(2pt, weak: true)
        message-block
      }

      let avatar-block = align(center, block(
        width: sty.avatar-width-1,
        radius: sty.avatar-radius,
        clip: true,
        user.avatar,
      ))
      cells.push(grid.cell(x: 1, y: i, align: msg.side, body-block))
      cells.push(grid.cell(x: sub-theme.avatar-x, y: i, avatar-block))
    }
  }

  show: block.with(
    width: sty.content-width,
    fill: theme.bg-color,
    inset: sty.content-inset,
  )
  grid(
    columns: (sty.avatar-width, 1fr, sty.avatar-width),
    row-gutter: sty.row-gutter,
    column-gutter: sty.column-gutter,
    ..cells
  )
}
