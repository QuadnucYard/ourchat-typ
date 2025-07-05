import { existsSync, readdirSync, readFileSync } from "node:fs";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { baseUrl } from "@/config/site";

const __dirname = fileURLToPath(new URL("../../..", import.meta.url));

// In display order
const THEMES = [
  { name: "wechat", displayName: "WeChat Theme" },
  { name: "qqnt", displayName: "QQ NT Theme" },
  { name: "discord", displayName: "Discord Theme" },
  { name: "yau", displayName: "yau" },
];

export function getThemeDisplayName(theme: string): string {
  return THEMES.find((t) => t.name === theme)?.displayName ?? theme;
}

export interface Example {
  theme: string;
  name: string;
  title: string;
  fileName: string;
  description: string;
  featured: boolean;
  sourceCode: string;
  svgPath: string;
}

let cachedExamples: Example[] | null = null;

export async function getExamples(): Promise<Example[]> {
  if (!cachedExamples) {
    cachedExamples = await extractExampleMetadata();
  }
  return cachedExamples;
}

export async function getExamplesByTheme(): Promise<Record<string, Example[]>> {
  const examples = await getExamples();

  return Object.fromEntries(
    THEMES.map((theme) => {
      const themeExamples = examples.filter(
        (example) => example.theme === theme.name,
      );
      return [theme.name, themeExamples];
    }),
  );
}

export async function getFeaturedExamples(): Promise<Example[]> {
  const examples = await getExamples();
  return examples.filter((example) => example.featured);
}

async function extractExampleMetadata(): Promise<Example[]> {
  const examples: Example[] = [];
  const themeDirs = THEMES.map((theme) => theme.name);

  for (const theme of themeDirs) {
    const exampleDir = resolve(__dirname, "examples", theme);
    if (existsSync(exampleDir)) {
      const files = readdirSync(exampleDir).filter(
        (f) => f.endsWith(".typ") && f !== "mod.typ",
      );

      for (const file of files) {
        const basename = file.replace(".typ", "");
        const filePath = resolve(exampleDir, file);
        const content = readFileSync(filePath, "utf-8");

        const { description, title, featured } =
          extractExampleFrontmatter(content);

        // Strip documentation lines from source code
        const sourceCode = content
          .split("\n")
          .filter((line) => {
            let lineTrimmed = line.trim();
            return (
              !lineTrimmed.startsWith("///") &&
              lineTrimmed != `#import "../mod.typ": *` &&
              lineTrimmed != `#show: example-style`
            );
          })
          .join("\n")
          .trim();

        const example: Example = {
          theme,
          name: basename,
          title:
            title ??
            basename
              .split("-")
              .map((word) => capitalizeFirstLetter(word))
              .join(" "),
          fileName: file,
          description,
          featured,
          sourceCode: sourceCode,
          svgPath: `${baseUrl}/examples/${basename}.svg`,
        };

        examples.push(example);
      }
    }
  }

  return examples;
}

function extractExampleFrontmatter(content: string) {
  let description = "";
  let title = undefined;
  let featured = false;

  for (const line of content
    .split("\n")
    .filter((line) => line.trim().startsWith("///"))) {
    const lineContent = line.replace(/^\/\/\/\s?/, "");
    if (lineContent.startsWith("Title:")) {
      title = lineContent.replace(/^Title:\s?/, "");
    } else if (lineContent.startsWith("[Featured]")) {
      featured = true;
    } else {
      description += lineContent + "\n";
    }
  }

  return {
    description: description.trim(),
    title,
    featured,
  };
}

function capitalizeFirstLetter(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}
