#!/bin/bash

# Скрипт должен запускаться из корневой директории проекта

set -e

SRC_DIR="./src"
README_FILE="./README.md"

# Проверка, что директория src существует
if [ ! -d "$SRC_DIR" ]; then
    echo "Ошибка: директория $SRC_DIR не найдена"
    exit 1
fi

# 1) Удаление ненужных файлов из src
FILES_TO_DELETE=(
    "$SRC_DIR/App.css"
    "$SRC_DIR/App.test.js"
    "$SRC_DIR/index.css"
    "$SRC_DIR/logo.svg"
    "$SRC_DIR/reportWebVitals.js"
    "$SRC_DIR/setupTests.js"
)

for file in "${FILES_TO_DELETE[@]}"; do
    if [ -f "$file" ]; then
        rm "$file"
        echo "Удалён: $file"
    else
        echo "Пропущен (не найден): $file"
    fi
done

# 1.1) Удаление README.md из корня проекта
if [ -f "$README_FILE" ]; then
    rm "$README_FILE"
    echo "Удалён: $README_FILE"
else
    echo "Пропущен (не найден): $README_FILE"
fi

# 2) Очистка и запись нового содержимого в App.js
cat > "$SRC_DIR/App.js" << 'EOF'
function App() {
  return (
    <div className="App">

    </div>
  );
}

export default App;
EOF

echo "Обновлён: $SRC_DIR/App.js"

# 3) Очистка и запись нового содержимого в index.js
cat > "$SRC_DIR/index.js" << 'EOF'
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
    <App />
);
EOF

echo "Обновлён: $SRC_DIR/index.js"

echo "Готово."
