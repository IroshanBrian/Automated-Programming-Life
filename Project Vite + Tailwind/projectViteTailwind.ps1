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
    Write-Host "[ERROR] Folder selection canceled." -ForegroundColor Red
    exit
}

# Prompt for project name
$projectName = Read-Host "Enter Project Name: "

if ([string]:IsNullOrWhiteSpace($projectName)) {
    Write-Host "[ERROR] Project name cannot be empty." -ForegroundColor Red
    exit
}

# Create the Vite project
npm create vite@latest $projectName --

Write-Host "[SUCCESS] Project Created Successfully!" -ForegroundColor Green

# Navigate to the project directory
Set-Location $projectName

# Install necessary packages
npm i
npm install -D tailwindcss postcss autoprefixer

# Initialize Tailwind CSS
npx tailwindcss init -p

Write-Host "[SUCCESS] Tailwind Installed Successfully!" -ForegroundColor Green

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
Write-Output "[SUCCESS] tailwind.config.js content has been replaced successfully." -ForegroundColor Green

# Remove app.css if it exists
$appCssPath = "src/app.css"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing app.css successfully." -ForegroundColor Green
} else {
    Write-Output "[SUCCESS] app.css does not exist." -ForegroundColor Green
}

# Add Tailwind directives to index.css
$indexCssPath = "src/index.css"
$indexCssContent = @'
@tailwind base;
@tailwind components;
@tailwind utilities;
'@

Set-Content -Path $indexCssPath -Value $indexCssContent
Write-Output "[SUCCESS] Added the Tailwind directives to your CSS successfully." -ForegroundColor Green

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
    Write-Output "[SUCCESS] Cleaned the App.tsx file successfully." -ForegroundColor Green
} elseif (Test-Path -Path $appJsxPath) {
    Set-Content -Path $appJsxPath -Value $appComponentContent
    Write-Output "[SUCCESS] Cleaned the App.jsx file successfully." -ForegroundColor Green
} else {
    Write-Output "[SUCCESS] App component file does not exist." -ForegroundColor Green
}


# Remove react.svg if it exists
$appCssPath = "src/assets/react.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing react.svg successfully." -ForegroundColor Green
} else {
    Write-Output "[SUCCESS] react.svg does not exist." -ForegroundColor Green
}

# Remove vite.svg if it exists
$appCssPath = "public/vite.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing vite.svg successfully." -ForegroundColor Green
} else {
    Write-Output "[SUCCESS] vite.svg does not exist." -ForegroundColor Green
}

code .

