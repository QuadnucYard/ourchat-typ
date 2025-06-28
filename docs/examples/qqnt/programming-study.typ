/// Study group discussing programming concepts
/// Features: Educational content, code examples, collaborative learning
/// Layout: Academic-friendly spacing with clear message structure

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: white)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let student_a = user(name: [Tom Wilson], avatar: circle(
  fill: gradient.radial(rgb("#FF9800"), rgb("#F57C00")),
  text(white, size: 8pt, weight: "bold")[TW],
))

#let student_b = user(name: [Lisa Chang], avatar: circle(
  fill: gradient.radial(rgb("#9C27B0"), rgb("#7B1FA2")),
  text(white, size: 8pt, weight: "bold")[LC],
))

#let tutor = user(name: [Prof. Smith], avatar: circle(
  fill: gradient.radial(rgb("#2196F3"), rgb("#1976D2")),
  text(white, size: 8pt, weight: "bold")[PS],
))

#qqnt.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#F0F8FF"),
    bubble-right: rgb("#FFF0F5"),
  ),
  layout: (
    content-width: 350pt,
    message-text-size: 12pt,
  ),

  time[Programming Study Session - Today 7:00 PM],

  message(left, student_a)[
    Can someone explain Python decorators? Still confused 🤔
  ],

  message(center, tutor)[
    A decorator is essentially a function that modifies other functions:

    ```python
    def my_decorator(func):
        def wrapper():
            print("Before function")
            func()
            print("After function")
        return wrapper
    ```
  ],

  message(right, student_b)[
    Let me add a practical example!

    ```python
    @my_decorator
    def say_hello():
        print("Hello World!")

    # Equivalent to:
    # say_hello = my_decorator(say_hello)
    ```
  ],

  message(left, student_a)[
    Oh! So the \@ symbol is syntactic sugar to make code cleaner ✨
  ],

  message(center, tutor)[
    Exactly! Common decorator uses:
    • Logging
    • Performance timing
    • Authentication
    • Caching
  ],

  message(right, student_b)[
    Got it! You can add functionality without modifying the original function 👍
  ],

  message(left, student_a)[
    Thanks everyone! Learned so much today 📚
  ],
)
