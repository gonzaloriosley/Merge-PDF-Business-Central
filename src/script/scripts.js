
async function MergePDF(pdfstring) {
  const { PDFDocument } = PDFLib

  const pdf = JSON.parse(pdfstring)
  var pdfsToMerge = [];


  for (var j = 0; j < pdf.length; j++) {

    var pdf64 = pdf[j].pdf;
    var raw1 = window.atob(pdf64);
    var len1 = raw1.length;
    var pdfBuffer1 = new Uint8Array(new ArrayBuffer(len1));
    for (var i = 0; i < len1; i++) {
      pdfBuffer1[i] = raw1.charCodeAt(i);
    }

    pdfsToMerge[j] = pdfBuffer1;
  }

  const mergedPdf = await PDFDocument.create();
  for (const pdfBytes of pdfsToMerge) {
    const pdf = await PDFDocument.load(pdfBytes);
    const copiedPages = await mergedPdf.copyPages(pdf, pdf.getPageIndices());
    copiedPages.forEach((page) => {
      mergedPdf.addPage(page);
    });
  }

  const buf = await mergedPdf.saveAsBase64();
  var pdftoNAV = [buf]
  Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("DownloadPDF", pdftoNAV);

}



