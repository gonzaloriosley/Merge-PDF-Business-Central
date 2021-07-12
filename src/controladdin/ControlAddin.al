controladdin PDF
{
    Scripts = 'src/script/pdf-lib.min.js',
    'src/script/download.js',
    'src/script/scripts.js';

    MaximumHeight = 1;
    MaximumWidth = 1;
    event DownloadPDF(stringpdffinal: text);
    procedure createPdf();
    procedure MergePDF(JObjectToMerge: text);

}