# Load necessary assembly for Folder Browser Dialog
Add-Type -AssemblyName System.Windows.Forms

# Initialize the Folder Browser Dialog
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select the folder where you want to create the text file"
$folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer

# Show the Folder Browser Dialog and get the result
$result = $folderBrowser.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $selectedFolder = $folderBrowser.SelectedPath
    Set-Location $selectedFolder
} else {
    Write-Host "[❌] Folder selection canceled."
    exit
}

# Prompt for project name
$projectName = Read-Host "Enter Project Name: "

# Create the Vite project
npm create vite@latest $projectName --

Write-Host "[✅] Project Created Successfully!"

# Navigate to the project directory
Set-Location $projectName

# Install necessary packages
npm i
npm install -D tailwindcss postcss autoprefixer

# Initialize Tailwind CSS
npx tailwindcss init -p

Write-Host "[✅] Tailwind Installed Successfully!"

# Configure Tailwind
$tailwindConfigPath = "tailwind.config.js"
$tailwindConfigContent = @'
/** @type {import("tailwindcss").Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
'@

Set-Content -Path $tailwindConfigPath -Value $tailwindConfigContent
Write-Output "[✅] tailwind.config.js content has been replaced successfully."

# Remove app.css if it exists
$appCssPath = "src/app.css"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[✅] Removing app.css successfully."
} else {
    Write-Output "[✅] app.css does not exist."
}

# Add Tailwind directives to index.css
$indexCssPath = "src/index.css"
$indexCssContent = @'
@tailwind base;
@tailwind components;
@tailwind utilities;
'@

Set-Content -Path $indexCssPath -Value $indexCssContent
Write-Output "[INFO] Added the Tailwind directives to your CSS successfully."

# Clean the App.jsx or App.tsx file
$appTsxPath = "src/App.tsx"
$appJsxPath = "src/App.jsx"
$appComponentContent = @'
const App = () => {
     return (
          <>
               
          </>
     )
}

export default App

'@

if (Test-Path -Path $appTsxPath) {
    Set-Content -Path $appTsxPath -Value $appComponentContent
    Write-Output "[✅] Cleaned the App.tsx file successfully."
} elseif (Test-Path -Path $appJsxPath) {
    Set-Content -Path $appJsxPath -Value $appComponentContent
    Write-Output "[✅] Cleaned the App.jsx file successfully."
} else {
    Write-Output "[✅] App component file does not exist."
}


# Remove react.svg if it exists
$appCssPath = "src/assets/react.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[✅] Removing react.svg successfully."
} else {
    Write-Output "[✅] react.svg does not exist."
}

# Remove vite.svg if it exists
$appCssPath = "public/vite.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[✅] Removing vite.svg successfully."
} else {
    Write-Output "[✅] vite.svg does not exist."
}

code .

