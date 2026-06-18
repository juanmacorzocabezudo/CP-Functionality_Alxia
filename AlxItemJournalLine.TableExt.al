tableextension 50035 AlxItemJournalLine extends "Item Journal Line"
{
    fields
    {
        field(50000; "Formato Producto"; Code[20])
        {
        }
        field(50001; PersonaRecibe; Text[50])
        {
            Caption = 'Persona que recibe';
            Description = 'ADV001';
        }
        field(50002; TemperaturaRecepcion; Decimal)
        {
            Caption = 'Temperatura recepción';
            Description = 'ADV001';
        }
        field(50003; AspectoCorrecto; Option)
        {
            Caption = 'Aspecto correcto';
            Description = 'ADV001';
            OptionMembers = " ", "Sí", No;
        }
        field(50004; HigieneTranspCorrecta; Option)
        {
            Caption = 'Higiene transp. correcta';
            Description = 'ADV001';
            OptionMembers = " ", "Sí", No;
        }
        field(50005; Observaciones; Text[100])
        {
            Description = 'ADV001';
        }
        field(50015; "Related Work Center"; Code[20])
        {
            Caption = 'Related Work Center';
            Description = '#9785';
            Editable = false;
        }
        field(50016; AGRALAUbicacion1; Text[30])
        {
            CalcFormula = Lookup(Item."Shelf No." WHERE("No."=FIELD("Item No.")));
            Caption = 'Ubciación 1';
            Description = '#210021';
            FieldClass = FlowField;
        }
        modify("Item No.")
        {
        trigger OnAfterValidate()
        begin
            //inicio adv0001
            "Formato Producto":=Item.Formato;
        //fin adv0001
        end;
        }
    }
    var Item: Record Item;
}
