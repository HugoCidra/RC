##
## =============================================
## ============== Bases de Dados ===============
## ============== LEI  2022/2023 ===============
## =============================================
## =============================================
## =============================================
## =============================================
## === Department of Informatics Engineering ===
## =========== University of Coimbra ===========
## =============================================
##
## Authors:
##      Hugo Batista Cidra Duarte <2020219765@student.uc.pt>
##      Dinis
##      Carlos
##      University of Coimbra

import flask
from flask import jsonify
import logging
import psycopg2

app = flask.Flask(__name__)

statusCodes = {
    'success': 200,
    'api_error': 400,
    'internal_error': 500
}

##########################################################
## DATABASE ACCESS
##########################################################

def db_connection():
    db = psycopg2.connect(
        user = 'postgres',
        password = 'postgres',
        host = '127.0.0.1',
        port = '5432',
        database = 'projeto'
    )
    
    return db

##########################################################
## ENDPOINTS
##########################################################

@app.route('/')
def landing_page():
    return """

    Hello World (Python native)! <br/>
    <br/>
    Check the sources for instructions on how to use the endpoints!<br/>
    <br/>
    BD 2023 Team<br/>
    <br/>
    """

@app.route('/projeto/utilizador', methods=['POST'])
def user_registration():
    logging.info('POST /utilizador')
    payload = flask.request.get_json()
    conn = db_connection()
    cursor = conn.cursor()
    
    logging.debug(f'POST /utilizador - payload: {payload}')
    
    req_values = ['id', 'nome', 'morada', 'email', 'cc', 'atividade']
    
    for value in req_values:
        if value not in payload:
            return jsonify({'error': value + "not in payload"})
    
    statement = 'SELECT COUNT(*) FROM utilizadores;'
    cursor.execute(statement)
    row = cursor.fetchone()[0]
    statement = 'INSERT INTO utilizador (id) VALUES (%d)'
    values = (payload['id'])
    
    try:
        cursor.execute(statement, values)
        cursor.execute('commit')
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'POST /utilizador - error: {error}')
        response = {'status': statusCodes['internal_error'], 'error': str(error)}
        return flask.jsonify(response)
    
    if 'nome' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'nome not in payload'}
        return flask.jsonify(response)
    if 'morada' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'morada not in payload'}
        return flask.jsonify(response)
    if 'email' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'email not in payload'}
        return flask.jsonify(response)
    if 'cc' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'cc not in payload'}
        return flask.jsonify(response)
    if 'atividade' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'atividade not in payload'}
        return flask.jsonify(response)
    
    statement = 'INSERT INTO consumidor (nome, morada, email, cc, atividade, utilizador_id) VALUES (%s, %s, %s, %s, %s, %s)'
    values = (payload['nome'], payload['morada'], payload['email'], payload['cc'], payload['atividade'], payload['id'])
    
    try:
        cursor.execute(statement, values)
        cursor.execute('commit')
        response = {'status': statusCodes['success'], 'results': 'inserted new consumer'}
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(error)
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}
        conn.rollback()
    finally:
        if conn is not None:
            conn.close()
    
    return flask.jsonify(response)

@app.route('/projeto/utilizador', methods = ['PUT'])
def user_authentication():
    logging.info('PUT /utilizador')
    payload = flask.request.get_json()
    
    