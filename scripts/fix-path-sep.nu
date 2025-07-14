def main [input: string, output?: string] {
    let $output = $output | default $input
    open $input
        | lines
        | each { |line|
            if ($line | str starts-with '![typst-frame](') {
                $line | str replace -a '\' '/'
            } else {
                $line
            }
        }
        | str join "\n"
        | $in + "\n"
        | save $output -f
}
