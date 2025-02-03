
Add-Type -AssemblyName System.Windows.Forms


$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select the folder where you want to create the text file"
$folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer


$result = $folderBrowser.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $selectedFolder = $folderBrowser.SelectedPath
    Set-Location $selectedFolder
}
else {
    Write-Host "[ERROR] Folder selection canceled." -ForegroundColor Red
    exit
}


$projectName = Read-Host "Enter Project Name: "

if ([string]::IsNullOrWhiteSpace($projectName)) {
    Write-Host "[ERROR] Project name cannot be empty." -ForegroundColor Red
    exit
}


npm create vite@latest $projectName --

Write-Host "[SUCCESS] Project Created Successfully!" -ForegroundColor Green


Set-Location $projectName


npm i
npm install tailwindcss @tailwindcss/vite



npx tailwindcss init -p

Write-Host "[SUCCESS] Tailwind Installed Successfully!" -ForegroundColor Green

# Configure Tailwind
$tailwindConfigPath = "tailwind.config.js"
$tailwindConfigContent = @'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        title: ['Poppins'],
      }
    },
  },
  plugins: [
  ],
};
'@


$viteConfigPath = "vite.config.ts"
$viteConfigContent = @'
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import react from '@vitejs/plugin-react-swc'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
})
'@

Set-Content -Path $viteConfigPath -Value $viteConfigContent
Write-Output "[SUCCESS] Configured vite.config.ts successfully." -ForegroundColor Green



Set-Content -Path $tailwindConfigPath -Value $tailwindConfigContent
Write-Output "[SUCCESS] tailwind.config.js content has been replaced successfully." -ForegroundColor Green


$appCssPath = "src/app.css"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing app.css successfully." -ForegroundColor Green
}
else {
    Write-Output "[SUCCESS] app.css does not exist." -ForegroundColor Green
}

$indexCssPath = "src/index.css"
$indexCssContent = @'
@import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

@import "tailwindcss";

* {
     scroll-behavior: smooth;
     box-sizing: border-box;
     margin: 0;
}
'@

Set-Content -Path $indexCssPath -Value $indexCssContent
Write-Output "[SUCCESS] Added the Tailwind directives to your CSS successfully." -ForegroundColor Green


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
}
elseif (Test-Path -Path $appJsxPath) {
    Set-Content -Path $appJsxPath -Value $appComponentContent
    Write-Output "[SUCCESS] Cleaned the App.jsx file successfully." -ForegroundColor Green
}
else {
    Write-Output "[SUCCESS] App component file does not exist." -ForegroundColor Green
}



$appCssPath = "src/assets/react.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing react.svg successfully." -ForegroundColor Green
}
else {
    Write-Output "[SUCCESS] react.svg does not exist." -ForegroundColor Green
}


$appCssPath = "public/vite.svg"
if (Test-Path -Path $appCssPath) {
    Remove-Item -Path $appCssPath -Force
    Write-Output "[SUCCESS] Removing vite.svg successfully." -ForegroundColor Green
} else {
    Write-Output "[SUCCESS] vite.svg does not exist." -ForegroundColor Green
}

code .

