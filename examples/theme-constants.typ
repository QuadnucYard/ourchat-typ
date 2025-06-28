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

= Magic Constants Demo

== Default WeChat Theme

#wechat.chat(
  theme: "light",
  oc.time[Today 14:30],
  oc.message(left, alice)[
    This uses all default constants!
  ],
  oc.message(right, bob)[
    Standard bubble sizes and spacing.
  ],
)

== Customized Constants - Larger Bubbles

#wechat.chat(
  theme: "light",
  constants: (
    bubble-inset-x: 1.2em,
    bubble-inset-y: 1.0em,
    bubble-radius-small: 8pt,
    message-text-size: 14pt,
  ),
  oc.time[Today 15:00],
  oc.message(left, alice)[
    Larger bubbles with more padding!
  ],
  oc.message(right, bob)[
    The text is bigger and bubbles are more rounded.
  ],
)

== Customized Constants - Compact Layout

#wechat.chat(
  theme: "dark",
  constants: (
    content-inset: 4pt,
    row-gutter: 0.3em,
    column-gutter: 4pt,
    bubble-inset: 0.5em,
    message-text-size: 10pt,
    avatar-width: 20pt,
  ),
  oc.time[Today 16:00],
  oc.message(left, alice)[
    Compact layout!
  ],
  oc.message(right, bob)[
    Smaller spacing and avatars.
  ],
  oc.message(left, alice)[
    Perfect for narrow displays.
  ],
)

== Customized Constants - Large avatar Mode

#wechat.chat(
  theme: "light",
  constants: (
    avatar-width: 60pt,
    avatar-radius: 8pt,
    column-gutter: 12pt,
    name-text-size: 1em,
    content-inset: 16pt,
  ),
  oc.time[Today 17:00],
  oc.message(left, alice)[
    Large avatar mode with bigger names!
  ],
  oc.message(right, bob)[
    More space for avatars and better readability.
  ],
)

== Customized Constants - Fun Bubble Style

#wechat.chat(
  theme: "light",
  constants: (
    bubble-radius: 15pt,
    bubble-tail-size: 10pt,
    bubble-tail-radius: 3pt,
    bubble-inset: 1.5em,
    row-gutter: 1em,
  ),
  oc.time[Today 18:00],
  oc.message(left, alice)[
    Very rounded bubbles! 🎨
  ],
  oc.message(right, bob)[
    This looks so modern and fun! ✨
  ],
)

== Available Magic Constants

You can override any of these constants:

```typst
#wechat.chat(
  constants: (
    // Overall layout
    content-width: 270pt,        // Chat container width
    content-inset: 8pt,         // Chat container padding

    // Grid layout
    avatar-width: 27pt,        // avatar column width
    row-gutter: 0.65em,         // Space between message rows
    column-gutter: 7.5pt,       // Space between columns

    // avatar styling
    avatar-radius: 2.5pt,      // avatar picture radius

    // Bubble constants
    bubble-radius: 2.5pt,       // Message bubble radius
    bubble-inset: 0.8em,        // Bubble padding
    bubble-tail-size: 6pt,      // Bubble tail size
    bubble-tail-offset-y: 9pt,  // Bubble tail vertical offset
    bubble-tail-radius: 1pt,    // Bubble tail radius

    // Text constants
    message-text-size: 11.5pt,  // Message text size
    name-text-size: 0.7em,      // Sender name text size
    time-text-size: 0.7em,      // Time text size

    // Spacing constants
    name-height: 1em,           // Name block height
    time-height: 1.4em,         // Time block height

    // Paragraph formatting
    par-leading: 0.575em,       // Line height within paragraphs
    par-spacing: 0.65em,        // Space between paragraphs
  ),
  // ...messages
)
```

== Benefits of Magic Constants

1. **Consistent theming**: Override multiple related values at once
2. **Easy customization**: No need to modify theme files
3. **Responsive design**: Adjust layout for different screen sizes
4. **Accessibility**: Increase text sizes and spacing for better readability
5. **Brand consistency**: Match your organization's design system
6. **Backward compatibility**: All existing code continues to work

The magic constants system allows fine-tuned control over the visual appearance while keeping the theme colors and core functionality intact!
