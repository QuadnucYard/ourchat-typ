/// Development team standup meeting in Discord format
/// Features: Code sharing, technical discussion, team coordination
/// Layout: Discord's clean developer-friendly interface

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: rgb("#36393f"))
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let lead = user(name: [sarah_pm], title: [Team Lead], avatar: rect(
  fill: rgb("#5865F2"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[SP],
))

#let dev1 = user(name: [alex.codes], title: discord.newbie, avatar: rect(
  fill: rgb("#57F287"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[AC],
))

#let dev2 = user(name: [emma_frontend], avatar: rect(fill: rgb("#FEE75C"), radius: 4pt, text(
  black,
  size: 8pt,
  weight: "bold",
)[EF]))

#discord.chat(
  time[Today at 9:00 AM],

  message(left, lead)[
    Good morning team! 🌅 Daily standup time

    *Agenda:*
    • Yesterday's progress
    • Today's goals
    • Any blockers?
  ],

  message(left, dev1)[
    *Yesterday:* Finished the user authentication API
    *Today:* Working on password reset functionality
    *Blockers:* None so far!

    ```typescript
    // New auth endpoint structure
    POST /api/auth/reset-password
    {
      "email": "user@example.com",
      "token": "reset_token_here"
    }
    ```
  ],

  message(left, dev2)[
    *Yesterday:* Implemented responsive dashboard layout
    *Today:* Adding dark mode toggle + testing
    *Blockers:* Need design approval for dark theme colors 🎨
  ],

  message(left, lead)[
    Great progress everyone! 🎉

    \@emma_frontend I'll ping the design team about dark mode colors

    *Sprint goal:* We're on track for Friday's demo! 🚀
  ],
)
