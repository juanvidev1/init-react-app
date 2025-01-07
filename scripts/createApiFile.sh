#! /bin/bash
# Script to create a new file inside lib 0r utils, by default the file will be created inside lib directory
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
  echo "You must provide a file path"
fi

if [ $file_folder != "lib" ] && [ $file_folder != "utils" ]; then
  echo "The folder must be lib or utils"
  exit 1
fi

touch $file_path/$file_folder/$file_name.$extension

cat<<EOF > $file_path/$file_folder/$file_name.$extension
/** Este archivo sería el indicado para generar los llamados a una api, cuando sea necesario. Este archivo puede ser modificado libremente y esta
 * función de ejemplo debería ser reemplzada por las funciones que se requieran.
 */
export const apiExample = async () => {
  try {
    const response = await fetch("https://api.example.com/data");
    const data = await response.json();
    return data;
  } catch (error) {
    if (error instanceof Error) {
      console.error("Error en la solicitud:", error.message);
    } else {
      console.error("Error en la solicitud:", error);
    }
  }
};
EOF

echo "File $file_name created successfully"

