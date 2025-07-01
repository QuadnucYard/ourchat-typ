/// Quick tech debugging session with database connection issues
/// Features: Error logs, SQL optimization, monitoring setup

#import "../mod.typ": *

#show: example-style

#let developer = user(name: [junior_dev], title: discord.newbie, avatar: rect(
  fill: rgb("#FEE75C"),
  radius: 4pt,
  text(black, size: 8pt, weight: "bold")[JD],
))

#let senior = user(name: [tech_lead], title: [Senior Engineer], avatar: rect(
  fill: rgb("#EB459E"),
  radius: 4pt,
  text(white, size: 8pt, weight: "bold")[TL],
))

#let devops = user(name: [devops_guru], title: [DevOps], avatar: rect(
  fill: rgb("#57F287"),
  radius: 4pt,
  text(black, size: 8pt, weight: "bold")[DG],
))

#discord.chat(
  time[Today at 10:15 AM],

  message(left, developer)[
    Production DB timeouts! Connection pool exhausted:

    ```
    Error: TimeoutError after 30s
    at Pool.connect (pool.js:127)
    Active: 20/20, Waiting: 15
    ```
  ],

  message(left, senior)[
    Check for connection leaks. Add connection tracing:

    ```javascript
    pool.on('connect', client => {
      console.log('Active connections:', pool.totalCount);
      client.query = wrapQuery(client.query);  // Trace long queries
    });
    ```
  ],

  message(left, devops)[
    Also monitor `pg_stat_activity`:

    ```sql
    SELECT state, count(*), avg(extract(epoch from now() - query_start))
    FROM pg_stat_activity
    WHERE datname = 'myapp'
    GROUP BY state;
    ```

    Look for idle connections > 5min ⏰
  ],

  message(left, developer)[
    Found it! Forgot `client.release()` in error handlers:

    ```javascript
    try {
      const result = await client.query(sql);
      return result.rows;
    } catch (err) {
      // BUG: Missing client.release() here!
      throw err;
    } finally {
      client.release();  // Fixed! �
    }
    ```

    Pool utilization dropped to 5/20. Crisis averted! ✅
  ],
)
