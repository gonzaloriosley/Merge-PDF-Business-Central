# Merge PDF in Business Central with PDF-LIB Javascript Library

Extension including basic functions to merge pdf documents in Business Central. 
The merge of the documents is done by the PDF-LIB javascript library on the user's browser.

Basic functions to include Report ID and a RecordRef variable or just a base64 string of the pdf.
Look at example Page to check how to properly use the functions.

# Added Azure Function Service

Multiple users have reached out to me asking about the possibility of merging PDFs through an external service, and not through a control add-in, so it can be added to a job queue.

I have added a new example con how to call the webservice and please refer to this github repo to downlaod the Azure Function. Just inform the Azure Function URL. I made sure the json structure between calls is not different.
