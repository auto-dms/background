import os
import json
import base64

from google.cloud import firestore
from google.cloud import pubsub_v1

db = firestore.Client()
publisher = pubsub_v1.PublisherClient()


def publish_apply_extension_jobs(data, context):
    topic_name = 'projects/{project_id}/topics/{topic}'.format(
        project_id=os.getenv('GOOGLE_CLOUD_PROJECT'),
        topic='apply-extension',  # Set this to something appropriate.
    )
    docs = db.collection('extensions').get()
    for doc in docs:
        publisher.publish(topic_name, base64.b64encode(json.dumps(doc.to_dict())))
