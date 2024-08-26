import { defineConfig } from 'astro/config'
import rehypeKatex from 'rehype-katex'; 
import remarkMath from 'remark-math';
import { remarkModifiedTime } from './src/scripts/remark-modified-time.mjs';

// https://astro.build/config
export default defineConfig({
  site: 'https://havarddj.github.io',
  publicDir: 'public',
  markdown: {
  remarkPlugins: ['remark-math', remarkModifiedTime],
  rehypePlugins: [['rehype-katex', {output: 'mathml'}]],
  },
});

