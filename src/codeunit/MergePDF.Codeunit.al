codeunit 50149 MergePDF
{
    //HOW TO USE
    //Just call the AddReportToMerge or AddBase64pdf functions as many times as needed and later get call the GetJArray function.
    //You will get an array with all your pdfs in base64 to provide to the javascript function of the controladd-in
    //In case you want to deploy the Azure Function provided, call the CallService procedure

    procedure AddReportToMerge(ReportID: Integer; RecRef: RecordRef)
    var
        Tempblob: Codeunit "Temp Blob";
        Ins: InStream;
        Outs: OutStream;
        Parameters: Text;
        Convert: Codeunit "Base64 Convert";
    begin
        Tempblob.CreateInStream(Ins);
        Tempblob.CreateOutStream(Outs);
        Parameters := '';
        Report.SaveAs(ReportID, Parameters, ReportFormat::Pdf, Outs, RecRef);
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', Convert.ToBase64(Ins));
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;

    procedure AddBase64pdf(base64pdf: text)
    begin
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', base64pdf);
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;

    procedure ClearPDF()
    begin
        Clear(JArrayPDFToMerge);
    end;

    procedure GetJArray() JArrayPDF: JsonArray;
    begin
        JArrayPDF := JArrayPDFToMerge;
    end;

    procedure CallService() ResponseText: Text
    var
        MergePDFSetup: Record "Merge PDF Setup";
        SetupErr: Label 'Please setup Merge PDF page';
        URLErr: Label 'Please set the Azure Function Service URL';
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        contentHeaders: HttpHeaders;
        RequestUrl: Text;
        Body: Text;
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
    begin
        if not MergePDFSetup.Get() then
            Error(SetupErr);
        if MergePDFSetup."Merge PDF Service" = '' then
            Error(URLErr);
        RequestUrl := MergePDFSetup."Merge PDF Service";
        RequestHeaders := Client.DefaultRequestHeaders();
        RequestContent.WriteFrom(format(GetJArray()));
        RequestContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        Client.Post(RequestURL, RequestContent, ResponseMessage);
        if ResponseMessage.IsSuccessStatusCode then
            ResponseMessage.Content().ReadAs(ResponseText);
    end;


    var
        JObjectPDFToMerge: JsonObject;
        JArrayPDFToMerge: JsonArray;
        JObjectPDF: JsonObject;
}