import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  base: "/ourchat-typ",
  trailingSlash: "never",

  outDir: "./dist",
  publicDir: "./public",
});
