import braintree
import stripe
from flask import *
import parse_rest
from requests.auth import HTTPBasicAuth
import requests
# from parse_rest.datatypes import Object
# from parse_rest.connection import register
# from parse_rest.installation import Push
# from parse_rest.user import User

app = Flask(__name__)

PARSE_APPLICATION_ID = "O9KSrO3dDS9UziYYY225chYXr8HPl8NkFyhUVrSn"
PARSE_REST_API_KEY = "TvHxnhUOznxU5OJzNMGgRj2HebToP0Q2tUx0fYAb"
PARSE_MASTER_KEY = "BaUC2VduMWf6CORGqnoaYjsaJ7enKgmCytbuVOzW"
STRIPE_API_KEY = "sk_test_lnqw4PCAMpZFwjQqHEfJbu6I"

# register(PARSE_APPLICATION_ID, PARSE_REST_API_KEY, master_key=None)
stripe.api_key = STRIPE_API_KEY


# class Question(Object): pass
auth_obj = HTTPBasicAuth('AC50ed9d552942331af2889627e3ec8a1e', '61eeec5a3d2d378304ca2b48efa83017')

@app.route("/instatreat/api/v1/version", methods=["GET"])
def status():
  return "0.1"

@app.route("/instatreat/api/v1/stripe/customers/create", methods=["POST"])
def create_customer():
    description = request.form["description"]
    token = request.form["token"]
    try:
        cs =  stripe.Customer.create(
            description=description,
            card=token
        )
        return jsonify(cs)
    except stripe.StripeError,e:
        abort(500)

@app.route("/instatreat/api/v1/stripe/customers/cards/delete", methods=["POST"])
def delete_card():
    customer_id = request.form["customer_id"]
    card_id = request.form["card_id"]
    try:
        customer = stripe.Customer.retrieve(customer_id)
        delete_result = customer.cards.retrieve(card_id).delete()
        return jsonify(delete_result)
    except stripe.StripeError,e:
        abort(500)

@app.route("/instatreat/api/v1/stripe/customers/cards/add", methods=["POST"])
def add_card():
    customer_id = request.form["customer_id"]
    token = request.form["token"]
    try:
        customer = stripe.Customer.retrieve(customer_id)
        create_result = customer.cards.create(card=token)
        return jsonify(create_result)
    except stripe.StripeError,e:
        abort(500)

@app.route("/instatreat/api/v1/stripe/customers/cards/edit", methods=["POST"])
def edit_card():
    customer_id = request.form["customer_id"]
    card_id = request.form["card_id"]
    try:
        customer = stripe.Customer.retrieve(customer_id)
        customer.default_card = card_id
        customer.save()
        return jsonify(customer)
    except stripe.StripeError,e:
        abort(500)

@app.route("/instatreat/api/v1/stripe/charge/create", methods=["POST"])
def create_charge():
    customer_id = request.form["customer_id"]
    amount = int(request.form["amount"]) * 100
    try:
      charge = stripe.Charge.create(
          amount=amount,
          currency="usd",
          customer=customer_id,
      )
      return jsonify(charge)
    except stripe.CardError, e:
      abort(500)

@app.route("/instatreat/api/v1/stripe/charge/refund", methods=["POST"])
def create_refund():
    charge_id = request.form["charge_id"]
    try:
      ch = stripe.Charge.retrieve(charge_id)
      re = ch.refunds.create()
      return jsonify(re)
    except stripe.CardError, e:
      abort(500)


if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5004, debug=True)