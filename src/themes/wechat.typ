/// Wechat theme
#import "../components.typ": *


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

/// Create a wechat style chat.
///
/// - messages: The items created by `time` or `message`.
/// - theme (str, dictionary): The chat theme.
/// - width (length): The width of the whole block.
///
/// -> content
#let chat(
  ..messages,
  theme: "light",
  width: 270pt,
) = {
  // prepare theme
  let color-theme = if theme == "light" {
    light-theme
  } else if theme == "dark" {
    dark-theme
  } else {
    assert(type(theme) == dictionary, message: "the custom theme should be a dictionary!")
    light-theme + theme
  }
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

  set par(leading: 0.575em, spacing: 0.65em)

  let cells = ()

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      let cell = block(height: 1.4em, align(center + horizon, text(
        size: 0.7em,
        fill: color-theme.name-color,
        cjk-latin-spacing: none,
        msg.body,
      )))
      cells.push(grid.cell(x: 1, y: i, align: center, cell))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user
      let sub-theme = if msg.side == left {
        left-theme
      } else {
        right-theme
      }

      let body-block = {
        set block(spacing: 1pt)
        set text(size: 11.5pt)
        show link: set text(sub-theme.link-color)

        // sender name
        if user.name != none and msg.side == left {
          block(height: 1em, align(horizon, text(
            size: 0.7em,
            fill: color-theme.name-color,
            cjk-latin-spacing: none,
            user.name,
          )))
        }

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          // small tip
          place(msg.side, dy: 9pt, rotate(45deg * sub-theme.sign, origin: top, rect(
            width: 6pt,
            height: 6pt,
            radius: 1pt,
            fill: bubble-color,
          )))

          // message body
          block(fill: bubble-color, radius: 2.5pt, inset: 0.8em, text(
            fill: sub-theme.text-color,
            align(left, msg.body),
          ))
        } else if msg.kind == "plain" {
          block(radius: 2.5pt, clip: true, msg.body)
        }
      }

      let profile-block = block(width: 100%, radius: 2.5pt, clip: true, user.profile)
      cells.push(grid.cell(x: 1, y: i, align: msg.side, body-block))
      cells.push(grid.cell(x: sub-theme.profile-x, y: i, profile-block))
    }
  }

  show: block.with(width: width, fill: color-theme.bg-color, inset: 8pt)
  grid(columns: (27pt, 1fr, 27pt), row-gutter: 0.65em, column-gutter: 7.5pt, ..cells)
}
