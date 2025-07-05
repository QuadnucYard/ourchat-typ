set shell := ["nu", "-c"]

export TYPST_ROOT := justfile_directory()


default:
  @just --list

test:
  tinymist test --root . tests/test-validation.typ

package target="out":
  nu scripts/package.nu {{target}}

[working-directory: 'docs']
docs-dev:
  bun dev

[working-directory: 'docs']
docs-build:
  nu ../scripts/render-examples.nu ../examples public/examples
  bun install
  bun run build
