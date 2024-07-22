table 50100 "Merge PDF Setup"
{
    Caption = 'Merge PDF Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Code[10])
        {
            Caption = 'PK';
        }
        field(2; "Merge PDF Service"; Text[1024])
        {
            Caption = 'Merge PDF Service';
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
