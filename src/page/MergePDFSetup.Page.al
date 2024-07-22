page 50101 "Merge PDF Setup"
{
    Caption = 'Merge PDF Setup';
    PageType = Card;
    SourceTable = "Merge PDF Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Merge PDF Service"; Rec."Merge PDF Service")
                {
                    ToolTip = 'Specifies the value of the Merge PDF Service field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then
            Rec.Insert();
    end;
}
