#! /bin/bash
# Program to create and configure locally a new react app with the Soundlutions-Commit template
# Author: Juanvidev <juanvidev1@gmail.com>

initial_path=$(pwd)
echo "Actual path: $initial_path"
sleep 1
option=0
app_path=""
app_name=""
github_url=""
extension=""
apiExtension=""
node_req_version=""

# Clones the scripts from repo
git clone https://github.com/juanvidev1/create-react-app-script.git
cd create-react-app-script
scripts_path=$(pwd)
echo "Script files ready to use on $scripts_path"
sleep 3

# Charges the nvm module so can be used inside the bash script
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


echo "Welcome to create react app script"
# read -e -p "Enter the path to create your app: " app_path
read -p "Enter the name of your app: " app_name
read -p "Select an option: 1 for JavaScript or 2 for TypeScript: " option
read -p "Enter the node version you want to use: " node_req_version
read -p "If you want to create a remote repository, enter the url (make sure you have access rigths first) " github_url

#echo "Creating app in $app_path"
echo "Creating app with name $app_name on $initial_path"
sleep 3

if [[ -z $node_req_version ]]; then
    node_req_version="22.12.0"
fi

current_node_version=$(node -v 2>/dev/null)

if [[ $node_req_version != $current_node_version ]]; then
    echo "Node version is not the same as the required version"
    echo "Installing node version $node_req_version"
    
    if [[ -s "$NVM_DIR/nvm.sh" ]]; then
        nvm install $node_req_version
    else
        echo "Nvm is not installed, please install it first"
        exit 1
    fi
fi 


# This creates the directory or the path if doesn't exists
# if [[ ! -d $initial_path ]]; then
#     echo "Creating directory $app_path"
#     mkdir -p $app_path
# fi

cd $initial_path
# echo "Este es el path $app_path"

if [[ $option == 1 ]]; then
    echo "Creating app with JavaScript"
    apiExtension="js"
    extension="jsx"
    npm create vite@latest $app_name -- --template react -- --no-interactive
elif [[ $option == 2 ]]; then
    echo "Creating app with TypeScript"
    apiExtension="ts"
    extension="tsx"
    npm create vite@latest $app_name -- --template react-ts -- --no-interactive
else
    echo "Invalid option"
fi

new_path=$initial_path/$app_name
sleep 3
cd $new_path
echo "Entering your app directory in $new_path"
sleep 3
nvm use $node_req_version # Uses the jod lts version the same that node 22.12.0
node -v > $new_path/.nvmrc
cd $new_path/src
mkdir components lib hooks utils
# cp $initial_path/createApiFile.sh $app_path
# cp $initial_path/createHookFile.sh $app_path
# cp $initial_path/createComponentFile.sh $app_path
# cp $initial_path/modifyTailwindConfig.sh $app_path
# cp $initial_path/modifyApp.sh $app_path
# cp $initial_path/createREADME.sh $app_path
bash $scripts_path/createApiFile.sh api $new_path/src lib $apiExtension
bash $scripts_path/createHookFile.sh useCustomForm $new_path/src/hooks $extension
bash $scripts_path/createComponentFile.sh ExampleForm $new_path/src components $extension
bash $scripts_path/modifyApp.sh $new_path/src $extension
sleep 3

cd $new_path
echo "Installing dependencies...$new_path"
npm i
echo "Dependencies installed successfully"
sleep 2

echo "Installing tailwindcss and postcss in $new_path"
sleep 1
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
sleep 2
bash $scripts_path/modifyTailwindConfig.sh $new_path
echo "Tailwindcss settings finished"
sleep 2
bash $scripts_path/createREADME.sh $new_path
sleep 2

echo "Repo url $github_url"
if [ -z "$github_url" ]; then
    echo "Skipping remote repository creation"
    git init
    git add .
    git commit -m "Initial commit"
    sleep 3
    echo "Local repository created"
else 
    echo "Creating remote repository"
    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin $github_url
    git push -u origin main
    sleep 3
    echo "Remote repository created"
fi

echo "Path for running the app $new_path"
sleep 2
cd $initial_path
echo "Cleaning up on $initial_path..."
rm -rf create-react-app-script

cd $new_path
npm run dev

URL="http://localhost:5173"

# Comprobar el sistema operativo y abrir la URL en el navegador
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$URL"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open "$URL"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
    explorer.exe "$URL"
else
    echo "No se soporta este sistema operativo"
fi
