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
  echo "You must provide a file path"
fi

if [ -z "$file_folder" ]; then
  file_folder="components"
fi

if [ -z "$extension" ]; then
  extension="jsx"
fi


mkdir -p $file_path/$file_folder/$file_name
touch $file_path/$file_folder/$file_name/index.$extension

cat<<EOF > $file_path/$file_folder/$file_name/index.$extension
import React from "react";
import { useCustomForm } from "../../hooks/useCustomForm";

/**
 * This is an example component that uses the custom hook useCustomHook
 * The hook handles all related to a form handler, including validation and error handling.
 * You're free, once you created the project, to modify the custom form hook or use it as it is.
 * @returns formElement
 */
export const $file_name = () => {
  const { formData, formErrors, onChange, onValidate } = useCustomForm();

  /**
   * The submit function is created here in the component, because there are to many things you can do with a form
   * @param {event} e
   */
  const handleSubmit = (e) => {
    e.preventDefault();
    if (onValidate(e)) {
      // Aquí puedes enviar los datos del formulario
      console.log("Datos del formulario:", formData);
      alert(\`Datos del formulario: \${JSON.stringify(formData)}\`);
    }
  };

  /**
   * This is an example useEffect, just to see the errorsForm state in the browser console. You can delete if you want to use this same component
   */
  React.useEffect(() => {
    console.log("FormErrors:", formErrors);
  }, [formErrors]);

  return (
    <form onSubmit={handleSubmit} method="POST">
      <div>
        <label htmlFor="name">Nombre:</label>
        <input
          type="text"
          id="name"
          name="name"
          onChange={onChange}
          className="bg-slate-400 ml-2"
        />
        {formErrors.name && (
          <span className="text-xs text-red-500 ml-2">{formErrors.name}</span>
        )}
      </div>
      <div>
        <label htmlFor="email">Email:</label>
        <input
          type="email"
          id="email"
          name="email"
          onChange={onChange}
          className="bg-slate-400 ml-2 my-2"
        />
        {formErrors.email && (
          <span className="text-xs text-red-500 ml-2">{formErrors.email}</span>
        )}
      </div>
      <div>
        <label htmlFor="country">País:</label>
        <select id="country" name="country" onChange={onChange}>
          <option value="">Selecciona un país</option>
          <option value="mx">México</option>
          <option value="us">Estados Unidos</option>
          <option value="ca">Canadá</option>
        </select>
        {formErrors.country && (
          <span className="text-xs text-red-500 ml-2">
            {formErrors.country}
          </span>
        )}
      </div>
      <button type="submit" className="mt-3 bg-amber-300 text-black py-2 px-3">
        Enviar
      </button>
    </form>
  );
};
EOF

echo "File $file_name created successfully"

