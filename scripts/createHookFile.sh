#! /bin/bash
# Script to create a new file inside hooks folder
# Author: Juanvidev <juanvidev1@gmail.com>

file_name=$1
file_path=$2
extension=$3

if [ -z "$file_name" ]; then
  echo "Please provide a file name"
  exit 1
fi

if [ -z "$file_path" ]; then
  echo "You must provide a file path"
fi

if [ -z "$extension" ] && [ $extension != "tsx" ] && [ $extension != "jsx"] ; then
  echo "You must provide a valid file extension"
fi

touch $file_path/$file_name.$extension

cat<<EOF > $file_path/$file_name.$extension
import React, { useState } from "react";

/** Este es un custom hook dedicado al manejo de formularios */
export const $file_name = () => {
  const [formData, setFormData] = React.useState({});
  const [formErrors, setFormErrors] = useState({});

  /**
   * Función que valida que el nombre solo tenga letras, espacios y acentos
   * @param {string} value
   * @returns boolean
   */
  const validateName = (value) => {
    const regexName =
      /^[a-zA-ZÀ-ÿ\u00f1\u00d1]+([\s][a-zA-ZÀ-ÿ\u00f1\u00d1]+)*$/;
    return regexName.test(value);
  };

  /**
   * Función que valida que el selector no esté vacío
   * @param {string} value
   * @returns boolean
   */
  const validateSelector = (value) => {
    return value !== "" && value !== undefined && value !== null;
  };

  /**
   * Función que valida que el email sea válido
   * @param {string} value
   * @returns boolean
   */
  const validateEmail = (value) => {
    const regexEmail = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regexEmail.test(value);
  };

  /**
   * Función que maneja el cambio de los inputs del formulario utilizando el tipo de cada input
   * Realiza las validaciones utilizando las funciones validadoras que utilizan regex. Se deben transportar las funciones para validación de archivos
   * que también se han utilizado bastante en los proyectos de Soundlutions-Commit.
   * @param {event} e
   */
  const changeHandler = (e) => {
    const { name, value, type } = e.target;

    let isValid = true;
    if (
      (type === "text" && name === "name") ||
      (type === "text" && name === "firstName") ||
      (type === "text" && name === "lastName")
    ) {
      if (!value)
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: \`El campo \${name} no puede estar vacío\`,
        }));
      isValid = validateName(value);
      if (!isValid) {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "El nombre no es válido",
        }));
      } else {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "",
        }));
        setFormData((prevData) => ({ ...prevData, [name]: value }));
      }
    } else if (type === "select" || type === "select-one") {
      isValid = validateSelector(value);
      if (!isValid) {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "Debes seleccionar una opción",
        }));
      } else {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "",
        }));
        setFormData((prevData) => ({ ...prevData, [name]: value }));
      }
    } else if (type === "email") {
      if (!value)
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "Este campo no puede estar vacío",
        }));
      isValid = validateEmail(value);
      if (!isValid) {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "El email no es válido",
        }));
      } else {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
          [name]: "",
        }));
        setFormData((prevData) => ({ ...prevData, [name]: value }));
      }
    }
  };

  /**
   * Función que setea los mensajes de error en el formulario.
   * @param {event} e
   * @returns boolean
   */
  const validateForm = (e) => {
    const { elements } = e.target;

    let isValid = true;
    for (let i = 0; i < elements.length; i++) {
      const element = elements[i];
      const { name, value, type } = element;
      console.log(type);

      if (type === "text" || type === "email") {
        if (!value) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: [name]: \`El campo \${name} no puede estar vacío\`,
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "select" || type === "select-one") {
        if (!value || value === "") {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes seleccionar una opción",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "checkbox") {
        if (!element.checked) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes aceptar los términos y condiciones",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "number") {
        if (!value) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes ingresar un número",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "radio") {
        const radioGroup = document.getElementsByName(name);
        let radioChecked = false;
        for (let j = 0; j < radioGroup.length; j++) {
          if (radioGroup[j].checked) {
            radioChecked = true;
            break;
          }
        }
        if (!radioChecked) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes seleccionar una opción",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "date") {
        if (!value) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes seleccionar una fecha",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else if (type === "file") {
        if (!value) {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "Debes seleccionar un archivo",
          }));
          isValid = false;
        } else {
          setFormErrors((prevErrors) => ({
            ...prevErrors,
            [name]: "",
          }));
        }
      } else {
        setFormErrors((prevErrors) => ({
          ...prevErrors,
        }));
      }
    }
    return isValid;
  };

  return {
    formData,
    formErrors,
    onChange: changeHandler,
    onValidate: validateForm,
  };
};
EOF

echo "File $file_name created successfully"

