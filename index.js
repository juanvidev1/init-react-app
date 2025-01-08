#!/usr/bin/env node

// Lógica para inicializar tu app de React o lo que necesites
import { execSync } from "child_process";
import path from "path";

// Asegúrate de que tu lógica principal esté aquí (o llama a otros scripts)
console.log("Iniciando la creación de la app React...");

execSync("bash ./scripts/create-react-app.sh", { stdio: "inherit" });

console.log("¡App de React creada con éxito!");
