/// Wechat theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme

/// The default profile of Ourchat
#let default-profile = image("../assets/wechat-profile.svg")

#let default-user = user.with(profile: default-profile)

/// Default light theme
#let light-theme = (
  right-text-color: rgb("#0f170a"),
  left-text-color: rgb("#191919"),
  right-link-color: rgb("#576b95"),
  left-link-color: rgb("#576b95"),
  name-color: rgb("#888888"),
  left-bubble-color: rgb("#ffffff"),
  right-bubble-color: rgb("#95ec69"),
  bg-color: rgb("#ededed"),
)

/// Default dark theme
#let dark-theme = (
  right-text-color: rgb("#06120b"),
  left-text-color: rgb("#d5d5d5"),
  right-link-color: rgb("#375082"),
  left-link-color: rgb("#7d90a9"),
  name-color: rgb("#888888"),
  left-bubble-color: rgb("#2c2c2c"),
  right-bubble-color: rgb("#3eb575"),
  bg-color: rgb("#111111"),
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
  name-text-size: 8pt,
  time-text-size: 8pt,
  // Paragraph formatting
  par-leading: 0.575em,
  par-spacing: 0.65em,
  // Bubble styling
  bubble-radius: 2.5pt,
  bubble-inset: 0.8em,
  bubble-tail-size: 6pt,
  bubble-tail-offset-y: 9pt,
  bubble-tail-radius: 1pt,
  // Element heights
  name-height: 1em,
  time-height: 1.4em,
  profile-radius: 2.5pt,
)

/// Create a wechat style chat.
///
/// - messages: The items created by `time` or `message`.
/// - theme (str, dictionary): The chat theme.
/// - width (length): The width of the whole block.
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
        block(height: const.time-height, align(center + horizon, msg.body))
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
          size: const.name-text-size,
          fill: color-theme.name-color,
          cjk-latin-spacing: none,
        )
        block(height: const.name-height, align(horizon, user.name))
      }

      let message-block = {
        set text(size: const.message-text-size)
        show link: set text(sub-theme.link-color)

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          // small tip
          place(msg.side, dy: const.bubble-tail-offset-y, rotate(
            45deg * sub-theme.sign,
            origin: top,
            rect(
              width: const.bubble-tail-size,
              height: const.bubble-tail-size,
              radius: const.bubble-tail-radius,
              fill: bubble-color,
            ),
          ))

          // message body
          set text(fill: sub-theme.text-color)
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

      let profile-block = block(width: 100%, radius: const.profile-radius, clip: true, user.profile)

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
