#!/usr/bin/env nu

# Render all Typst examples to SVG format
# This script finds all .typ files in docs/examples/*/*.typ and renders them to public/examples/

def main [examples_dir: string, output_dir: string] {
    print "🎨 Rendering Typst examples to SVG..."

    print $"📁 Examples directory: ($examples_dir | path expand)"
    print $"📁 Output directory: ($output_dir | path expand)"

    # Ensure output directory exists
    mkdir $output_dir

    # Find all .typ files in theme subdirectories
    let typ_files = (
        ls $examples_dir
        | where type == dir
        | each { |theme_dir|
            ls $theme_dir.name
            | where type == file
            | where name =~ '\.typ$'
            | where name !~ 'mod\.typ$'
            | get name
        }
        | flatten
    )

    if ($typ_files | length) == 0 {
        print "❌ No .typ files found in examples directory"
        return
    }

    print $"📋 Found ($typ_files | length) example files"

    # Process each .typ file
    let results = ($typ_files | par-each { |file|
        let rel_path = ($file | path relative-to $examples_dir)
        let theme = ($rel_path | path dirname)
        let basename = ($rel_path | path basename | path parse | get stem)

        # Create theme output directory
        let theme_output_dir = ($output_dir | path join $theme)
        mkdir $theme_output_dir

        # Output SVG path
        let svg_path = ($theme_output_dir | path join $"($basename).svg")

        # Render with typst and capture output
        let start_time = (date now)
        let result = (try {
            let output = (typst compile --format svg $file $svg_path --root .. | complete)
            let end_time = (date now)
            let duration_ms = (($end_time - $start_time) / 1ms | math round)
            {
                file: $file,
                theme: $theme,
                basename: $basename,
                svg_path: $svg_path,
                success: ($output.exit_code == 0),
                stdout: $output.stdout,
                stderr: $output.stderr,
                duration_ms: $duration_ms
            }
        } catch {
            let end_time = (date now)
            let duration_ms = (($end_time - $start_time) / 1ms | math round)
            {
                file: $file,
                theme: $theme,
                basename: $basename,
                svg_path: $svg_path,
                success: false,
                stdout: "",
                stderr: $"Failed to execute typst command: ($env.LAST_EXIT_CODE)",
                duration_ms: $duration_ms
            }
        })

        $result
    })

    # Display results in a tidy way
    let successful = ($results | where success == true)
    let failed = ($results | where success == false)

    print $"✅ Successfully rendered: ($successful | length) files"
    for result in $successful {
        print $"   📄 ($result.theme)/($result.basename).typ → ($result.svg_path | path basename) \(($result.duration_ms)ms\)"
    }

    if ($failed | length) > 0 {
        print $"❌ Failed to render: ($failed | length) files"
        for result in $failed {
            print $"   📄 ($result.theme)/($result.basename).typ \(($result.duration_ms)ms\)"
            if ($result.stderr | str length) > 0 {
                print $"      Error: ($result.stderr)"
            }
        }
    }

    print "🎉 Rendering complete!"

    # Show summary - count SVG files in all theme directories
    let rendered_count = (
        ls $output_dir
        | where type == dir
        | each { |theme_dir|
            ls $theme_dir.name
            | where type == file
            | where name =~ '\.svg$'
            | length
        }
        | math sum
    )
    print $"📊 Total rendered files: ($rendered_count)"

    # List rendered files by theme (dynamic based on output dirs)
    let themes = (ls $output_dir | where type == dir | get name)
    for theme_path in $themes {
        let theme = ($theme_path | path basename)
        let theme_files = (ls $theme_path | where type == file | where name =~ '\.svg$')
        if ($theme_files | length) > 0 {
            print $"   📱 ($theme): ($theme_files | length) files"
        }
    }
}
