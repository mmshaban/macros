'Note: In this example we open the new file that we create with SaveCopyAs and edit it with code before we create the mail : In this example we insert a text and Date in cell A1 of the first sheet in the workbook.
'wb2.Worksheets(1).Range("A1").Value = "Copy created on " & Format(Date, "dd-mmm-yyyy")

'Other things you can think of are, delete a whole sheet or a range in the workbook you want to mail.

Sub Mail_workbook_Outlook_3()
'Working in Excel 2000-2016
'Mail a changed copy of the ActiveWorkbook with another file name
'For Tips see: http://www.rondebruin.nl/win/winmail/Outlook/tips.htm
    Dim wb1 As Workbook
    Dim wb2 As Workbook
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

    'Make a copy of the file/Open it/Edit it/Mail it/Delete it
    'If you want to change the file name then change only TempFileName
    TempFilePath = Environ$("temp") & "\"
    TempFileName = "Copy of " & wb1.Name & " " & Format(Now, "dd-mmm-yy h-mm-ss")
    FileExtStr = "." & LCase(Right(wb1.Name, Len(wb1.Name) - InStrRev(wb1.Name, ".", , 1)))

    wb1.SaveCopyAs TempFilePath & TempFileName & FileExtStr
    Set wb2 = Workbooks.Open(TempFilePath & TempFileName & FileExtStr)


    '**************Add code to edit the file here********************
    'Insert a text and Date in cell A1 of the first sheet in the workbook.
    'Other things you can think of are for example, delete a whole sheet or a range.
    wb2.Worksheets(1).Range("A1").Value = "Copy created on " & Format(Date, "dd-mmm-yyyy")

    'Save the file after we changed it with the code above
    wb2.Save


    Set OutApp = CreateObject("Outlook.Application")
    Set OutMail = OutApp.CreateItem(0)

    On Error Resume Next
    With OutMail
        .to = "ron@debruin.nl"
        .CC = ""
        .BCC = ""
        .Subject = "This is the Subject line"
        .Body = "Hi there"
        .Attachments.Add wb2.FullName
        'You can add other files also like this
        '.Attachments.Add ("C:\test.txt")
        .Send   'or use .Display
    End With
    On Error GoTo 0
    wb2.Close savechanges:=False

    'Delete the file
    Kill TempFilePath & TempFileName & FileExtStr

    Set OutMail = Nothing
    Set OutApp = Nothing

    With Application
        .ScreenUpdating = True
        .EnableEvents = True
    End With
End Sub
