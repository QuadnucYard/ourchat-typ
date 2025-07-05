/// Advanced algorithm design discussion with complexity analysis

#import "../mod.typ": *

#show: example-style

#let senior_dev = user(name: [Alex Chen], title: qqnt.title[Senior Developer], avatar: circle(
  fill: gradient.radial(rgb("#FF6B6B"), rgb("#EE5A24")),
  text(white, size: 8pt, weight: "bold")[AC],
))

#let algo_expert = user(name: [Dr. Wang], title: qqnt.title[Algorithm Specialist], avatar: circle(
  fill: gradient.radial(rgb("#4834D4"), rgb("#686DE0")),
  text(white, size: 8pt, weight: "bold")[DW],
))

#let performance_eng = user(
  name: [Sarah Kim],
  title: qqnt.title[Performance Engineer],
  avatar: circle(fill: gradient.radial(rgb("#00D2D3"), rgb("#01A3A4")), text(
    white,
    size: 8pt,
    weight: "bold",
  )[SK]),
)

#qqnt.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#F0F8FF"),
    bubble-right: rgb("#E8F5E8"),
    text-right: rgb("#663476"),
  ),
  layout: (
    message-text-size: 12pt,
  ),
  width: 600pt,

  time[Algorithm Optimization Session - Wednesday 3:00 PM],

  message(left, senior_dev)[
    Our graph DFS is too slow for large datasets. Cache misses are the bottleneck:

    ```python
    def dfs_traverse(graph, start, visited=None):
        if visited is None:
            visited = set()
        visited.add(start)
        for neighbor in graph[start]:
            if neighbor not in visited:
                dfs_traverse(graph, neighbor, visited)  # Stack overflow risk!
    ```

    Time: O(V + E), but terrible cache locality 😰
  ],

  message(right, algo_expert)[
    Try iterative approach with explicit stack for better cache performance:

    ```python
    def optimized_dfs(graph, start):
        stack = [start]
        visited = set()

        while stack:
            node = stack.pop()
            if node not in visited:
                visited.add(node)
                stack.extend(neighbor for neighbor in graph[node]
                           if neighbor not in visited)
    ```

    Same O(V + E) complexity but 3x faster due to locality! 🧠
  ],

  message(left, performance_eng)[
    Let's benchmark these approaches:

    #table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + gray,
      inset: 6pt,
      [*Algorithm*], [*Time (1M nodes)*], [*Memory*],
      [Original DFS], [2.3s], [128MB],
      [Iterative DFS], [1.8s], [96MB],
      [Bit-optimized], [0.3s], [32MB],
    )

    Bit-optimized wins: 8x faster, 4x less memory! 🚀
  ],

  message(right, algo_expert)[
    Here's the space-optimized implementation:

    ```cpp
    class BitGraph {
        vector<bitset<MAX_NODES>> adj;
        bitset<MAX_NODES> visited;

        void traverse(int start) {
            stack<int> s;
            s.push(start);

            while (!s.empty()) {
                int node = s.top(); s.pop();
                if (!visited[node]) {
                    visited[node] = 1;
                    for (int i = adj[node]._Find_first();
                         i < MAX_NODES;
                         i = adj[node]._Find_next(i)) {
                        if (!visited[i]) s.push(i);
                    }
                }
            }
        }
    };
    ```

    Complexity: O(V + E) time, O(V/64) space! 🧠✨
  ],
)
