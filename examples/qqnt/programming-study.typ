/// [Featured]
/// Advanced Rust programming discussion

#import "../mod.typ": *
#import "@preview/zebraw:0.5.5": *

#show: example-style

#let backend_dev = user(name: [Alex Chen], avatar: circle(
  fill: gradient.radial(rgb("#FF6B35"), rgb("#F7931E")),
  text(white, size: 8pt, weight: "bold")[AC],
))

#let systems_dev = user(name: [Sarah Kim], avatar: circle(
  fill: gradient.radial(rgb("#C44536"), rgb("#8B0000")),
  text(white, size: 8pt, weight: "bold")[SK],
))

#let rust_expert = user(name: [Dr. Martinez], avatar: circle(
  fill: gradient.radial(rgb("#2E86AB"), rgb("#A23B72")),
  text(white, size: 8pt, weight: "bold")[DM],
))

#show: zebraw.with(lang: false)

#qqnt.chat(
  theme: (
    inherit: "light",
    bubble-left: rgb("#F0F8FF"),
    bubble-right: rgb("#FFF0F5"),
    text-right: rgb("#653545"),
  ),
  layout: (
    content-width: 480pt,
    message-text-size: 12pt,
  ),

  time[Rust Learning Session - Today 3:00 PM],

  message(left, backend_dev)[
    I'm struggling with Rust's ownership model. When should I use `&` vs `&mut`?
  ],

  message(right, rust_expert)[
    Great question! Ownership prevents data races at compile time:

    ```rust
    fn main() {
        let mut data = vec![1, 2, 3];

        // Immutable borrow
        let len = calculate_length(&data);

        // Mutable borrow (exclusive access)
        add_element(&mut data, 4);

        println!("Length: {}, Data: {:?}", len, data);
    }

    fn calculate_length(v: &Vec<i32>) -> usize {
        v.len() // Can read but not modify
    }

    fn add_element(v: &mut Vec<i32>, item: i32) {
        v.push(item); // Can modify
    }
    ```
  ],

  message(left, systems_dev)[
    The key insight: Rust prevents data races by ensuring either:
    - Multiple immutable references (`&T`)
    - OR exactly one mutable reference (`&mut T`)

    Never both simultaneously! 🔒
  ],

  message(right, backend_dev)[
    That's brilliant! How does this compare to manual memory management?
  ],

  message(left, rust_expert)[
    Zero-cost abstractions! No garbage collector overhead:

    ```rust
    // RAII: Resource Acquisition Is Initialization
    {
        let file = File::open("data.txt")?; // Acquire
        // Use file...
    } // Automatically dropped/closed here

    // Compare to C++:
    // FILE* f = fopen("data.txt", "r");
    // // Must remember: fclose(f);
    ```

    Memory safety without performance cost ⚡
  ],

  message(right, systems_dev)[
    Perfect for systems programming! Here's async Rust in action:

    ```rust
    use tokio::time::{sleep, Duration};

    #[tokio::main]
    async fn main() {
        let handles: Vec<_> = (0..1000).map(|i| {
            tokio::spawn(async move {
                sleep(Duration::from_millis(100)).await;
                format!("Task {} completed", i)
            })
        }).collect();

        // Wait for all tasks
        for handle in handles {
            println!("{}", handle.await.unwrap());
        }
    }
    ```

    1000 concurrent tasks with minimal overhead! �
  ],
)
