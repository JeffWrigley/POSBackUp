; 02/04/2015


#include <FileConstants.au3>
#include <MsgBoxConstants.au3>

Global $sDir1, $sDir2, $hSearch, $sFilename, $sNewestFilename, $sNewestDate, $sStoreName

;$sDir1 = FileSelectFolder("Select directory", "")

$sStoreName = "STORENAME"

$sDir1 = @DocumentsCommonDir & "\Intuit\QuickBooks Point of Sale 10.0\Data\" & $sStoreName & "\Backup"
$sDir2 = @UserProfileDir & "\Dropbox\" & $sStoreName

If StringRight($sDir1, 1) <> "\" Then $sDir1 &= "\"
If StringRight($sDir2, 1) <> "\" Then $sDir2 &= "\"

$hSearch = FileFindFirstFile($sDir2 & "*.qpb")

If $hSearch <> -1 Then
    FileDelete($sDir2 & "*.qpb")
EndIf

$hSearch = FileFindFirstFile($sDir1 & "*.qpb")

If $hSearch = -1 Then
    MsgBox(0, "Error", "No .qpb files were found.")
    Exit
EndIf

While 1
    $sFilename = FileFindNextFile($hSearch)
    If @error Then ExitLoop
    $sTemp = FileGetTime($sDir1 & $sFilename, 0, 1)
    If $sTemp > $sNewestDate Then
        $sNewestDate = $sTemp
        $sNewestFilename = $sFilename
    EndIf
WEnd

FileCopy($sDir1 & $sNewestFilename, $sDir2)