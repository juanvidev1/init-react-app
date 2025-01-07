#! /bin/bash
# Script to create a README file
# Author: Juanvidev <juanvidev1@gmail.com>

file_path=$1

if [ $file_path == "" ]; then
    echo "Please provide a file path"
    exit 1
fi

cat << EOF > $file_path/README.md
# Plantilla proyectos de front-end con React

Esta es una plantilla para que sea mucho más sencillo iniciar los proyectos front-end en la empresa soundlutions. Además de los features que se incluyen dentro de el comando npm create vite@latest, incluye un custom hook para el manejo de formularios y un formulario de ejemplo que explica cómo se utiliza.

Adicionalmente se incluyen las carpetas:

- hooks
- components
- utils
- lib

para una mejor organización de los detalles de la aplicación, así como la instalación por defecto de tailwindcss para que pueda ser utilizado en cualquier momento para darle estilos de forma más sencilla a los desarrollos
EOF

echo "README.md created successfully"