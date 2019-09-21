@ECHO OFF

echo ##############################################################################
echo                           ##### Speedy Git #####
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
color F
REM get date and time
for /f "delims=" %%a in ('date/t') do @set mydate=%%a
for /f "delims=" %%a in ('time/t') do @set mytime=%%a
set currentTime=%mydate%%mytime%
call git status
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

echo.
set /p "msgline=### Type message for your new commit:"
echo.
echo ### Choose to Push or Get ###
echo   Available commands are:
echo    1. Push with automated commit.
echo    2. Push with custom message.
echo    3. Rebuild with Jekyll and Push with auto commit.
echo    4. Pull new updates.
echo    5. Pull and Merge updates from a forked repo.
echo    6. Check your notifications at Github.
echo    7. Show me all remotes...
echo    8. Add an upstream remote from a forked repo.
echo    9. Exit.
set /p "option=### Make your choice:"
echo.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

IF "%option%"=="1" (
	REM add all new files with auto-commit
	call git add .
	call git commit -a -m "Automated commit by Speedy_Git on %currentTime%"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="2" (
	REM make new commit with your custom message
	call git add .
	call git commit -m "%msgline%"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="3" (
	call cd ..
	echo ### The direcotry has been changed with one level backwords.
	echo ### Now press any key to trigger the Jekyll Rebuild process.
    timeout /t -1
	echo ### ... ... ...
	echo bundle exec jekyll build
	echo.
	echo ### Finished with all updates. Moving back to your current directory.
	call cd _site
	echo.
	echo ### List of all updated files:
	call git status
	echo ### ... ... ...
	echo. 
	echo ### Now we will trigger auto commit in GitHub.
	call git add .
	call git commit -a -m "Automated commit by Speedy_Git on %currentTime%"
	call git push origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="4" (
	call git pull origin master
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="5" (
	echo ### Processing your request.
    call git fetch upstream
    echo ### All updates are in your upstream branch. Now, press any key to trigger the merge!
    timeout /t -1
    call git merge upstream/master
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="6" (
	start https://github.com/notifications
	echo ### Processing your request.
	echo.
	echo ### Great, everything went well! Press any key for exit.
	pause >nul
) ELSE IF "%option%"=="7" (
	call git remote -v
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    pause >nul
) ELSE IF "%option%"=="8" (
	set /p "url=### Paste the URL from the original(forked) repo and press Enter:"
    call git remote add upstream %url%
    echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	echo ### Great, everything went well! Press any key for exit.
    pause >nul
) ELSE IF "%option%"=="9" (
	exit
) ELSE (
    exit
)
