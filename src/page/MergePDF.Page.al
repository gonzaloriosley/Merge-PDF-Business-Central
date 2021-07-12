page 50148 MergePDF
{

    Caption = 'MergePDF';
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                usercontrol(pdf; PDF)
                {
                    ApplicationArea = all;

                    trigger DownloadPDF(pdfToNav: text)
                    var
                        TempBlob: Codeunit "Temp Blob";
                        Convert64: Codeunit "Base64 Convert";
                        Ins: InStream;
                        Outs: OutStream;
                        Filename: Text;
                    begin
                        if pdfToNav <> '' then begin
                            Filename := 'Test.pdf';
                            TempBlob.CreateInStream(Ins);
                            TempBlob.CreateOutStream(Outs);
                            Convert64.FromBase64(pdfToNav, Outs);
                            DownloadFromStream(Ins, 'Download', '', '', Filename);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SalesOrder)
            {
                ApplicationArea = All;
                Caption = 'Add Sales Order';
                Image = Order;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    Recref1: RecordRef;
                begin
                    //Get any record
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.FindFirst();
                    SalesHeader.SetRange("No.", SalesHeader."No.");
                    Recref1.GetTable(SalesHeader);
                    MergePDF.AddReportToMerge(Report::"Standard Sales - Order Conf.", Recref1);
                    Message(DocumentAdded, SalesHeader."No.");
                end;
            }
            action(SalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Add Posted Sales Invoice';
                Image = Order;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    Recref2: RecordRef;
                begin
                    SalesInvoiceHeader.FindFirst();
                    SalesInvoiceHeader.SetRange("No.", SalesInvoiceHeader."No.");
                    Recref2.GetTable(SalesInvoiceHeader);
                    MergePDF.AddReportToMerge(Report::"Standard Sales - Invoice", Recref2);
                    Message(DocumentAdded, SalesInvoiceHeader."No.");
                end;
            }
            action(Merge)
            {
                ApplicationArea = All;
                Caption = 'Merge documents';
                Image = Print;
                trigger OnAction()
                begin
                    //To check the JsonArray
                    //Message(format(MergePDF.GetJArray()));
                    CurrPage.pdf.MergePDF(format(MergePDF.GetJArray()));
                end;
            }
            action(Clear)
            {
                ApplicationArea = All;
                Caption = 'Clear documents';
                Image = Delete;
                trigger OnAction()
                var
                begin
                    MergePDF.ClearPDF();
                end;
            }
        }
    }
    var
        MergePDF: Codeunit MergePDF;
        DocumentAdded: Label 'Document %1 added';
}


