import os,sys
import base64
import logging

from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import (Mail, Attachment, FileContent, FileName, FileType, Disposition)

for name in ("SENDGRID_API_KEY", "SENDGRID_FROM_EMAIL"):
    if not os.environ.get(name):
        raise SystemExit(f"Missing environment variable: {name}")

api_key = os.environ["SENDGRID_API_KEY"]
sender_email = os.environ["SENDGRID_FROM_EMAIL"]

payload_file = sys.argv[1]
recipient_mail = sys.argv[2]

logging.basicConfig(filename='sender.log',level=logging.DEBUG,format='%(asctime)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p')

#logging.getLogger().addHandler(logging.StreamHandler())

print('Sending ',payload_file,' to ',recipient_mail,' ...\n')

#logging.info('sender.py\n')
logging.info('Sending %s to %s', payload_file, recipient_mail)

message = Mail(
    from_email=sender_email,
    to_emails=str(recipient_mail),
    subject='maile z ladnego basha, prawie dwuklik',
    html_content='<Wiedziałem, że trzeba to robić od poczatku Pythonem :D</strong> <br> Skonfigurję Magdzie kompa i jutro może z tym smigać :)'
)

with open(payload_file, 'rb') as f:
    data = f.read()
    f.close()
encoded_file = base64.b64encode(data).decode()

attachedFile = Attachment(
    FileContent(encoded_file),
    FileName(payload_file),
    FileType('application/zip'),
    Disposition('attachment')
)
message.attachment = attachedFile

sg = SendGridAPIClient(api_key)
try:
    response = sg.send(message)
    logging.info('Sending succesful \n')
except:
    logging.exception('Some shit went wrong with %s \n', recipient_mail)
    raise
print(response.status_code)
#logging.warning('status: %s \n %s \n %s \n', response.status_code, response.body, response.headers)
