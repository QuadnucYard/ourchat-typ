import { defineConfig } from "vite";
import { resolve } from "node:path";
import handlebars from "vite-plugin-handlebars";
import {
  readFileSync,
  existsSync,
  readdirSync,
  writeFileSync,
  mkdirSync,
} from "node:fs";
import { fileURLToPath, URL } from "node:url";
import { createHighlighter } from "shiki";

const __dirname = fileURLToPath(new URL(".", import.meta.url));

// Cache for examples to avoid multiple async calls
let cachedExamples: any[] | null = null;

// Create Shiki highlighter instance
let highlighter: any = null;

async function getHighlighter() {
  if (!highlighter) {
    highlighter = await createHighlighter({
      themes: ["github-light", "github-dark"],
      langs: ["typst"],
    });
  }
  return highlighter;
}

async function getExamples() {
  if (!cachedExamples) {
    cachedExamples = await extractExampleMetadata();
  }
  return cachedExamples;
}

// Helper to extract example metadata from .typ files
async function extractExampleMetadata() {
  const examples: any[] = [];
  const themeDirs = ["wechat", "discord", "qqnt"];
  const shiki = await getHighlighter();

  for (const theme of themeDirs) {
    const exampleDir = resolve(__dirname, "examples", theme);
    if (existsSync(exampleDir)) {
      const files = readdirSync(exampleDir).filter((f) => f.endsWith(".typ"));

      for (const file of files) {
        const basename = file.replace(".typ", "");
        const filePath = resolve(exampleDir, file);
        const content = readFileSync(filePath, "utf-8");

        // Extract documentation comments (lines starting with ///)
        const docLines = content
          .split("\n")
          .filter((line) => line.trim().startsWith("///"))
          .map((line) => line.replace(/^\/\/\/\s?/, ""));

        // Highlight source code with Shiki
        const highlightedCode = shiki.codeToHtml(content, {
          lang: "typst",
          theme: "github-light",
        });

        const example = {
          theme,
          name: basename,
          title: basename
            .split("-")
            .map((word) => word.charAt(0).toUpperCase() + word.slice(1))
            .join(" "),
          fileName: file,
          description: docLines[0] || "",
          features: docLines[1]?.replace(/^Features:\s?/, "") || "",
          layout: docLines[2]?.replace(/^Layout:\s?/, "") || "",
          sourceCode: content,
          highlightedCode: highlightedCode,
          svgPath: `/examples/${theme}/${basename}.svg`,
        };

        examples.push(example);
      }
    }
  }

  return examples;
}

// Custom plugin to generate individual example pages
function examplePagesPlugin() {
  return {
    name: "example-pages",
    async configResolved() {
      // Create individual HTML files for each example in gallery/ directory
      const examples = await extractExampleMetadata();
      const galleryDir = resolve(__dirname, "gallery");

      // Ensure gallery directory exists
      if (!existsSync(galleryDir)) {
        mkdirSync(galleryDir, { recursive: true });
      }

      // Read the detail template
      const detailTemplate = readFileSync(
        resolve(__dirname, "detail.html"),
        "utf-8"
      );

      // Create individual HTML files for each example
      examples.forEach((example) => {
        const filePath = resolve(galleryDir, `${example.name}.html`);
        writeFileSync(filePath, detailTemplate);
      });
    },
  };
}

export default defineConfig(async () => {
  // Pre-compute examples for build config
  const examples = await extractExampleMetadata();

  return {
    base: "/ourchat/",
    plugins: [
      examplePagesPlugin(),
      handlebars({
        partialDirectory: [
          resolve(__dirname, "src/components"),
          resolve(__dirname, "src/layouts"),
        ],
        async context(pagePath: string) {
          const examples = await getExamples();

          // Base context shared by all pages
          const baseContext = {
            title: "Ourchat",
            subtitle: "Create stunning, authentic chat interfaces",
            description:
              "Build beautiful, authentic chat UIs for WeChat, Discord, and QQNT with our comprehensive Typst library. Rich theming, easy customization, and extensive examples included.",
            examples,
            currentYear: "2025",
            // Group examples by theme for easier template iteration
            get examplesByTheme() {
              const grouped: Record<string, any[]> = {};
              this.examples.forEach((example: any) => {
                if (!grouped[example.theme]) grouped[example.theme] = [];
                grouped[example.theme].push(example);
              });
              return grouped;
            },
            // Featured examples for homepage
            get featuredExamples() {
              return this.examples.filter((example: any) =>
                [
                  "simple-chat",
                  "business-meeting",
                  "gaming-community",
                  "study-group",
                  "dev-standup",
                  "social-chat",
                ].includes(example.name)
              );
            },
          };

          // For individual example detail pages, determine which example from the file path
          const fileName = pagePath.split("/").pop()?.replace(".html", "");
          const example = examples.find((ex) => ex.name === fileName);

          if (example) {
            return {
              ...baseContext,
              example,
              title: `${example.title} - ${baseContext.title}`,
              description: example.description || baseContext.description,
            };
          }

          return baseContext;
        },
        helpers: {
          capitalize: (str: string) => {
            if (!str || typeof str !== "string") return "";
            return str.charAt(0).toUpperCase() + str.slice(1);
          },
          split: (str: string, delimiter: string) => {
            if (!str || typeof str !== "string") return [];
            return str.split(delimiter);
          },
          trim: (str: string) => {
            if (!str || typeof str !== "string") return "";
            return str.trim();
          },
        },
      }),
    ],
    build: {
      rollupOptions: {
        input: (() => {
          const inputs: Record<string, string> = {
            main: resolve(__dirname, "index.html"),
            gallery: resolve(__dirname, "gallery.html"),
          };

          // Add individual gallery pages
          examples.forEach((example) => {
            inputs[`gallery/${example.name}`] = resolve(
              __dirname,
              `gallery/${example.name}.html`
            );
          });

          return inputs;
        })(),
      },
    },
    server: {
      port: 3000,
    },
  };
});
