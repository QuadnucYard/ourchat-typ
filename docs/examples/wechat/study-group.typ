/// Study group discussion with mathematical content and collaborative learning
/// Features: Math formulas, study collaboration, educational content, mixed languages
/// Layout: Medium width for formula readability, clean academic styling

#import "../mod.typ": *

#set page(width: auto, height: auto, margin: 1em, fill: white)
#set text(font: ("Segoe UI", "PingFang SC", "Noto Sans CJK SC"))

#let student_a = user(
  name: [张小明],
  title: [数学专业],
  avatar: circle(
    fill: gradient.radial(rgb("#4CAF50"), rgb("#2E7D32")),
    text(white, size: 8pt, weight: "bold")[张]
  )
)

#let student_b = user(
  name: [Lisa Chen],
  title: [Engineering],
  avatar: circle(
    fill: gradient.radial(rgb("#FF9800"), rgb("#F57C00")),
    text(white, size: 8pt, weight: "bold")[L]
  )
)

#let student_c = user(
  name: [Mike],
  title: [Physics],
  avatar: circle(
    fill: gradient.radial(rgb("#9C27B0"), rgb("#7B1FA2")),
    text(white, size: 8pt, weight: "bold")[M]
  )
)

#wechat.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#F0F8FF"),
    bubble-right: rgb("#FFF8DC"),
  ),
  layout: (
    content-width: 380pt,
    message-text-size: 12pt,
    bubble-inset: 0.8em,
  ),

  time[Study Session - Today 19:00],

  message(left, student_a)[
    大家好！今天我们复习线性代数的特征值吧 📚

    特征值方程：$det(A - lambda I) = 0$
  ],

  message(right, student_b)[
    Good idea! I'm still confused about the geometric interpretation 🤔
  ],

  message(left, student_c)[
    Think of it as finding directions that don't change when transformed!

    If $A vec(v) = lambda vec(v)$, then $vec(v)$ is an eigenvector
  ],

  message(right, student_a)[
    没错！举个2×2矩阵的例子：

    $A = mat(2, 1; 1, 2)$

    特征多项式：$(2-lambda)^2 - 1 = lambda^2 - 4lambda + 3$
  ],

  message(left, student_b)[
    So the eigenvalues are λ = 3 and λ = 1, right?

    $(lambda - 3)(lambda - 1) = 0$
  ],

  message(right, student_c)[
    Exactly! And the eigenvectors are:
    - For λ = 3: $vec(v_1) = vec(1, 1)$
    - For λ = 1: $vec(v_2) = vec(1, -1)$
  ],

  message(left, student_a)[
    完美！大家都理解了 ✅

    明天的考试应该没问题了 💪
  ],
)
