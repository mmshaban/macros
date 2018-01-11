'This sub will send a newly created workbook (copy of the ActiveWorkbook).
''It is saving the workbook before mailing it with a date/time stamp.
'After the file is sent the workbook will be deleted from your hard disk.
'Change the mail address and subject in the macro before you run it.

Sub Mail_workbook_Outlook_2()
'Working in Excel 2000-2016
'Mail a copy of the ActiveWorkbook with another file name
'For Tips see: http://www.rondebruin.nl/win/winmail/Outlook/tips.htm
    Dim wb1 As Workbook
    Dim TempFilePath As String
    Dim TempFileName As String
    Dim FileExtStr As String
    Dim OutApp As Object
    Dim OutMail As Object

    With Application
        .ScreenUpdating = False
        .EnableEvents = False
    End With

    Set wb1 = ActiveWorkbook

    'Make a copy of the file/Open it/Mail it/Delete it
    'If you want to change the file name then change only TempFileName
    TempFilePath = Environ$("temp") & "\"
    TempFileName = "Copy of " & wb1.Name & " " & Format(Now, "dd-mmm-yy h-mm-ss")
    FileExtStr = "." & LCase(Right(wb1.Name, Len(wb1.Name) - InStrRev(wb1.Name, ".", , 1)))

    wb1.SaveCopyAs TempFilePath & TempFileName & FileExtStr

    Set OutApp = CreateObject("Outlook.Application")
    Set OutMail = OutApp.CreateItem(0)

    On Error Resume Next
    With OutMail
        .to = "ron@debruin.nl"
        .CC = ""
        .BCC = ""
        .Subject = "This is the Subject line"
        .Body = "Hi there"
        .Attachments.Add TempFilePath & TempFileName & FileExtStr
        'You can add other files also like this
        '.Attachments.Add ("C:\test.txt")
        .Send   'or use .Display
    End With
    On Error GoTo 0

    'Delete the file
    Kill TempFilePath & TempFileName & FileExtStr

    Set OutMail = Nothing
    Set OutApp = Nothing

    With Application
        .ScreenUpdating = True
        .EnableEvents = True
    End With
End Sub
 
