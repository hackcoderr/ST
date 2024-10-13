#!/bin/bash

# Base directory
BASE_DIR="smoketester_newman/resources/tsys/uat/us"

# Create directories for Case 1 (auth, card, commercial)
mkdir -p $BASE_DIR/auth/data
mkdir -p $BASE_DIR/card/data
mkdir -p $BASE_DIR/commercial/data

# Create directories for Case 2 (digital, essential)
mkdir -p $BASE_DIR/digital/data
mkdir -p $BASE_DIR/essential/data

# Create JSON files with content

# Case 1: Primary folders (auth, card, commercial)
echo '[
  {
    "clientid": "5678",
    "url": "/auth/login/success/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  },
  {
    "clientid": "5679",
    "url": "/auth/login/failure/",
    "statuscode": 401,
    "authtype": "user",
    "skipTestCase": "true"
  },
  {
    "clientid": "5680",
    "url": "/auth/session/refresh/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  }
]' > $BASE_DIR/auth/data/auth.json

echo '[
  {
    "clientid": "2234",
    "url": "/card/validate/success/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  },
  {
    "clientid": "2235",
    "url": "/card/validate/expired/",
    "statuscode": 400,
    "authtype": "user",
    "skipTestCase": "true"
  },
  {
    "clientid": "2236",
    "url": "/card/limit/exceeded/",
    "statuscode": 403,
    "authtype": "system",
    "skipTestCase": "false"
  }
]' > $BASE_DIR/card/data/card.json

echo '[
  {
    "clientid": "9981",
    "url": "/commercial/account/open/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  },
  {
    "clientid": "9982",
    "url": "/commercial/account/close/",
    "statuscode": 200,
    "authtype": "user",
    "skipTestCase": "false"
  },
  {
    "clientid": "9983",
    "url": "/commercial/funds/transfer/",
    "statuscode": 500,
    "authtype": "system",
    "skipTestCase": "true"
  }
]' > $BASE_DIR/commercial/data/commercial.json

# Case 2: Additional folders (digital, essential)
echo '[
  {
    "clientid": "3456",
    "url": "/digital/wallet/activate/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  },
  {
    "clientid": "3457",
    "url": "/digital/payment/failure/",
    "statuscode": 400,
    "authtype": "user",
    "skipTestCase": "false"
  },
  {
    "clientid": "3458",
    "url": "/digital/wallet/recharge/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  }
]' > $BASE_DIR/digital/data/abc.json

echo '[
  {
    "clientid": "6678",
    "url": "/digital/offer/apply/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  },
  {
    "clientid": "6679",
    "url": "/digital/offer/remove/",
    "statuscode": 404,
    "authtype": "user",
    "skipTestCase": "true"
  },
  {
    "clientid": "6680",
    "url": "/digital/cashback/claim/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  }
]' > $BASE_DIR/digital/data/dcs.json

echo '[
  {
    "clientid": "7812",
    "url": "/essential/shopping/cart/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  },
  {
    "clientid": "7813",
    "url": "/essential/shopping/checkout/",
    "statuscode": 500,
    "authtype": "user",
    "skipTestCase": "true"
  },
  {
    "clientid": "7814",
    "url": "/essential/shopping/payment/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "false"
  }
]' > $BASE_DIR/essential/data/xyz.json

echo '[
  {
    "clientid": "8912",
    "url": "/essential/subscription/start/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  },
  {
    "clientid": "8913",
    "url": "/essential/subscription/cancel/",
    "statuscode": 404,
    "authtype": "user",
    "skipTestCase": "false"
  },
  {
    "clientid": "8914",
    "url": "/essential/subscription/renew/",
    "statuscode": 200,
    "authtype": "system",
    "skipTestCase": "true"
  }
]' > $BASE_DIR/essential/data/pqr.json

echo "Directory structure and JSON files have been created."
