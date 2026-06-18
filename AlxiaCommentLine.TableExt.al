tableextension 50025 AlxiaCommentLine extends "Comment Line"
{
    fields
    {
        field(50000; AGRALATipoCertificado; Code[20])
        {
            Caption = 'Tipo certificado';
            Description = '#210021';
            //OptionCaption = ' ,IFS Food,IFS Global Markets,IFS Logistics,IFS Wholesale / Cash & Carry,IFS Broker,IFS PACsecure,BRC Global Standard,BRC Packaging,BRC Storage & Distribution,BRC Agents & Brokers,FSSC 22.000,SQF,PrimusGFS,GLOBALG.A.P.,ISO 17.025,ISO 22.000,ISO 9.000,ISO 14.000';
            //OptionMembers = " ","IFS Food","IFS Global Markets","IFS Logistics","IFS Wholesale / Cash & Carry","IFS Broker","IFS PACsecure","BRC Global Standard","BRC Packaging","BRC Storage & Distribution","BRC Agents & Brokers","FSSC 22.000",SQF,PrimusGFS,"GLOBALG.A.P.","ISO 17.025","ISO 22.000","ISO 9.000","ISO 14.000";
            /*   trigger OnValidate()
              var
                  rlVendor: Record 23;
              begin
              end; */
            TableRelation = AlxiaTipoCertificado."Código";
        }
        field(50001; AGRALAFechaVencimiento; Date)
        {
            Caption = 'Fecha vencimiento';
            Description = '#210021';
        }
        field(50002; AGRALADescripcionProveedor; Text[250])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No."=FIELD("No.")));
            Caption = 'Descripción proveedor';
            Description = '#210021';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
