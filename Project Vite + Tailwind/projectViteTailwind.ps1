Add-Type -AssemblyName System.Windows.Forms

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

$folderBrowser.Description = "Select the folder where you want to create the text file"
$folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer


$result = $folderBrowser.ShowDialog()


if ($result -eq [System.Windows.Forms.DialogResult]::OK) {

    $selectedFolder = $folderBrowser.SelectedPath
    Set-Location $folderBrowser.SelectedPath

} else {
    Write-Host "[ERROR] Folder selection canceled."
}


$projectName = Read-Host "Enter Project Name: "
npm create vite@latest $projectName --

Write Host "[INFO] Project Created Successfully!"

Set-Location $projectName

npm i


npm install -D tailwindcss postcss autoprefixer


npx tailwindcss init -p

Write Host "[INFO] Tailwind Installed Successfully!"


$filePath = "README.txt"


$textContent = @"
tailwind.config.js:

  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],

index.css:

@tailwind base;
@tailwind components;
@tailwind utilities;

"@


Set-Content -Path $filePath -Value $textContent

Write-Host "[INFO] README.txt file created!"

code .

