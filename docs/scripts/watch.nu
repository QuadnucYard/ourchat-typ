#!/usr/bin/env nu

# Watch and auto-render script
# Watches for changes in examples/*.typ files and auto-renders them

def main [] {
    print "👀 Starting example file watcher..."
    print "   Watching examples/**/*.typ for changes"
    print "   Press Ctrl+C to stop"

    # Initial render
    nu scripts/render.nu

    # Watch for changes (simple polling approach)
    loop {
        sleep 2sec

        # Check if any .typ files have been modified recently
        let recent_files = (
            glob "examples/**/*.typ"
            | each { |file|
                {
                    file: $file,
                    modified: (ls $file | get modified | first)
                }
            }
            | where modified > ((date now) - 5sec)
        )

        if ($recent_files | length) > 0 {
            print $"🔄 Detected changes in ($recent_files | length) files, re-rendering..."
            nu scripts/render.nu
        }
    }
}
