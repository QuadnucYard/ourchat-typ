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
#let default-constants = (
  // Overall layout
  content-width: 270pt,
  content-inset: 8pt,
  // Grid layout
  profile-width: 27pt,
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
  // Profile styling
  profile-radius: 100pt,
  profile-width-1: 90%,
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
/// - messages: The items created by `time` or `message`.
/// - theme (str, dictionary): The chat theme.
/// - constants (dictionary): Override layout constants.
///
/// -> content
#let chat(
  ..messages,
  theme: auto,
  constants: (:),
) = {
  let color-theme = resolve-theme(builtin-themes, theme, default: "light")

  // Merge default constants with user overrides
  let const = default-constants + constants

  let left-theme = (
    text-color: color-theme.left-text-color,
    link-color: color-theme.left-link-color,
    bubble-color: color-theme.left-bubble-color,
    sign: 1,
    profile-x: 0,
  )
  let right-theme = (
    text-color: color-theme.right-text-color,
    link-color: color-theme.right-link-color,
    bubble-color: color-theme.right-bubble-color,
    sign: -1,
    profile-x: 2,
  )

  set par(leading: const.par-leading, spacing: const.par-spacing)

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      let time-block = {
        set text(size: const.time-text-size, fill: color-theme.name-color, cjk-latin-spacing: none)
        block(
          height: const.time-height,
          inset: const.time-inset,
          radius: const.time-radius,
          fill: color-theme.time-block-color,
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
              size: const.name-text-size,
              fill: color-theme.name-color,
              cjk-latin-spacing: none,
            )
            block(height: 1em, align(horizon, user.name))
          },
          h(2pt, weak: true),
          if title != none {
            set text(size: const.title-text-size, fill: title.text-color, cjk-latin-spacing: none)
            block(
              height: const.title-height,
              inset: const.title-inset,
              radius: const.title-radius,
              fill: title.bg-color,
              align(horizon, title.body),
            )
          },
        )
      }

      let message-block = {
        set text(size: const.message-text-size)
        show link: set text(sub-theme.link-color)

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          set text(cjk-latin-spacing: none, fill: sub-theme.text-color)
          block(fill: bubble-color, radius: const.bubble-radius, inset: const.bubble-inset, align(
            left,
            msg.body,
          ))
        } else if msg.kind == "plain" {
          block(radius: const.bubble-radius, clip: true, msg.body)
        }
      }

      let body-block = {
        sender-block
        v(2pt, weak: true)
        message-block
      }

      let profile-block = align(center, block(
        width: const.profile-width-1,
        radius: const.profile-radius,
        clip: true,
        user.profile,
      ))
      cells.push(grid.cell(x: 1, y: i, align: msg.side, body-block))
      cells.push(grid.cell(x: sub-theme.profile-x, y: i, profile-block))
    }
  }

  show: block.with(
    width: const.content-width,
    fill: color-theme.bg-color,
    inset: const.content-inset,
  )
  grid(
    columns: (const.profile-width, 1fr, const.profile-width),
    row-gutter: const.row-gutter,
    column-gutter: const.column-gutter,
    ..cells
  )
}
