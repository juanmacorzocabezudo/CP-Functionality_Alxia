tableextension 50023 AlxiaExtendedTextHeader extends "Extended Text Header"
{
    fields
    {
        field(50000; AGRALAAlergeno; Text[250])
        {
            Caption = 'Alergeno';
            Description = '#210021';
            //OptionCaption = ' ,Cereales que contengan Gluten,Crustáceos y productos a base de crustáceos,Huevos y productos a base de huevo,Pescado y productos a base de pescado,Cacahuetes y productos a base de cacahuetes,Soja y productos a base de soja,Leche y sus derivados (incluida la lactosa),Frutos de cáscara,Apio y productos derivados,Mostaza y productos derivados,Granos de sésamo y productos a base de sésamo,Anhídrido sulfuroso y sulfitos,Altramuces y productos a base de altramuces,Moluscos y productos a base de moluscos';
            //OptionMembers = " ","Cereales que contengan Gluten","Crustáceos y productos a base de crustáceos","Huevos y productos a base de huevo","Pescado y productos a base de pescado","Cacahuetes y productos a base de cacahuetes","Soja y productos a base de soja","Leche y sus derivados (incluida la lactosa)","Frutos de cáscara","Apio y productos derivados","Mostaza y productos derivados","Granos de sésamo y productos a base de sésamo","Anhídrido sulfuroso y sulfitos","Altramuces y productos a base de altramuces","""Moluscos y productos a base de moluscos"";";
            TableRelation = AlxiaAlergenos.Alergeno;
        }
        field(50001; AGRALAContiene; Boolean)
        {
            Caption = 'Contiene';
            Description = '#210021';

            trigger OnValidate()
            begin
                IF AGRALAPuedeContener THEN IF AGRALAContiene THEN ERROR('Tiene marcado puede contener');
            end;
        }
        field(50002; AGRALAPuedeContener; Boolean)
        {
            Caption = 'Puede contener';
            Description = '#210021';

            trigger OnValidate()
            begin
                IF AGRALAPuedeContener THEN IF AGRALAContiene THEN ERROR('Tiene marcado contiene');
            end;
        }
        field(50003; AGRALAMarca; Code[10])
        {
            Caption = 'Marca';
            Description = '#210021';
        }
    }
    keys
    {
        key(NewKey1; AGRALAMarca, AGRALAAlergeno)
        {
        }
    }
}
