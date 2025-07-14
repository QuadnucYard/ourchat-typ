#import "src/lib.typ" as oc: *
#import oc.themes: *

#let is-html-target = dictionary(std).keys().contains("html")

#show: if is-html-target {
  it => it
} else {
  it => {
    set heading(numbering: "1.1")
    show raw: set text(font: ("DejaVu Sans Mono", "Sarasa Mono SC"))
    it
  }
}

#let preview(..args, body, reversed: false) = context {
  let evaluated = {
    set text(font: "IBM Plex Sans SC")
    show smartquote: set text(features: ("pwid",))
    eval(body.text, mode: "markup", scope: (oc: oc, ..dictionary(oc.themes)))
  }
  if is-html-target {
    if reversed {
      html.frame(evaluated)
      body
    } else {
      body
      html.frame(evaluated)
    }
  } else {
    grid(
      columns: 2,
      column-gutter: .5em,
      block(
        width: 20em,
        stroke: gray,
        radius: 0.25em,
        inset: 0.5em,
        body,
      ),
      block(width: 20em, stroke: gray, radius: 0.25em, inset: 0.5em, breakable: false, evaluated),
    )
  }
}

#let package = toml("typst.toml").package

#context if is-html-target [
  #html.elem("h1")[Ourchat]

  #html.elem("a", attrs: (href: "https://typst.app/universe/package/" + package.name))[
    #html.elem(
      "img",
      attrs: (
        src: "https://img.shields.io/badge/dynamic/xml?url=https%3A%2F%2Ftypst.app%2Funiverse%2Fpackage%2Fourchat&query=%2Fhtml%2Fbody%2Fdiv%2Fmain%2Fdiv%5B2%5D%2Faside%2Fsection%5B2%5D%2Fdl%2Fdd%5B3%5D&logo=typst&label=Universe&color=%2339cccc",
        alt: "Universe",
      ),
    )
  ]
  #html.elem("a", attrs: (href: package.repository))[
    #html.elem(
      "img",
      attrs: (
        src: "https://img.shields.io/badge/dynamic/toml?url=https%3A%2F%2Fraw.githubusercontent.com%2FQuadnucYard%2Fourchat-typ%2Frefs%2Fheads%2Fmain%2Ftypst.toml&query=package.version&logo=GitHub&label=GitHub",
        alt: "GitHub",
      ),
    )
  ]
]

_Create chat interfaces in Typst with ease_

Ourchat is a #link("https://typst.app/")[Typst] package for building chat UI mockups. It helps you document software features, create presentations, or prototype chat interfaces with themes for popular platforms like WeChat, Discord, and QQ.

#if sys.inputs.at("target-universe", default: false) != "true" {
  preview(
    reversed: true,
    ````typst
    #let yau = wechat.default-user(name: [丘成桐（囯內）])

    #wechat.chat(
      theme: "dark",
      ..oc.with-side-user(
        left,
        yau,
        oc.time[5月16日 上午10:23],
        oc.free-message[
          已經到了無恥的地步。
        ],
        oc.time[6月18日 凌晨00:06],
        oc.free-message[
          我宣布他已經不是我的學生了
        ],
        oc.time[14:00],
        oc.free-message[
          這種成績，使人汗顏！如此成績，如何招生？
        ],
      ),
      oc.message(right, yau)[
        我沒有説過這種話！

        ——發自我的手機
      ],
    )
    ````,
  )
}

= Features

- *Multi-platform themes*: WeChat, Discord, QQNT support
- *Customizable styling*: Colors, avatars, layouts, and typography
- *Content support*: Full typst support in chat messages---Code blocks, tables, mathematical equations...
- *Simple API*: Easy-to-use, declarative interface

= Quick Start

First, import the package in your Typst document:

#raw(
  ```typst
  #import "@preview/$PKG" as oc
  #import oc.themes: *
  ```
    .text
    .replace("$PKG", package.name + ":" + package.version),
  lang: "typst",
  block: true,
)

Then create your first chat:

#preview(
  ````typst
  #let alice = wechat.user(name: [Alice], avatar: circle(fill: blue, text(white)[A]))
  #let bob = wechat.user(name: [Bob], avatar: circle(fill: green, text(white)[B]))

  #wechat.chat(
    oc.time[Today 14:30],

    oc.message(left, alice)[
      Hey! How's the new project going?
    ],

    oc.message(right, bob)[
      Great! Just finished the API integration.
      The performance improvements are impressive! 🚀
    ],
  )
  ````,
)

= Builtin Themes

== WeChat Theme

Perfect for mobile-first designs and casual conversations:

#preview(
  ````typst
  #let user1 = wechat.user(name: [Alice], avatar: circle(fill: blue, text(white)[A]))
  #let user2 = wechat.user(name: [Bob], avatar: circle(fill: green, text(white)[B]))

  #wechat.chat(
    theme: "light",  // or "dark"
    layout: (
      bubble-radius: 8pt,
    ),
    width: 400pt,

    oc.time[Monday 9:00 AM],
    oc.message(left, user1)[Hello world!],
    oc.message(right, user2)[Hi there! 👋],
  )
  ````,
)

== Discord Theme

Ideal for technical discussions and developer communities:

#preview(
  ````typst
  #set text(font: ("gg sans", "IBM Plex Sans SC"))

  #let developer = discord.user(
    name: [Dev],
    avatar: circle(fill: purple, text(white)[D])
  )
  #let admin = discord.user(
    name: [Admin],
    avatar: circle(fill: red, text(white)[A])
  )

  #discord.chat(
    oc.time[Today at 2:14 PM],

    oc.message(left, developer)[
  ```python
  def optimize_query():
      return cache_strategy.redis_cluster()
  ```
      What do you think about this approach? @admin
    ],

    oc.message(right, admin)[
      @developer Looks good! The Redis cluster should handle the load well.
    ],
  )
  ````,
)

== QQNT Theme

Modern interface for group discussions and study sessions:

#preview(
  ````typst
  #let student = qqnt.user(
    name: [Student],
    avatar: circle(fill: orange, text(white)[S])
  )
  #let expert = qqnt.user(
    name: [Expert],
    avatar: circle(fill: teal, text(white)[E])
  )

  #qqnt.chat(
    theme: (
      inherit: "light",
      bubble-left: rgb("#F0F8FF"),
      bubble-right: rgb("#E8F5E8"),
      text-right: rgb("#111111"),
    ),

    oc.message(left, student)[
      Can someone explain Rust ownership?
    ],

    oc.message(right, expert)[
      Sure! Ownership prevents data races at compile time...
    ],
  )
  ````,
)

= Advanced Usage

== Convenience Functions

For multiple messages from the same user, use `with-side-user` to avoid repetition:

#preview(
  ````typst
  #set text(font: ("gg sans", "IBM Plex Sans SC"))

  #let admin = oc.user(
    name: [System Admin],
    avatar: circle(fill: red.darken(20%), text(white, weight: "bold")[⚡])
  )

  #discord.chat(
    oc.time[Today at 3:45 PM],

    // Instead of repeating the user for each message:
    // oc.message(left, admin)[Server maintenance scheduled],
    // oc.message(left, admin)[Downtime: 30 minutes max],
    // oc.message(left, admin)[Please save your work],

    // Use with-side-user for cleaner code:
    ..oc.with-side-user(
      left,
      admin,
      oc.free-message[🚨 *URGENT: Server Maintenance Alert*],
      oc.free-message[Scheduled downtime: Tonight 11 PM - 11:30 PM],
      oc.free-message[All services will be temporarily unavailable],
      oc.free-message[Please save your work and plan accordingly],
    ),
  )
  ````,
)

== Custom User Avatars
Create distinctive user profiles:

#preview(
  ````typst
  #let ceo = oc.user(
    name: [Sarah Chen],
    badge: qqnt.badge(text-color: purple, bg-color: purple.transparentize(80%))[#text(stroke: 0.05em + purple)[CEO]],
    avatar: rect(
      fill: blue.darken(20%),
      radius: 4pt,
      inset: 6pt,
      text(white, weight: "bold")[SC]
    )
  )

  #qqnt.chat(
    oc.message(left, ceo)[
      Hi team! Ready for the quarterly review?
    ],
  )
  ````,
)

== Rich Content Support

Include tables, code blocks, and visual elements:

#preview(
  ````typst
  #let analyst = wechat.user(
    name: [Data Analyst],
    avatar: circle(fill: green.darken(10%), text(white)[📊])
  )

  #wechat.chat(
    oc.message(left, analyst)[
      Here's our performance analysis:

      #table(
        columns: (auto, auto, auto),
        [*Metric*], [*Before*], [*After*],
        [Response Time], [250ms], [120ms],
        [Throughput], [1000 RPS], [2500 RPS],
      )

      The optimization yielded 58% improvement! 📊
    ]
  )
  ````,
)

== Theme Customization

Modify existing themes or create your own:

```typst
#let custom_theme = (
  inherit: "light",
  background: rgb("#F5F5F5"),
  bubble-left: rgb("#E3F2FD"),
  bubble-right: rgb("#C8E6C9"),
  text-primary: rgb("#212121"),
  text-secondary: rgb("#757575"),
)

#wechat.chat(theme: custom_theme, ...)
```

== Layout Control

Fine-tune spacing and dimensions:

```typst
#wechat.chat(
  layout: (
    content-width: 350pt,
    message-spacing: 0.8em,
    avatar-size: 32pt,
    bubble-padding: 12pt,
  ),
  ...
)
```

= Examples Gallery

Explore our comprehensive example collection:
#link(package.homepage)

The source codes for these example are located at `./examples`.

= Architecture & Design

== API Design Philosophy

Ourchat follows a unified component architecture where `oc` provides the core building blocks:

- `oc.message()`, `oc.user()`, `oc.time()` - Universal components that work across all themes
- Built-in themes (`wechat`, `discord`, `qqnt`) import all common components but may override them for platform-specific features
  - For example, `qqnt.user()` extends the base user component with `badge` support for role badges
- Uses `chat` as the rendering function of messages, which is defined in individual themes. Styling is decided here.

```typst
// Universal approach - works with any theme
#let user = oc.user(name: [Alice])

// Theme-specific approach - leverages extended features
#let qqnt_user = qqnt.user(
  name: [Alice],
  badge: qqnt.badge()[Admin]  // QQNT specific feature
)
```

== Theme Customization Scope

Built-in themes provide a solid foundation but don't cover every possible customization. You're encouraged to:

- Extend existing themes for minor modifications using `theme` and `layout` parameters.
- Create entirely new themes for different platforms or unique designs with basic blocks. Refer to the source code of built-in themes as implementation guides

= API Reference

Here only lists exported functions and variables.
Please refer to the documentation comments of each function for details

== Common Components

- `oc.user(name, avatar, badge)`: Create universal user profiles
- `oc.message(side, user, body, time, merge)`: Add chat messages (`left` or `right`)
- `oc.time(body)`: Insert timestamp dividers
- `oc.with-side-user(side, user, ..messages)`: Convenience for multiple messages from same user
- `oc.free-message(body, time, merge)`: Create message without specific user or side
- `oc.plain(side, user, body)`: Create plain item without padding

Note: These are just helper functions for data wrapping. You can directly create data structures if you like.

== Theme Collections

=== `oc.themes.wechat`

WeChat layout and color schemes (`light`, `dark`)

- `wechat.chat(theme, layout, width, validate, ..messages)`: WeChat-style interface
- `wechat.default-user`: Pre-configured user with WeChat avatar

=== `oc.themes.qqnt`

QQNT layout and color schemes (`light`, `dark`)

- `qqnt.chat(theme, layout, width, validate, ..messages)`: QQNT-style interface
- `qqnt.user` (uses `oc.user` with badge support): QQNT user with role support
- `qqnt.badge(body, text-color, bg-color)`: Create role badges

=== `oc.themes.discord`

Discord layout and color schemes

- `discord.newbie-user`: Pre-configured user with newbie badge
- `discord.mention(body)`: Create Discord-style mention element
- `discord.chat(theme, layout, width, validate, auto-mention, ..messages)`: Discord-style interface

== Utilities (`oc.utils`)

- `validate-theme(theme, reference, field-type)`: Validate theme dictionary fields
- `validate-layout(layout, reference)`: Validate layout dictionary fields
- `resolve-theme(themes, theme, default, validate)`: Resolve theme with inheritance support
- `resolve-layout(layout, default-layout, validate)`: Merge and validate layout settings
- `stretch-cover(item)`: Scale content to cover its container
- `auto-mention-rule(auto-mention, styler)`: Create show rule for automatic mention styling

= Contributing

We welcome contributions! Please check our GitHub repository for:

- Bug reports and feature requests
- Code contributions and improvements
- Documentation updates
- New theme proposals and existing theme improvements

= License

MIT License - see #link("LICENSE") file for details.
