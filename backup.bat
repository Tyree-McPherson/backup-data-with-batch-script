@REM Variables declaration.
set "history=PATH_TO_ROOT_FOLDER\history.log"
set "source=PATH_TO_SOURCE_FOLDER"
set "destination=PATH_TO_DESTINATION_FOLDER"
set "currentDate=%date:-=%"
set "backupFolderName=BACKUP_FOLDER_NAME"
set "excludedFolders=EXCLUDED_FOLDERS"

@REM Get the last backup date from the text file.
For /F "UseBackQ Delims==" %%A In (%history%) Do set "lastDate=%%A"

@REM Set the date to the last available date from the log file. If no date is present, use today's date.
set date=%lastDate% || set date=%currentDate%

@REM Backup the source directory to the destination directory.
robocopy %source% "%destination%\%backupFolderName%" *.* /e /z /dcopy:DAT /mir /xd %excludedFolders% /maxage:%date%

@REM Save today's date to the last line of the log file.
echo %currentDate% >> %history%