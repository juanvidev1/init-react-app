#! /bin/bash
# Script to modify App.jsx file to show the form example
# Author: Juanvidev <juanvidev1@gmail.com>

file_path=$1
file_name="App"
extension=$2

if [ $file_path == "" ]; then
    echo "Please provide a file path"
    exit 1
fi

cd $file_path

cat<<EOF > $file_path/$file_name.$extension
import { ExampleForm } from "./components/ExampleForm";
import "./App.css";

/**
 * Este es un template desarrollado para inicializar los proyectos de react para Soundlutions-Commit cuando sea necesario. Incluye algunos features
 * que se consideran necesarios debido a lo que se ha trabajado previamente. Este template puede ser modificado, pero TODOS los commits deben ser
 * previamente aprobados por el equipo de Soundlutions-Commit antes de pasar al template final. Toda la info detallada está en el README. Por favor
 * leerlo antes de realizar cualquier cambio!
 * @returns AppReactElement
 */

function App() {
  return (
    <>
      <ExampleForm />
    </>
  );
}

export default App;
EOF

echo "App modified successfully"