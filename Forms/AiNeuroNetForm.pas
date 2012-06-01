{**
@Abstaract(NeuralNet form)
@Author(Prof1983 prof1983@ya.ru)
@Created(21.10.2005)
@LastMod(04.05.2012)
@Version(0.5)

From BaseGroup/nnv
}
unit AiNeuroNetForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WizardNN;

type
  TFormNeuroNet = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  public
    NeuralNetwork: TWizardNeuralNetwork;
  end;

var
  FormNeuroNet: TFormNeuroNet;

implementation

{$R *.DFM}

{ TFormNeuroNet }

procedure TFormNeuroNet.FormCreate(Sender: TObject);
begin
  try
    NeuralNetwork := TWizardNeuralNetwork.Create(); // создаем нейросеть
    NeuralNetwork.LoadFromWizardFile(ExtractFilePath(paramstr(0))+'sum.nnw'); // читаем параметры НС из файла
  except
  end;
end;

procedure TFormNeuroNet.Button1Click(Sender: TObject);
begin
  with NeuralNetwork do
  begin
    InputValues['s1'] := StrToFloat(Edit1.Text); // устанавливаем входы НС
    InputValues['s2'] := StrToFloat(Edit2.Text); //
    Compute;				         // рассчитываем с использование НС
    Label1.Caption := FloatToStr(OutputValues['res']); // выводим результат рассчета
  end;
end;

end.

