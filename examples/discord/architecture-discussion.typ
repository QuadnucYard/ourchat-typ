/// Microservices architecture design with performance optimization
/// Features: System diagrams, load balancing, database sharding

#import "../mod.typ": *

#show: example-style

#let architect = user(name: [SystemArchitect], title: [Senior Engineer], avatar: rect(
  fill: rgb("#3498db"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[SA],
))

#let backend_dev = user(name: [backend_ninja], title: [Backend Developer], avatar: rect(
  fill: rgb("#e74c3c"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[BN],
))

#let devops = user(name: [cloudmaster], title: [DevOps Engineer], avatar: rect(
  fill: rgb("#2ecc71"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[CM],
))

#discord.chat(
  time[Today at 2:14 PM],

  message(left, architect)[
    #import "@preview/cetz:0.4.0": *

    Hey team! I've been working on the microservices architecture. Here's the current design:

    #align(center)[
      #canvas(length: 1cm, {
        import draw: *

        // API Gateway
        rect((0, 3), (2, 4), fill: rgb("#e74c3c"), stroke: white)
        content((1, 3.5), text(white, size: 8pt)[API Gateway])

        // Microservices
        rect((0, 1.5), (1, 2.5), fill: rgb("#3498db"), stroke: white)
        content((0.5, 2), text(white, size: 7pt)[Auth])

        rect((1.2, 1.5), (2.2, 2.5), fill: rgb("#3498db"), stroke: white)
        content((1.7, 2), text(white, size: 7pt)[User])

        rect((2.4, 1.5), (3.4, 2.5), fill: rgb("#3498db"), stroke: white)
        content((2.9, 2), text(white, size: 7pt)[Order])

        // Database
        rect((0.5, 0), (2.9, 1), fill: rgb("#2ecc71"), stroke: white)
        content((1.7, 0.5), text(white, size: 8pt)[Database Cluster])

        // Connections
        line((1, 3), (0.5, 2.5), stroke: gray)
        line((1, 3), (1.7, 2.5), stroke: gray)
        line((1, 3), (2.9, 2.5), stroke: gray)

        line((0.5, 1.5), (1.7, 1), stroke: gray)
        line((1.7, 1.5), (1.7, 1), stroke: gray)
        line((2.9, 1.5), (1.7, 1), stroke: gray)
      })
    ]

    What do you think about this approach? 🤔
  ],

  message(right, backend_dev)[
    Looks solid! But we need to consider the data flow patterns. Here's my analysis:

    ```python
    # Data pipeline optimization
    def optimize_query_performance(query_pattern):
        if query_pattern.frequency > THRESHOLD:
            return cache_strategy.redis_cluster()
        else:
            return database.direct_query()

    # Event sourcing pattern
    events = [
        UserCreated(user_id, timestamp),
        OrderPlaced(order_id, user_id, items),
        PaymentProcessed(payment_id, order_id)
    ]
    ```

    Also, have you considered implementing CQRS for read/write separation? 📊
  ],

  message(left, devops)[
    Great architecture! From infrastructure perspective, here's what I'm thinking:

    #grid(
      columns: 2,
      gutter: 10pt,

      [*Kubernetes Deployment:*
        - 3 replicas per service
        - HPA based on CPU/Memory
        - Service mesh with Istio
        - Blue-green deployments
      ],

      [*Monitoring Stack:*
        - Prometheus + Grafana
        - Jaeger for tracing
        - ELK for centralized logging
        - AlertManager for incidents
      ],
    )

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: user-service
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: user-service
      template:
        spec:
          containers:
          - name: user-service
            image: user-service:v2.1.0
            resources:
              requests:
                memory: "256Mi"
                cpu: "250m"
              limits:
                memory: "512Mi"
                cpu: "500m"
    ```
  ],

  message(right, architect)[
    Excellent points! Let me add some performance considerations:

    #table(
      columns: (auto, auto, auto, auto),
      stroke: 0.5pt + gray,
      inset: 6pt,
      [*Service*], [*RPS Target*], [*Latency P99*], [*Strategy*],
      [Auth], [1000], [< 50ms], [Redis Cache],
      [User], [2000], [< 100ms], [Read Replicas],
      [Order], [500], [< 200ms], [Event Sourcing],
      [Gateway], [5000], [< 10ms], [Load Balancer],
    )

    We should also implement circuit breakers for fault tolerance! 🔧
  ],

  message(left, backend_dev)[
    Absolutely! I'm thinking Hystrix pattern:

    ```java
    @HystrixCommand(fallbackMethod = "fallbackGetUser")
    public User getUser(String userId) {
        return userService.findById(userId);
    }

    public User fallbackGetUser(String userId) {
        return User.builder()
            .id(userId)
            .name("Guest User")
            .build();
    }
    ```

    This ensures graceful degradation when services are down ⚡
  ],

  message(right, devops)[
    Perfect! Let's also set up some chaos engineering with Chaos Monkey to test our resilience patterns.

    And for the database clustering, I suggest:
    - Master-slave replication
    - Automatic failover with Consul
    - Connection pooling with PgBouncer

    Should we schedule a design review meeting? �
  ],

  message(left, architect)[
    Great idea! Let's meet tomorrow at 3 PM to finalize the architecture.

    *Action Items:*
    - Review service boundaries
    - Finalize deployment strategy
    - Set up monitoring dashboards
    - Create disaster recovery plan

    Thanks everyone for the great discussion! �
  ],
)
