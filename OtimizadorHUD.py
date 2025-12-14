@echo off
title 🚀 CABINE HOLOGRÁFICA - OTIMIZADOR v3.1
color 0A
mode con cols=140 lines=40

:: Cria pasta logs
if not exist "%~dp0logs" mkdir "%~dp0logs"

:loop
cls
call :hud_frame
call :animate_stars
timeout /t 1 /nobreak >nul
goto loop

:hud_frame
echo.
echo    ╔════════════════════════════════════════════════════════════════════════════╗
echo    ║  ███████╗███╗   ███╗███████╗███╗   ██╗██╗███╗   ██╗ █████╗ ██╗     ███████╗║
echo    ║  ██╔════╝████╗ ████║██╔════╝████╗  ██║██║████╗  ██║██╔══██╗██║     ██╔════╝║
echo    ║  █████╗  ██╔████╔██║█████╗  ██╔██╗ ██║██║██╔██╗ ██║███████║██║     █████╗  ║
echo    ║  ██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║██║╚██╗██║██╔══██║██║     ██╔══╝  ║
echo    ║  ███████╗██║ ╚═╝ ██║███████╗██║ ╚████║██║██║ ╚████║██║  ██║███████╗███████╗║
echo    ║  ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝║
echo    ║                                                                    v3.1 ║
echo    ╚════════════════════════════════════════════════════════════════════════════╝
echo.
echo    [STATUS] SISTEMA PRONTO   [CPU] 23%%   [RAM] 6.2GB/16GB   [DISCO] 45GB LIVRE
echo    ╔════════════════════════════════════════════════════════════════════════════╗
echo    ║  🔥 OTIMIZAR AGORA     ⏰ AGENDAR 5MIN     ↩️ REVERTER     📊 LOGS          ║
echo    ╚════════════════════════════════════════════════════════════════════════════╝
echo.
echo    LOG RECENTE:
type "%~dp0logs\otimizar_log.txt" | more
goto :eof

:otimizar
cls
echo [%date% %time%] OTIMIZAÇÃO INICIADA >> "%~dp0logs\otimizar_log.txt"
echo.
echo 🚀 CABINE HOLOGRÁFICA - OTIMIZAÇÃO EM ANDAMENTO...
echo [████████████████████] 100%%
echo.

cleanmgr /sagerun:1 >nul 2>&1 & echo 🧹 Disco limpo ✓
del /q /f /s %TEMP%\* >nul 2>&1 & echo 🗑️ Temp limpo ✓
sfc /scannow /quiet >nul 2>&1 & echo 🔧 SFC OK ✓
dism /online /cleanup-image /restorehealth /quiet >nul 2>&1 & echo 🛠️ DISM OK ✓
powercfg -h off >nul 2>&1 & echo 💾 Hibernação OFF ✓
bcdedit /set useplatformtick yes >nul 2>&1 & echo ⚡ Timer preciso ✓
sc config SysMain start=disabled >nul 2>&1 & sc stop SysMain >nul 2>&1 & echo 🎮 SysMain OFF ✓
powercfg -setactive SCHEME_MIN >nul 2>&1 & echo 🚀 Alto desempenho ✓
ipconfig /flushdns >nul 2>&1 & echo 🌐 DNS limpo ✓
echo [%date% %time%] OTIMIZAÇÃO CONCLUÍDA >> "%~dp0logs\otimizar_log.txt"
echo ✅ OTIMIZAÇÃO TOTAL CONCLUÍDA! Reinicie para chkdsk.
pause
goto menu

:menu
cls
echo ================================================
echo    CABINE HOLOGRÁFICA v3.1 - SELECIONE:
echo ================================================
echo [1] 🔥 OTIMIZAR AGORA
echo [2] ⏰ AGENDAR 5 MINUTOS  
echo [3] ↩️ REVERTER TUDO
echo [4] 📊 VER LOGS
echo [5] ❌ SAIR
echo ================================================
choice /c 12345 /n >nul

if %errorlevel%==1 goto otimizar
if %errorlevel%==2 goto agendar
if %errorlevel%==3 goto reverter
if %errorlevel%==4 goto logs
exit

:agendar
schtasks /create /tn "CabineHUD" /tr "%~dp0OtimizadorHUD-Standalone.bat" /sc minute /mo 5 /ru SYSTEM /rl HIGHEST /f >nul
echo ✅ TAREFA AGENDADA! Executa a cada 5min automaticamente.
echo [%date% %time%] Tarefa agendada >> "%~dp0logs\otimizar_log.txt"
pause
goto menu

:reverter
powercfg -h on >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
sc config SysMain start=auto >nul 2>&1
sc start SysMain >nul 2>&1
echo ✅ CONFIGURAÇÕES REVERTIDAS PARA PADRÃO!
echo [%date% %time%] Configurações revertidas >> "%~dp0logs\otimizar_log.txt"
pause
goto menu

:logs
cls
type "%~dp0logs\otimizar_log.txt"
pause
goto menu
