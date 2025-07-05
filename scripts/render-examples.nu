#!/usr/bin/env nu

# Render all Typst examples to SVG format
# This script finds all .typ files in docs/examples/*/*.typ and renders them to public/examples/

def main [examples_dir: string, output_dir: string] {
    print $"(ansi cyan)🎨 Rendering Typst examples to SVG...(ansi reset)"

    print $"(ansi blue)📁 Examples directory: ($examples_dir | path expand)(ansi reset)"
    print $"(ansi blue)📁 Output directory: ($output_dir | path expand)(ansi reset)"

    let themes = ls $examples_dir | where type == dir | get name | path basename

    # Find all .typ files in theme subdirectories
    let typ_files = $themes
        | each { |theme_dir|
            ls ($examples_dir | path join $theme_dir)
            | where name =~ '\.typ$' and name !~ 'mod\.typ$'
            | get name
        }
        | flatten

    if ($typ_files | length) == 0 {
        print $"(ansi red)❌ No .typ files found in examples directory(ansi reset)"
        return
    }

    print $"(ansi blue)📋 Found ($typ_files | length) example files(ansi reset)"

    # Create output directories for each theme ahead of time
    for theme in $themes {
        mkdir ($output_dir | path join $theme)
    }

    # Process each .typ file
    let start_time = date now
    let results = $typ_files | par-each { |file|
        let rel_path = $file | path relative-to $examples_dir
        let theme = $rel_path | path dirname
        let basename = $rel_path | path basename | path parse | get stem

        # Output SVG path
        let svg_path = $output_dir | path join $"($basename).svg"

        # Render with typst and capture output
        let start_time = date now
        # Run typst, capture output
        let result = try {
            let output = typst compile --format svg $file $svg_path --root .. | complete
            {
                success: ($output.exit_code == 0),
                stdout: $output.stdout,
                stderr: $output.stderr
            }
        } catch {
            {
                success: false,
                stdout: "",
                stderr: $"Failed to execute typst command: ($env.LAST_EXIT_CODE)"
            }
        }
        let end_time = date now
        let duration = (($end_time - $start_time) / 1ms | math round) * 1ms

        if ($result.success) {
            print $"   (ansi purple)📄 ($rel_path).typ(ansi reset) → (ansi magenta)($svg_path | path basename)(ansi reset) (ansi yellow)\(($duration)\)(ansi reset)"
        } else {
            print $"   (ansi red)❌ ($rel_path).typ(ansi reset) (ansi yellow)\(($duration)\)(ansi reset)"
            print $"   (ansi red)Error:(ansi reset) ($result.stderr)"
        }

        $result
    }
    let end_time = date now
    let duration = $end_time - $start_time

    # Display results in a tidy way
    let successful = $results | where success == true
    let failed = $results | where success == false

    print $"(ansi green)🎉 Rendering complete in ($duration)!(ansi reset)"
    print $"(ansi green)✅ Successfully rendered: ($successful | length) files(ansi reset)"
    if ($failed | length) > 0 {
        print $"(ansi red)❌ Failed to render: ($failed | length) files(ansi reset)"
    }
}
