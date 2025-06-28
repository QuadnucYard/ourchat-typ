import { readFileSync, existsSync, readdirSync } from "node:fs";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = fileURLToPath(new URL("../..", import.meta.url));

export interface Example {
  theme: string;
  name: string;
  title: string;
  fileName: string;
  description: string;
  features: string;
  layout: string;
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

export async function getExamplesByTheme(): Promise<
  Partial<Record<string, Example[]>>
> {
  const examples = await getExamples();

  return Object.groupBy(examples, (example) => example.theme);
}

export async function getFeaturedExamples(): Promise<Example[]> {
  const examples = await getExamples();
  return examples.filter((example) =>
    [
      "simple-chat",
      "business-meeting",
      "gaming-community",
      "study-group",
      "dev-standup",
      "social-chat",
    ].includes(example.name)
  );
}

async function extractExampleMetadata(): Promise<Example[]> {
  const examples: Example[] = [];
  const themeDirs = ["wechat", "discord", "qqnt"];

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

        // Strip documentation lines from source code
        const sourceCode = content
          .split("\n")
          .filter((line) => !line.trim().startsWith("///"))
          .join("\n")
          .trim();

        const example: Example = {
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
          sourceCode: sourceCode,
          svgPath: `/examples/${theme}/${basename}.svg`,
        };

        examples.push(example);
      }
    }
  }

  return examples;
}
