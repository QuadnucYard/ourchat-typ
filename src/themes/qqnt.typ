/// QQNT theme
#import "../components.typ": *
#import "../utils.typ": resolve-theme, stretch-cover

/// Default light theme
#let light-theme = (
  background: gradient.linear(rgb("#FAF2FF"), rgb("#D8EAFF"), angle: 30deg),
  timestamp-background: rgb("#FFFFFF").transparentize(60%),
  bubble-left: rgb("#ffffff"),
  bubble-right: rgb("#0098FF"),
  text-left: rgb("#191919"),
  text-right: rgb("#FFFFFF"),
  text-link-left: rgb("#576b95"),
  text-link-right: rgb("#9AE9FF"),
  text-username: rgb("#888888"),
  text-timestamp: rgb("#888888"),
)

/// Default dark theme
#let dark-theme = (
  background: gradient.linear(rgb("#2A252F"), rgb("#021F2E"), angle: 30deg),
  timestamp-background: rgb("#000000").transparentize(70%),
  bubble-left: rgb("#393939"),
  bubble-right: rgb("#0064CD"),
  text-left: rgb("#FFFFFF"),
  text-right: rgb("#FFFFFF"),
  text-link-left: rgb("#7d90a9"),
  text-link-right: rgb("#375082"),
  text-username: rgb("#888888"),
  text-timestamp: rgb("#888888"),
)

#let builtin-themes = (
  light: light-theme,
  dark: dark-theme,
)

/// Layout constants that can be overridden
#let default-layout = (
  // Overall layout
  content-width: 480pt,
  content-inset: (x: 45pt, y: 15pt),
  // Text sizing
  main-text-size: 10.5pt,
  message-text-size: 1em,
  username-text-size: 9pt,
  title-text-size: 7.5pt,
  timestamp-text-size: 9pt,
  // Paragraph formatting
  par-leading: 0.8em,
  par-spacing: 0.825em,
  // Bubble styling
  message-spacing-above: 2.0em,
  bubble-padding: 2em,
  bubble-inset: (x: 0.7em, y: 0.9em),
  bubble-radius: 5pt,
  // Title styling
  username-height: 1.05em,
  title-spacing: 0.3em,
  title-height: 1.2em,
  title-inset: (x: 3pt),
  title-radius: 3pt,
  // Avatar styling
  avatar-offset-x: -30pt,
  avatar-width: 36pt,
  avatar-size: 24pt,
  avatar-radius: 50%,
  // Timestamp styling
  timestamp-spacing-above: 2.5em,
  timestamp-spacing-below: 1.0em,
  timestamp-height: 1.4em,
  timestamp-radius: 0.6em,
  timestamp-inset: 0.6em,
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
  let sty = default-layout + layout

  let left-theme = (
    text-color: theme.text-left,
    link-color: theme.text-link-left,
    bubble-color: theme.bubble-left,
  )
  let right-theme = (
    text-color: theme.text-right,
    link-color: theme.text-link-right,
    bubble-color: theme.bubble-right,
  )

  set text(size: sty.main-text-size)
  set par(leading: sty.par-leading, spacing: sty.par-spacing)

  show: block.with(width: sty.content-width, fill: theme.background, inset: sty.content-inset)

  for (i, msg) in messages.pos().enumerate() {
    if msg.kind == "time" {
      show: it => (
        v(sty.timestamp-spacing-above, weak: true) + it + v(sty.timestamp-spacing-below, weak: true)
      )
      show: align.with(center)
      show: block.with(
        height: sty.timestamp-height,
        inset: sty.timestamp-inset,
        radius: sty.timestamp-radius,
        fill: theme.timestamp-background,
      )
      set text(
        size: sty.timestamp-text-size,
        weight: "light",
        fill: theme.text-timestamp,
        cjk-latin-spacing: none,
      )
      align(center + horizon, msg.body)
    } else if msg.kind == "message" or msg.kind == "plain" {
      let user = msg.user
      let sub-theme = if msg.side == left {
        left-theme
      } else {
        right-theme
      }

      let avatar-block = {
        show: pad.with(top: 1pt, x: sty.avatar-offset-x)
        show: block.with(
          width: sty.avatar-size,
          height: sty.avatar-size,
          radius: sty.avatar-radius,
          clip: true,
        )
        stretch-cover(user.avatar)
      }

      let sender-block = {
        let title = user.title

        let items = (
          if user.name != none {
            set text(
              size: sty.username-text-size,
              fill: theme.text-username,
              cjk-latin-spacing: none,
            )
            align(horizon, user.name)
          },
          if title != none {
            show: box.with(
              height: sty.title-height,
              inset: sty.title-inset,
              radius: sty.title-radius,
              fill: title.bg-color,
            )
            set text(size: sty.title-text-size, fill: title.text-color, cjk-latin-spacing: none)
            align(horizon, title.body)
          },
        )

        show: block.with(height: sty.username-height)
        show: align.with(horizon)
        set text(weight: "light")
        stack(
          dir: if msg.side == left { ltr } else { rtl },
          spacing: sty.title-spacing,
          ..items.filter(it => it != none),
        )
      }

      let message-block = {
        set text(size: sty.message-text-size)
        show link: set text(sub-theme.link-color)

        if msg.kind == "message" {
          let bubble-color = sub-theme.bubble-color

          show: block.with(fill: bubble-color, radius: sty.bubble-radius, inset: sty.bubble-inset)
          set text(cjk-latin-spacing: none, fill: sub-theme.text-color)
          align(left, msg.body)
          v(1pt)
        } else if msg.kind == "plain" {
          block(radius: sty.bubble-radius, clip: true, msg.body)
        }
      }

      show: block.with(above: sty.message-spacing-above, width: 100%)
      show: align.with(msg.side)
      place(msg.side, avatar-block)
      sender-block
      v(3pt, weak: true)
      if msg.side == left {
        pad(right: sty.bubble-padding, message-block)
      } else {
        pad(left: sty.bubble-padding, message-block)
      }
    }
  }
}
