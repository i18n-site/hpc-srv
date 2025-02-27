#!/usr/bin/env coffee

> path > join
  terser > minify
  esbuild > build
  @3-/read
  @3-/write
  fs > readdirSync

ROOT = import.meta.dirname

export_js = join ROOT,'export.js'
write(
  export_js
  do =>
    r = []
    for i in readdirSync(ROOT)
      if i.endsWith('.pb.js')
        r.push 'export * from \'./'+i+'\''
    r.join('\n')
)

{
  outputFiles:[{text}]
} = await build {
  entryPoints: [
    export_js
  ]
  bundle: true
  treeShaking: true
  minifyWhitespace: false
  minifySyntax: true
  minifyIdentifiers: false
  format: 'esm'
  target: 'esnext'
  platform: 'browser'
  write: false
  # outfile: join(ROOT,'bundle.js')
}

text = text.replace(
  '''assert = (condition) => {'''
  'assert = ()=>{ return;'
).replace(
  '''fail = (message) => {
    throw new Error(message);
  }'''
  'fail = ()=>{}'
)

{code} = await minify(
  # read join ROOT,'bundle.js'
  text
  {
    ecma: 2025
    module: true
    compress:
      drop_console: true
    mangle:
      toplevel: true
  }
)

write(
  join ROOT,'minify.js'
  code
)

process.exit()
