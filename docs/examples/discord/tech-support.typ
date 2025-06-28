/// Technical support discussion with code snippets and debugging
/// Features: Code blocks, technical terminology, problem-solving workflow
/// Layout: Discord's developer-friendly interface for technical content

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: rgb("#36393f"))
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let developer = user(
  name: [junior_dev],
  title: discord.newbie,
  avatar: rect(
    fill: rgb("#FEE75C"),
    radius: 4pt,
    text(black, size: 8pt, weight: "bold")[JD]
  )
)

#let senior = user(
  name: [tech_lead],
  title: [Senior Engineer],
  avatar: rect(
    fill: rgb("#EB459E"),
    radius: 4pt,
    text(white, size: 8pt, weight: "bold")[TL]
  )
)

#let devops = user(
  name: [devops_guru],
  title: [DevOps],
  avatar: rect(
    fill: rgb("#57F287"),
    radius: 4pt,
    text(black, size: 8pt, weight: "bold")[DG]
  )
)

#discord.chat(
  time[Today at 10:15 AM],

  message(left, developer)[
    Help! Getting a weird error in production 😰

    ```
    Error: Connection timeout after 30s
    at Database.connect (db.js:45)
    ```
  ],

  message(left, senior)[
    Can you share your database connection config? (remove sensitive data)
  ],

  message(left, developer)[
    Sure! Here's the config:

    ```javascript
    const config = {
      host: 'db.example.com',
      port: 5432,
      database: 'myapp',
      connectionTimeoutMillis: 30000,
      pool: { min: 5, max: 20 }
    }
    ```
  ],

  message(left, devops)[
    @junior_dev Check if the database server is experiencing high load

    Also try increasing the timeout to 60s temporarily
  ],

  message(left, senior)[
    Good point! Also check your connection pool settings:

    ```javascript
    pool: {
      min: 2,
      max: 10,  // Reduce max connections
      idleTimeoutMillis: 10000
    }
    ```
  ],

  message(left, developer)[
    That fixed it! Thanks team! 🎉

    Pool was exhausted due to too many concurrent connections
  ],
)
