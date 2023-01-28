@echo off
echo                                      Git auto
echo ===================================================================================
echo.

set /p change=Git change:
echo.
cd "E:\121rh.github.io"
git add .
git commit -m  %change%
git pull origin master
git push origin master 
echo.
echo ===================================================================================
echo                                      update ok
echo.
pause