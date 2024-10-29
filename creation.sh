#!/bin/bash

# Directorio donde se encuentran los archivos markdown
POSTS_DIR="./content/post"

# Encuentra todos los archivos .md de manera recursiva
find "$POSTS_DIR" -type f -name "*.md" | while read -r file; do
  # Verifica si el archivo contiene el parámetro "date"
  if grep -q "^date:" "$file"; then
    # Verifica si el archivo ya contiene el parámetro "creation"
    if ! grep -q "^creation:" "$file"; then
      # Extrae la fecha del parámetro "date"
      date_value=$(grep "^date:" "$file" | cut -d '"' -f2)
      
      # Añade el parámetro "creation" justo después de "date"
      sed -i "/^date:/a creation: \"$date_value\"" "$file"
      
      echo "Añadido 'creation' al archivo: $file con fecha: $date_value"
    else
      echo "'creation' ya existe en el archivo: $file"
    fi
  else
    echo "No se encontró el parámetro 'date' en el archivo: $file"
  fi
done




