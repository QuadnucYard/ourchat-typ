/// Wechat theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme

/// The default avatar of Ourchat
#let default-avatar = image("../assets/wechat-avatar.svg")

#let default-user = user.with(avatar: default-avatar)

/// Default light theme
#let light-theme = (
  background: rgb("#ededed"),
  bubble-left: rgb("#ffffff"),
  bubble-right: rgb("#95ec69"),
  text-left: rgb("#191919"),
  text-right: rgb("#0f170a"),
  text-link-left: rgb("#576b95"),
  text-link-right: rgb("#576b95"),
  text-name: rgb("#888888"),
)

/// Default dark theme
#let dark-theme = (
  background: rgb("#111111"),
  bubble-left: rgb("#2c2c2c"),
  bubble-right: rgb("#3eb575"),
  text-left: rgb("#d5d5d5"),
  text-right: rgb("#06120b"),
  text-link-left: rgb("#7d90a9"),
  text-link-right: rgb("#375082"),
  text-name: rgb("#888888"),
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
  row-gutter: 11.75pt,
  column-gutter: 7.5pt,
  avatar-column-width: 27pt,
  // Text sizing
  message-text-size: 11.5pt,
  name-text-size: 8pt,
  time-text-size: 8pt,
  // Paragraph formatting
  par-leading: 0.6em,
  par-spacing: 0.6em,
  // Element heights
  name-height: 11pt,
  time-height: 1.4em,
  avatar-radius: 2.5pt,
  // Bubble styling
  bubble-radius: 2.5pt,
  bubble-inset: 0.7em,
  bubble-tail-size: 6.5pt,
  bubble-tail-offset-y: 11.5pt,
  bubble-tail-radius: 1pt,
)

/// Create a wechat style chat.
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
  let sty = default-layout + layout

  let left-theme = (
    text-color: theme.text-left,
    link-color: theme.text-link-left,
    bubble-color: theme.bubble-left,
    sign: 1,
    avatar-x: 0,
  )
  let right-theme = (
    text-color: theme.text-right,
    link-color: theme.text-link-right,
    bubble-color: theme.bubble-right,
    sign: -1,
    avatar-x: 2,
  )

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      let time-block = {
        set text(size: sty.time-text-size, fill: theme.text-name, cjk-latin-spacing: none)
        show: block.with(height: sty.time-height)
        align(center + horizon, msg.body)
      }
      cells.push(grid.cell(x: 1, y: i, align: center, time-block))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user
      let sub-theme = if msg.side == left {
        left-theme
      } else {
        right-theme
      }

      let sender-block = if user.name != none and msg.side == left {
        set text(
          size: sty.name-text-size,
          fill: theme.text-name,
          cjk-latin-spacing: none,
        )
        show: block.with(height: sty.name-height, inset: (left: 1.25pt))
        align(horizon, user.name)
      }

      let message-block = {
        set text(size: sty.message-text-size)
        show link: set text(sub-theme.link-color)

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          // small tip
          place(msg.side, dy: sty.bubble-tail-offset-y, rotate(
            45deg * sub-theme.sign,
            origin: top,
            rect(
              width: sty.bubble-tail-size,
              height: sty.bubble-tail-size,
              radius: sty.bubble-tail-radius,
              fill: bubble-color,
            ),
          ))

          // message body
          show: block.with(fill: bubble-color, radius: sty.bubble-radius, inset: (
            x: 0.7em,
            y: 0.8em,
          ))
          set text(fill: sub-theme.text-color, tracking: 0.1pt)
          set par(justify: true)
          align(left, msg.body)
          v(-1pt)
        } else if msg.kind == "plain" {
          block(radius: sty.bubble-radius, clip: true, msg.body)
        }
      }

      let body-block = {
        sender-block
        v(0.75pt, weak: true)
        message-block
      }

      let avatar-block = block(width: 100%, radius: sty.avatar-radius, clip: true, user.avatar)

      cells.push(grid.cell(x: 1, y: i, align: msg.side, body-block))
      cells.push(grid.cell(x: sub-theme.avatar-x, y: i, avatar-block))
    }
  }

  set par(leading: sty.par-leading, spacing: sty.par-spacing)
  show: block.with(
    width: sty.content-width,
    fill: theme.background,
    inset: sty.content-inset,
  )
  grid(
    columns: (sty.avatar-column-width, 1fr, sty.avatar-column-width),
    row-gutter: sty.row-gutter,
    column-gutter: sty.column-gutter,
    ..cells
  )
}
