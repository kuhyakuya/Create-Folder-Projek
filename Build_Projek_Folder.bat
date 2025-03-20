@echo off
setlocal enabledelayedexpansion

:: Input nama proyek dari user
set /p project_name="Masukkan nama project: "

:: Tentukan path utama project
set "project_path=%CD%\%project_name%"
set "shortcut_path=D:\00-Projek Shortcut"
set "hidden_dummy_path=D:\DummyHidden"

:: === CEK APAKAH FOLDER DUMMYHIDDEN ADA, JIKA TIDAK, BUAT & SEMBUNYIKAN ===
if not exist "%hidden_dummy_path%" (
    echo [DEBUG] Membuat folder DummyHidden...
    mkdir "%hidden_dummy_path%"
)
attrib +h "%hidden_dummy_path%" >nul 2>&1

:: === PINDAHKAN FILE DUMMY KE FOLDER TERSEMBUNYI (REPLACE JIKA ADA) ===
if exist "9681a60a-9dc4-45d7-9837-6aeae46facaf.aam" move /Y "9681a60a-9dc4-45d7-9837-6aeae46facaf.aam" "%hidden_dummy_path%\9681a60a-9dc4-45d7-9837-6aeae46facaf.aam"
if exist "261740ad-ad29-48d7-9102-0f3e0e02d716.aam" move /Y "261740ad-ad29-48d7-9102-0f3e0e02d716.aam" "%hidden_dummy_path%\261740ad-ad29-48d7-9102-0f3e0e02d716.aam"

:: === SHOW FILE DUMMY SEBELUM COPY ===
attrib -h "%hidden_dummy_path%\9681a60a-9dc4-45d7-9837-6aeae46facaf.aam" >nul 2>&1
attrib -h "%hidden_dummy_path%\261740ad-ad29-48d7-9102-0f3e0e02d716.aam" >nul 2>&1

:: === BUAT STRUKTUR FOLDER PROYEK ===
mkdir "%project_path%"
mkdir "%project_path%\Adobe Files"
mkdir "%project_path%\Adobe Files\Render Link"
mkdir "%project_path%\Adobe Files\Backup"
mkdir "%project_path%\Audio"
mkdir "%project_path%\Audio\Audio Project"
mkdir "%project_path%\Audio\Revisi"
mkdir "%project_path%\Audio\Tambahan"
mkdir "%project_path%\Layout"
mkdir "%project_path%\Layout\Layout Project"
mkdir "%project_path%\Layout\Revisi"
mkdir "%project_path%\Layout\Tambahan"
mkdir "%project_path%\Spine"
mkdir "%project_path%\Spine\Spine Project"
mkdir "%project_path%\Spine\Revisi"
mkdir "%project_path%\Spine\Tambahan"

:: === COPY FILE DUMMY KE FOLDER PROYEK DAN RENAME ===
copy /Y "%hidden_dummy_path%\9681a60a-9dc4-45d7-9837-6aeae46facaf.aam" "%project_path%\Adobe Files\%project_name%.prproj"
copy /Y "%hidden_dummy_path%\261740ad-ad29-48d7-9102-0f3e0e02d716.aam" "%project_path%\Adobe Files\%project_name%.aep"

:: === SEMBUNYIKAN KEMBALI FILE DUMMY DI D:\DummyHidden ===
attrib +h "%hidden_dummy_path%\9681a60a-9dc4-45d7-9837-6aeae46facaf.aam" >nul 2>&1
attrib +h "%hidden_dummy_path%\261740ad-ad29-48d7-9102-0f3e0e02d716.aam" >nul 2>&1

:: === BUAT SHORTCUT KE PROJECT & FILE DUMMY ===
if not exist "%shortcut_path%" mkdir "%shortcut_path%"

powershell -ExecutionPolicy Bypass -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%shortcut_path%\%project_name% - Folder.lnk'); $s.TargetPath='%project_path%'; $s.Save()"
powershell -ExecutionPolicy Bypass -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%shortcut_path%\%project_name% - Premiere.lnk'); $s.TargetPath='%project_path%\Adobe Files\%project_name%.prproj'; $s.Save()"
powershell -ExecutionPolicy Bypass -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%shortcut_path%\%project_name% - AfterEffects.lnk'); $s.TargetPath='%project_path%\Adobe Files\%project_name%.aep'; $s.Save()"

:: === SELESAI ===
echo Proyek %project_name% berhasil dibuat!
echo Shortcut disimpan di %shortcut_path%
pause
exit
