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

#let title(
  title-block-color: rgb("#FF8D37").transparentize(80%),
  title-text-color: rgb("#FF8D37"),
  title,
) = {
  align(horizon, block(radius: 2pt, fill: title-block-color, height: .8em, pad(2pt, text(
    size: 0.55em,
    fill: title-text-color,
    cjk-latin-spacing: none,
    title,
  ))))
}

/// Create a qqnt style chat.
///
/// - messages: The items created by `datetime` or `message`.
/// - theme (str, dictionary): The chat theme.
/// - width (length): The width of the whole block.
/// - left-profile (content): The default profile for the left user.
/// - right-profile (content): The default profile for the right user.
///
/// -> content
#let chat(
  ..messages,
  theme: "light",
  width: 270pt,
  left-profile: none,
  right-profile: none,
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
    if msg.kind == "datetime" {
      let cell = block(height: 1.2em, radius: .6em, fill: color-theme.time-block-color, align(
        center + horizon,
        pad(left: .6em, right: .6em, text(
          size: 0.7em,
          fill: color-theme.name-color,
          cjk-latin-spacing: none,
          msg.body,
        )),
      ))
      cells.push(grid.cell(x: 1, y: i, align: center, cell))
    } else if msg.kind == "message" or msg.kind == "plain" {
      let sub-theme = if msg.side == left {
        left-theme
      } else {
        right-theme
      }
      let profile = msg.profile
      if profile == none {
        profile = if msg.side == left {
          left-profile
        } else {
          right-profile
        }
      }

      let body-block = {
        set block(spacing: 1pt)
        set text(size: 11.5pt)
        show link: set text(sub-theme.link-color)

        // sender name
        stack(
          dir: if msg.side == left { ltr } else { rtl },
          if msg.name != none {
            block(height: 1em, align(horizon, text(
              size: 0.7em,
              fill: color-theme.name-color,
              cjk-latin-spacing: none,
              msg.name,
            )))
          },
          h(2pt),
          if msg.title != none {
            msg.title
          },
        )

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          // message body
          block(fill: bubble-color, radius: 5pt, inset: 0.8em, text(
            cjk-latin-spacing: none,
            fill: sub-theme.text-color,
            align(left, msg.body),
          ))
        } else if msg.kind == "plain" {
          block(radius: 2.5pt, clip: true, msg.body)
        }
      }

      let profile-block = align(center, block(width: 90%, radius: 100pt, clip: true, profile))
      cells.push(grid.cell(x: 1, y: i, align: msg.side, body-block))
      cells.push(grid.cell(x: sub-theme.profile-x, y: i, profile-block))
    }
  }

  show: block.with(width: width, fill: color-theme.bg-color, inset: 8pt)
  grid(columns: (27pt, 1fr, 27pt), row-gutter: 0.65em, column-gutter: 7.5pt, ..cells)
}
