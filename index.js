#!/usr/bin/env node

// Lógica para inicializar tu app de React o lo que necesites
import { execSync } from "child_process";
import path from "path";

// Obtener los parámetros de la línea de comandos
const appName = process.argv[2]; // El segundo argumento pasado al script
console.log(`Creating React app with name: ${appName}`);

// Llamar al script bash con el parámetro
const scriptPath = "./scripts/create-react-app.sh";
console.log(`Executing script: ${scriptPath} ${appName}`);
console.log("Current working directory:", process.cwd(), path);
if (!appName) {
  execSync(`${scriptPath}`, { stdio: "inherit" });
} else {
  execSync(`${scriptPath} ${appName}`, { stdio: "inherit" });
}
