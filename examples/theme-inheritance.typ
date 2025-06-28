#import "../src/lib.typ" as oc
#import oc.themes: *

#set page(width: auto, height: auto, margin: 1em, fill: none)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let alice = oc.user(name: [Alice], avatar: circle(
  fill: gradient.radial(blue.lighten(60%), blue),
  text(white, size: 10pt, weight: "bold")[A],
))

#let bob = oc.user(name: [Bob], avatar: circle(
  fill: gradient.radial(green.lighten(60%), green),
  text(white, size: 10pt, weight: "bold")[B],
))

= Theme Inheritance Examples

== Built-in Themes

#grid(
  columns: 2,
  gutter: 1em,
  [
    *WeChat Light*
    #wechat.chat(theme: "light", width: 200pt, oc.message(left, alice)[Hello!], oc.message(
      right,
      bob,
    )[Hi there!])
  ],
  [
    *WeChat Dark*
    #wechat.chat(theme: "dark", width: 200pt, oc.message(left, alice)[Hello!], oc.message(
      right,
      bob,
    )[Hi there!])
  ],
)

== Custom Theme Inheriting from Light

#let custom-light = (
  inherit: "light",
  right-bubble-color: rgb("#FF6B6B"), // Custom red bubble
  left-bubble-color: rgb("#4ECDC4"), // Custom teal bubble
)

#wechat.chat(
  theme: custom-light,
  width: 300pt,
  oc.time[Today 14:30],
  oc.message(left, alice)[
    This theme inherits from light but uses custom bubble colors!
  ],
  oc.message(right, bob)[
    The red and teal bubbles look great! 🎨
  ],
)

== Custom Theme Inheriting from Dark

#let custom-dark = (
  inherit: "dark",
  right-bubble-color: rgb("#9B59B6"), // Purple bubble
  bg-color: rgb("#2C3E50"), // Custom background
)

#wechat.chat(
  theme: custom-dark,
  width: 300pt,
  oc.time[Today 15:00],
  oc.message(left, alice)[
    This inherits from dark theme with purple bubbles!
  ],
  oc.message(right, bob)[
    Love the custom purple and blue combination! 💜
  ],
)

== QQ Theme Inheritance

#let qq-custom = (
  inherit: "light",
  right-bubble-color: rgb("#FF9500"), // Orange bubble
  left-bubble-color: rgb("#34C759"), // Green bubble
)

#qqnt.chat(
  theme: qq-custom,
  width: 300pt,
  oc.time[Today 16:00],
  oc.message(left, alice)[
    QQ theme with custom orange and green bubbles!
  ],
  oc.message(right, bob)[
    The gradient background with custom bubbles is beautiful! 🌈
  ],
)

== Discord Theme Inheritance

#let discord-custom = (
  inherit: "default",
  text-color: rgb("#FFD700"), // Gold text
  name-color: rgb("#FF69B4"), // Pink names
)

#discord.chat(
  theme: discord-custom,
  width: 350pt,
  oc.time[Today at 4:30 PM],
  oc.message(left, alice, time: [4:30 PM])[
    Discord with gold text and pink usernames!
  ],
  oc.message(left, bob, time: [4:31 PM])[
    This looks really unique! ✨
  ],
)

== Fallback Behavior

The theme inheritance system includes smart fallback behavior:

1. *Invalid inherit values* → Falls back to base theme (light for WeChat/QQ, default for Discord)
2. *No inherit field* → Falls back to base theme
3. *Invalid theme type* → Falls back to base theme

Examples:

```typst
// These all fallback gracefully:
#wechat.chat(theme: (inherit: "invalid", right-bubble-color: red))
#wechat.chat(theme: (right-bubble-color: blue))  // No inherit field
#wechat.chat(theme: "invalid-string")           // Invalid type
```

== Advanced Custom Theme

#let advanced-theme = (
  inherit: "light",
  right-text-color: rgb("#2C3E50"),
  left-text-color: rgb("#2C3E50"),
  right-bubble-color: gradient.linear(rgb("#667eea"), rgb("#764ba2")),
  left-bubble-color: gradient.linear(rgb("#f093fb"), rgb("#f5576c")),
  bg-color: rgb("#F8F9FA"),
  name-color: rgb("#6C757D"),
)

#wechat.chat(
  theme: advanced-theme,
  width: 350pt,
  oc.time[Today 17:00],
  oc.message(left, alice)[
    This theme uses gradient bubbles and custom typography!
  ],
  oc.message(right, bob)[
    The gradient bubbles create such a modern look! 🚀
  ],
  oc.message(left, alice)[
    Theme inheritance makes customization so much easier while keeping all the base functionality.
  ],
)

== Usage Guide

To create a custom theme with inheritance:

```typst
#let my-theme = (
  inherit: "dark",              // Inherit from built-in theme
  right-bubble-color: purple,   // Override specific properties
  left-bubble-color: orange,
  // Any other properties you want to customize
)

#wechat.chat(theme: my-theme, ...)
```

Available inheritance options:
- WeChat: `"light"`, `"dark"`
- QQ: `"light"`, `"dark"`
- Discord: `"default"` (or `auto`)
