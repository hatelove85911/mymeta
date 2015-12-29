# install chocolatey
if (!(Test-Path -Path "C:\ProgramData\Chocolatey" )) {
  iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))  
}

# set choco proxy
choco config set proxy http://proxy.sin.sap.corp:8080

# install packages
choco install -y sublime
choco install -y atom
choco install -y vim
choco install -y git
choco install -y vagrant
choco install -y vagrant-manager
choco install -y virtualbox
choco install -y virtualbox.extensionpack
choco install -y googlechrome
choco install -y nodejs
choco install -y nginx
choco install -y putty
choco install -y superputty
choco install -y kitty.portable
# choco install -y jdk8
choco install -y python
choco install -y autohotkey
choco install -y winrar
choco install -y 7zip
choco install -y cygwin
choco install -y ResophNotes
choco install -y dejavufonts

# change system path variable
$git_path_name = "C:\\Program Files\\Git\\cmd"
$git_path_real = "C:\Program Files\Git\cmd"
$vagrant_path_name = "C:\\HashiCorp\\Vagrant\\bin"
$vagrant_path_real = "C:\HashiCorp\Vagrant\bin"
$node_path_name = "C:\\Program Files\\nodejs"
$node_path_real = "C:\Program Files\nodejs"
$npm_path_name = "C:\\Program Files\\nodejs\\node_modules\\npm\\bin"
$npm_path_real = "C:\Program Files\nodejs\node_modules\npm\bin"
$python_path_name = "C:\\tools\\python"
$python_path_real = "C:\tools\python"
$pip_path_name = "C:\\tools\\python\\Scripts"
$pip_path_real = "C:\tools\python\Scripts"
$virtualbox_path_name = "C:\\Program Files\\Oracle\\VirtualBox"
$virtualbox_path_real = "C:\Program Files\Oracle\VirtualBox"


$path2add = ""

if (!($env:Path -match $git_path_name)) {
    $path2add = $path2add + ";" + $git_path_real
}
if (!($env:Path -match $vagrant_path_name)) {
    $path2add = $path2add + ";" + $vagrant_path_real
}
if (!($env:Path -match $node_path_name)) {
    $path2add = $path2add + ";" + $node_path_real
}
if (!($env:Path -match $npm_path_name)) {
    $path2add = $path2add + ";" + $npm_path_real
}
if (!($env:Path -match $python_path_name)) {
    $path2add = $path2add + ";" + $python_path_real
}
if (!($env:Path -match $pip_path_name)) {
    $path2add = $path2add + ";" + $pip_path_real
}
if (!($env:Path -match $virtualbox_path_name)) {
    $path2add = $path2add + ";" + $virtualbox_path_real
}

if( $path2add -ne "" ){
    [Environment]::SetEnvironmentVariable("Path", $env:Path + $path2add, [EnvironmentVariableTarget]::Machine)
    $env:Path = $env:Path + $path2add
}

# git configuration
git config --global user.email "redwolf85911@gmail.com"
git config --global user.name "junshen"

# copy default autohotkey to startup
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\default.ahk.lnk")
$Shortcut.TargetPath = "$Home\Dropbox\mymeta\mothership\win\default.ahk"
$Shortcut.Save()

# pip install packages
# SET HTTPS_PROXY=http://proxy.sin.sap.corp:8080
# SET HTTP_PROXY=http://proxy.sin.sap.corp:8080
# python -m pip install -U pip setuptools --proxy http://proxy.sin.sap.corp:8080
# pip install wheel --proxy http://proxy.sin.sap.corp:8080
# pip install nvPY --proxy http://proxy.sin.sap.corp:8080

# generate ssh key
if(!(Test-Path -Path "$Home\.ssh\id_rsa" )){
    ssh-keygen -t rsa -b 4096 -C "redwolf85911@gmail.com"
}

# setup "my" dir in home dir
if(!(Test-Path -Path "$Home\my" )){
    New-Item -ItemType Directory -Path "$HOME\my"
}

if(!(Test-Path -Path "$Home\my\gitrepo" )){
    New-Item -ItemType Directory -Path "$HOME\my\gitrepo"
}

if(!(Test-Path -Path "$Home\my\libs" )){
    New-Item -ItemType Directory -Path "$HOME\my\libs"
}

if(!(Test-Path -Path "$Home\my\test" )){
    New-Item -ItemType Directory -Path "$HOME\my\test"
}

# setup ubuntu devbox
if(!(Test-Path -Path "$Home\my\devbox" )){
    Copy-Item $HOME\Dropbox\mymeta\mothership\win\devbox $HOME\my -recurse
}






