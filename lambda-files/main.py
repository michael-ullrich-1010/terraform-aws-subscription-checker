import sourcedefender
from solution_feature import SolutionFeature
import os
import json

import logging
LOGLEVEL = os.environ.get('LOG_LEVEL', 'INFO').upper()
logging.getLogger().setLevel(LOGLEVEL)
for noisy_log_source in ['boto3', 'botocore', 'nose', 's3transfer', 'urllib3']:
    logging.getLogger(noisy_log_source).setLevel(logging.WARN)
LOGGER = logging.getLogger()


def lambda_handler(event, context):

    solution_feature_obj = SolutionFeature(context)
    result = solution_feature_obj.process()
    LOGGER.info(result)

    return {
        'statusCode': 200,
        'body': json.dumps('Message successfully processed')
    }

