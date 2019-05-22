import json
import base64
import logging
from dmsapi import DMSSession


def apply_extension(data, context):
    logging.info(data)
    logging.info(context)
    decoded_data = base64.b64decode(data['data']).decode()
    logging.info(decoded_data)

    data = json.loads(decoded_data)
    logging.info(str(data))

    user_id, user_password = data['user_id'], data['user_password']
    room, seat = data['position']
    time = data['time']

    session = DMSSession(user_id, user_password)
    if session.extension.apply(time, room, seat):
        logging.info(f"{user_id}: extension apply success")
    else:
        logging.error(f"{user_id}: extension apply failed")
