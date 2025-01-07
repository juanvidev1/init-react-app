#! /bin/bash
# Script to create a new file inside components
# Author: Juanvidev <juanvidev1@gmail.com>

file_name=$1
file_path=$2
file_folder=$3
extension=$4

if [ -z "$file_name" ]; then
  echo "Please provide a file name"
  exit 1
fi

if [ -z "$file_path" ]; then
  file_path=$(pwd)
fi

if [ -z "$file_folder" ]; then
  file_folder="components"
fi

new_path=$file_path/$file_folder/
if [ ! -d "$new_path" ]; then
  mkdir -p $new_path
fi

if [ -z "$extension" ]; then
  extension="jsx"
fi


mkdir -p $file_path/$file_folder/$file_name
touch $file_path/$file_folder/$file_name/index.$extension

cat<<EOF > $file_path/$file_folder/$file_name/index.$extension
import React from "react";

/**
 * This is a base component structure
 */
export const $file_name = () => {

  /**
   * Este useEffect se encarga de mostrar en consola los errores del formulario, por si se quiere ver el estado de los errores en el formulario.
   * En el formulario que se vaya a implementar, se puede eliminar este useEffect y mostrar los errores en el componente que se desee, por ejemplo,
   * en un componente de error que se muestre en el formulario.
   */
  React.useEffect(() => {
    console.log("message:", Welcome);
  }, []);

  return (
    <div>
      <h1>Component $file_name</h1>
    </div>
  );
};
EOF

echo "File $file_name created successfully"

