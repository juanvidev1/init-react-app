#! /bin/bash
# Script to update twilwind config files
# Author: Juanvidev <juanvidev1@gmail.com>

file_path=$1
echo "File path: $file_path"
sleep 3

if [ -z "$file_path" ]; then
  echo "Please provide a file path"
  exit 1
fi

cd $file_path
echo "Updating tailwind.config.js in $file_path"
sleep 3

cat<<EOF > $file_path/tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

echo "Tailwind config updated successfully"
sleep 1

cd $file_path/src
cat<<EOF > $file_path/src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  color-scheme: light dark;
  color: rgba(255, 255, 255, 0.87);
  /* background-color: #242424; */

  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
EOF
echo "index.css updated successfully"

cat<<EOF > $file_path/src/App.css
#root {
  max-width: 1280px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
}
EOF
echo "App.css updated successfully"

