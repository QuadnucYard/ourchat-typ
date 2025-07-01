/// ML model performance analysis with statistical insights
/// Features: Statistical formulas, model metrics, feature engineering

#import "../mod.typ": *

#show: example-style

#let data_scientist = user(name: [Dr. Chen Wei], title: [Data Scientist], avatar: rect(
  fill: rgb("#2E86AB"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[CW],
))

#let ml_engineer = user(name: [Alex Zhang], title: [ML Engineer], avatar: rect(
  fill: rgb("#A23B72"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[AZ],
))

#let analyst = user(name: [Sarah Liu], title: [Business Analyst], avatar: rect(
  fill: rgb("#F18F01"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[SL],
))

#wechat.chat(
  theme: "light",
  layout: (
    content-width: 500pt,
    avatar-size: 35pt,
    message-text-size: 12pt,
    bubble-radius: 6pt,
    row-gutter: 0.8em,
  ),

  time[ML Model Review - Tuesday 10:00 AM],

  message(left, data_scientist)[
    A/B test results are in! Treatment group shows 47% lift:

    Control: 3.2% conversion (n=10k)
    Treatment: 4.7% conversion (n=10k)

    Z-score: 7.73, p < 0.001 ✅

    Statistically significant with high confidence!
  ],

  message(right, ml_engineer)[
    Nice! Here's the production model pipeline:

    ```python
    def recommendation_score(user_features, item_features):
        # Embedding lookup
        user_vec = user_embeddings[user_id]  # 128-dim
        item_vec = item_embeddings[item_id]  # 128-dim

        # Feature engineering
        combined = np.concatenate([
            user_vec, item_vec,
            [user_features['recency'], user_features['frequency']]
        ])

        # Neural network inference
        return model.predict(combined.reshape(1, -1))[0]
    ```

    Deployed with 94.2% accuracy, 15ms latency! 🚀
  ],

  message(left, analyst)[
    ROI impact is massive:

    #table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + gray,
      inset: 6pt,
      [*Metric*], [*Before*], [*After*],
      [CTR], [2.1%], [4.7%],
      [Revenue/User], [\$47], [\$68],
      [LTV], [\$340], [\$418],
    )

    Expected annual revenue increase: \$2.3M 📈
  ],

  message(right, data_scientist)[
    Perfect! Final model equation for docs:

    $P("click") = sigma(W_u u + W_i i + b)$

    Where $u, i$ are user/item embeddings learned via:

    $L = -sum log sigma(y(W_u u + W_i i)) + lambda||W||^2$

    Ready for production scaling! 🔬✨
  ],
)
