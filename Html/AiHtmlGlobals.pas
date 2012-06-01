{**
@Abstract(Работа с файлами Html)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.08.2004)
@LastMod(16.05.2012)
@Version(0.5)

0.0.0.2 - 14.02.2006 - Globals
0.0.0.1 - 14.08.2004
}
unit AiHtmlGlobals;

interface

uses
  SysUtils,
  ABase2, ABaseUtils2; 

const
  cAddr = 'http://localhost/';

type
  TArrayStr = array of String;
  THtmlAccept = type String; {конкретизирует тип файла F:\files\doc\docum\net\tags\html.manual.ru\book\html\body\forms\input.php.htm}
  {text/html}

function AA( {Тег ссылки}
  cCgiName: String;             {in}{URL}
  Com: String = '';             {in}{Параметры}
  Title: String = ''            {in}{Подсказка}
  ): String;

function AAForm( {}
  Action: String;               {in}{}
  Method: String = 'post'       {in}{post get}
  ): String;

function AAImg( {Возвращает заполненый тег img}
  SRC: String;                  {in}{Адрес картинки}
  Width: String = '16';         {in}{Ширина}
  Height: String = '16'         {in}{Высота}
  ): String;

function AAInputCheckBox(
  Name: String;
  Value: String;
  Checked: Boolean = False
  ): String;

function AAInputFile( {}
  Name: String;                 {in}{}
  Value: String;                {in}{}
  Accept: THtmlAccept = ''      {in}{}
  ): String;

function AAInputHidden( {}
  Name: String;                 {in}{}
  Value: String                 {in}{}
  ): String;

function AAInputImage( {}
  SRC: String;                  {in}{}
  Name: String = '';            {in}{}
  Value: String = '';           {in}{}
  Title: String = ''            {in}{}
  ): String;

function AAInputPassword(
  Name: String;
  Size: UInt032 = 0
  ): String;

function AAInputRadio(
  Name: String;
  Checked: Boolean = False;
  Value: String = '';
  Title: String = ''
  ): String;

function AAInputSubmit( {}
  Value: String = 'Ok'          {in}{}
  ): String;

function AAInputText( {}
  Name: String;                 {in}{}
  Value: String = '';           {in}{}
  Size: UInt032 = 0             {in}{}
  ): String;

function AALinkCss(
  cAddr: String
  ): String;

function AAMetaLang
  : String;

function AAMetaRefresh(
  URL: String;
  Time: UInt032 = 0
  ): String;

function AAMetaTitle(
  Title: String
  ): String;

function AAMetaType
  : String;

function AATextarea( {Поле ввода текста}
  Name: String;                 {}{обязательный атрибут. Определяет название, которое будет использоваться при идентификации заполненого поля сервером.}
  Value: String = '';           {}{}
  Rows: UInt032 = 10;           {}{определяет количество строк текста, видимых на экране.}
  Cols: UInt032 = 40;           {}{определяет ширину текстового поля – в печатных символах.}
  WRap: String = 'virtual'      {}{определяет способ переноса слов в заполняемой данной заполняемой форме. Возможные значения:}
    {off – перенос слов не происходит (значение по умолчанию)
     virtual – перенос слов только отображается, на сервер же поступает неделимая строка.
     physical – перенос слов будет происходить во всех точках переноса.
    }
  ): String;

function ioFileHtmlCreate( {Создает файл .html с заголовком и окончанием}
  FileName: String;             {in}{Имя файла}
  Heading: TArrayStr;           {in}{Заголовок}
  Ending: TArrayStr             {in}{Окончание}
  ): THandle;

procedure ioFileHtmlCreate2( {Создает файл .html с заголовком и окончанием}
  FileName: String;             {in}{Имя файла}
  Heading: String;              {in}{Заголовок. Если '', то '<html><body>'}
  Body: String;                 {in}{Тело файла}
  Ending: String                {in}{Окончание. Если '', то '</body></html>'}
  );


procedure WEnding( {Завершающие теги}
  T: TDateTime = 0;          {in}{Время генерации}
  Y: String = '';               {in}{Год: 2004-2005}
  V: String = ''                {in}{Версия: 0.0.0.1 - 01.01.2005}
  );

procedure WHeading( {Шапка}
  Title: String;                {in}{Название страници}
  Path: String = '';            {in}{Путь с ссылками}
  Enter: String = '';           {in}{Имя cgi файла}
  RefreshUrl: String = '';      {in}{Url обновления (перескок)}
  RefreshTime: UInt032 = 0      {in}{Время обновления (если надо)}
  );

procedure WHeading1( {}
  Title: String;                {in}{Заголовок}
  RefreshUrl: String = '';      {in}{Url обновления (перескок)}
  RefreshTime: UInt032 = 0      {in}{Время перескока}
  );

procedure WHeading2( {}
  Title: String;                {in}{Заголовок}
  Path: String = '';            {in}{}
  Enter: String = ''            {in}{Имя cgi файла}
  ); forward;

procedure WResError(
  S: String
  );

procedure WResOk(
  S: String
  );

procedure WStarting; {Начало передачи данных}{WStarting - Обязательны первые 2 строки}

implementation

{Теги}

function AA(cCgiName: String; Com: String = ''; Title: String = ''): String;
begin
  Result := '<a href="'+cCgiName;
  if Com <> '' then strAdd(Result, '?com='+Com);
  strAdd(Result, '"');
  if Title <> '' then strAdd(Result, ' title="'+Title+'"');
  strAdd(Result, '>');
end;

function AAForm(Action: String; Method: String = 'post'): String;
begin
  Result := '<form action="'+Action+'" method="'+Method+'">';
end;

function AAImg(SRC: String; Width: String = '16'; Height: String = '16'): String;
begin
  Result := '<img src="'+SRC+'" border="0" width="'+Width+'" height="'+Height+'">';
end;

function AAInputCheckBox(Name, Value: String; Checked: Boolean = False): String;
begin
  Result := '<input type="checkbox" name="'+Name+'" value="'+Value+'"';
  if Checked then strAdd(Result, ' checked="'+BoolToStr(Checked, True)+'"');
  strAdd(Result, '>');
end;

function AAInputFile(Name, Value: String; Accept: THtmlAccept = ''): String;
begin
  Result := '<input type="file" name="'+Name+'" value="'+Value+'" enctype="multipart/form-data">';
end;

function AAInputHidden(Name, Value: String): String;
begin
  Result := '<input type="hidden" name="'+Name+'" value="'+Value+'">';
end;

function AAInputImage(SRC: String; Name: String = ''; Value: String = ''; Title: String = ''): String;
begin
  Result := '<input type="image" src="'+SRC+'" border="0"';
  if Name <> '' then strAdd(Result, ' name="'+Name+'"');
  if Value <> '' then strAdd(Result, ' value="'+Value+'"');
  if Title <> '' then strAdd(Result, ' title="'+Title+'"');
  strAdd(Result, '>');
end;

function AAInputPassword(Name: String; Size: UInt032 = 0): String;
begin
  Result := '<input type="password" name="'+Name+'"';
  if Size > 0 then strAdd(Result, ' size="' + cUInt32ToStr(Size) + '"');
  strAdd(Result, '>');
end;

function AAInputRadio(Name: String; Checked: Boolean = False; Value: String = ''; Title: String = ''): String;
begin
  Result := '<input type="radio" name="'+Name+'"';
  if Checked then strAdd(Result, ' checked="'+BoolToStr(Checked, True)+'"');
  if Value <> '' then strAdd(Result, ' value="'+Value+'"');
  if Title <> '' then strAdd(Result, ' title="'+Title+'"');
  strAdd(Result, '>');
end;

function AAInputSubmit(Value: String = 'Ok'): String;
begin
  if Value = '' then
    Result := '<input type="submit">'
  else
    Result := '<input type="submit" value="'+Value+'">';
end;

function AAInputText(Name: String; Value: String = ''; Size: UInt032 = 0): String;
begin
  Result := '<input type="text" name="'+Name+'"';
  if Value <> '' then strAdd(Result, ' value="'+Value+'"');
  if Size > 0 then strAdd(Result, ' size="' + cUInt32ToStr(Size) + '"');
  strAdd(Result, '>');
end;

function AALinkCss(cAddr: String): String;
begin
  Result := '<link rel="stylesheet" type="text/css" href="' + cAddr + 'styles.css">';
end;

function AAMetaLang: String;
begin
  Result := '<meta http-equiv="Content-Language" content="ru">';
end;

function AAMetaRefresh(URL: String; Time: UInt032 = 0): String;
begin
  Result := '<meta http-equiv="refresh" content="' + cUInt32ToStr(Time) + '; url='+URL+'">';
end;

function AAMetaTitle(Title: String): String;
begin
  Result := '<title>'+Title+'</title>'
end;

function AAMetaType: String;
begin
  Result := '<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">';
end;

(*function ATable(Align: THtmlAlign = 'left'; VALIGN; BORDER; CELLPADDING; CELLSPACING; WIDTH; HEIGHT; BGCOLOR; BACKGROUND): String;
begin
  Result := '<table';
  if Align <> 'left' then strAdd(Result, ' align="'+Align+'"';
end;*)

function AATextarea(Name: String; Value: String = ''; Rows: UInt032 = 10; Cols: UInt032 = 40; WRap: String = 'virtual'): String;
begin
  Result := '<textarea name="'+Name+'"';
  strAdd(Result, ' wrap="'+WRap+'"');
  strAdd(Result, ' rows="' + cUInt32ToStr(Rows) + '"');
  strAdd(Result, ' cols="' + cUInt32ToStr(Cols) + '"');
  strAdd(Result, '>');
  if Value <> '' then strAdd(Result, Value);
  strAdd(Result, '</textarea>');
end;

{Работа с файлами}

function ioFileHtmlCreate(FileName: String; Heading, Ending: TArrayStr): THandle;
{var
  Index, I: Int032;}
begin
  {Result := ioFileOpen(FileName, $FFFF);
  if Result = 0 then Exit;
  Index := Length(Files); SetLength(Files, Index + 1);
  Files[Index].Handle := Result;
  astrCopy(Heading, Files[Index].Header);
  astrCopy(Ending, Files[Index].HEnd);
  for I := 0 to High(Heading) do ioFileWriteStr(Result, Heading[I]);
  for I := 0 to High(Ending) do ioFileWriteStr(Result, Ending[I]);}
  Result := 0;
end;

procedure ioFileHtmlCreate2(FileName: String; Heading: String; Body: String; Ending: String);
var
  F: TextFile;
begin
  AssignFile(F, FileName);
  Rewrite(F);
  if Heading = '' then Heading := '<html>'#13#10 +
    '<head>'#13#10 +
    '<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">'#13#10 +
    '<meta http-equiv="Content-Language" content="ru">'#13#10 + 
    '</head>'#13#10 +
    '<body bgcolor=&F5F5FF>'; {'<html><body>';}
  WriteLn(F, Heading);
  WriteLn(F, Body);
  if Ending = '' then Ending := '</body>'#13#10'</html>';
  WriteLn(F, Ending);
  CloseFile(F);
end;


procedure WEnding(T: TDateTime = 0; Y: String = ''; V: String = '');
begin
  WriteLn('</td></tr></table>');
  {if cDebug then begin
    WriteLn('<br><font size="2"><hr>');
    WriteLn('Режим отладки');
    WriteLn('<br>Ida='+cUInt032ToStr(IdInfo.Ida));
    WriteLn('<br>Idb='+cUInt032ToStr(IdInfo.Idb));
    WriteLn('</font>');
  end;}
  WriteLn('<br><font size="2"><hr>');
  WriteLn('&copy; <a href="mailto:prof5@mail.ru">Prof</a> '+Y);
  WriteLn('<br>'+cDateTime64ToStr2(SysUtils.Now(), 1));
  if V <> '' then WriteLn('<br>Версия: '+V);
  if T > 0 then WriteLn('<br>Время генерации: '+cDateTime64ToStr2(T, 3)+' с.');
  WriteLn('</font></body></html>');
end;

procedure WHeading(Title: String; Path: String = ''; Enter: String = ''; RefreshUrl: String = ''; RefreshTime: UInt032 = 0);
const
  cPassword = 'qwertyuiop';
begin
  WHeading1(Title, RefreshUrl, RefreshTime);
  WHeading2(Title, Path, Enter);

  {WMenu}
  {WriteLn('<table border="0" width="100%" cellpadding="1" cellspacing="0"><tr>');
  WriteLn('<td width="100">');
  WriteLn('<font size="2"><b>Menu</b>');
  WriteLn('<br>Count='+cUInt032ToStr(Count));
  WriteLn('<br>'+A('createnew')+'Создать</a>');
  WriteLn('<br><form method="post" action="'+cCgiName+'">');
  WriteLn('<input type="hidden" name="pas" value="'+APas+'">');
  WriteLn('Com: <input type="text" name="com" value="" size="10">');
  WriteLn('<input type="submit" value="Ok">');
  WriteLn('</form>');
  WriteLn('</font>');
  WriteLn('</td>');}
end;

procedure WHeading1(Title: String; RefreshUrl: String = ''; RefreshTime: UInt032 = 0);
begin
  WriteLn(AAMetaTitle(Title));
  WriteLn(AAMetaType);
  WriteLn(AAMetaLang);
  if RefreshUrl <> '' then WriteLn(AAMetaRefresh(RefreshUrl, RefreshTime));
  //WriteLn(AALinkCss);
  WriteLn('</head><body>');
end;

procedure WHeading2(Title: String; Path: String = ''; Enter: String = '');
begin
  if Path = '' then
    Path := '<font size=2><b>'+Title+'</b></font>'
  else
    Path := '<font size=2>'+Path+' &rarr; <b>'+Title+'</b></font>';

  if Enter = '' then begin WriteLn(Path); WriteLn('<hr><h1>'+Title+'</h1>'); Exit; end;
  {WPath}
  WriteLn('<table border="0" width="100%" cellpadding="1" cellspacing="0"><tr>');
  WriteLn('<td>'+Path+'</td>');
  WriteLn('<td align="right">');
  WriteLn(AAForm(Enter)+'<input type="hidden" name="com" value="Enter"><font size="2">'+AAInputText('name', '', 10)+AAInputPassword('pas', 10)+AAInputImage('http://profcomp/img/button_ok.gif')+'</font></form>');
  WriteLn('</td></tr></table>');
  WriteLn('<hr><h1>'+Title+'</h1>');
end;

procedure WResError(S: String);
begin
  WriteLn('<font color="red">'+S+'</font>');
end;

procedure WResOk(S: String);
begin
  WriteLn('<font color="green">'+S+'</font>');
end;

procedure WStarting;
begin
  WriteLn('Content-Type: text/html');
  WriteLn;
  WriteLn('<html><head>');
end;

end.
