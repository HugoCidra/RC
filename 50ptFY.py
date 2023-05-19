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
        database = 'proj2'
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

@app.route('/proj2/utilizador', methods=['POST'])
def user_registration():
    logging.info('POST /utilizador')
    payload = flask.request.get_json()
    conn = db_connection()
    cursor = conn.cursor()
    
    logging.debug(f'POST /utilizador - payload: {payload}')
    
    req_values = ['nome', 'morada', 'email', 'cc', 'tipo']
    
    for value in req_values:
        if value not in payload:
            return jsonify({'error': value + "not in payload"})
    
    if 'nome' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'nome not in payload'}
        return flask.jsonify(response)
    if 'morada' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'morada not in payload'}
        return flask.jsonify(response)
    if 'email' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'email not in payload'}
        return flask.jsonify(response)
    
    statement = 'SELECT COUNT(*) FROM utilizadores;'
    cursor.execute(statement)
    row = cursor.fetchone()[0]
    statement = 'INSERT INTO utilizador (id, nome, morada, email) VALUES (%s, %s, %s, %s)'
    values = (str(int(row)+1), payload['nome'], payload['morada'], payload['email'])
    
    try:
        cursor.execute(statement, values)
        cursor.execute('commit')
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'POST /utilizador - error: {error}')
        response = {'status': statusCodes['internal_error'], 'error': str(error)}
        conn.rollback()
        return flask.jsonify(response)
    
    if 'cc' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'cc not in payload'}
        return flask.jsonify(response)
    if 'atividade' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'atividade not in payload'}
        return flask.jsonify(response)
    
    statement = 'INSERT INTO consumidor (cc, tipo, utilizador_id) VALUES (%s, %s, %s)'
    values = (payload['cc'], payload['atividade'], str(int(row)+1))
    
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

@app.route('/proj2/utilizador', methods = ['PUT'])
def user_authentication():
    logging.info('PUT /utilizador')
    payload = flask.request.get_json()
    
    conn = db_connection()
    cursor = conn.cursor()

    req_values = ['nome', 'password']
    
    for value in req_values:
        if value not in payload:
            return jsonify({'error': value + "not in payload"})
    
    logging.debug(f'PUT /user - payload: {payload}')
    
    try:
        cursor.execute('SELECT nome, password FROM users;')
        rows = cursor.fetchall()
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'POST /users - error: {error}')
        response = {'status': statusCodes['internal_error'], 'error': str(error)}
        return flask.jsonify(response)
    results = []
    for row in rows:
        content = {'nome': row[0], 'password': row[1]}
        results.append(content)
        
        ##########################################################
        ## token shit here to finish this one
        ##########################################################
        

@app.route('/proj2/musica', methods = ['POST'])
def add_song(token):
    logging.info('POST /musica')
    payload = flask.request.get_json()
    
    conn = db_connection()
    cur = conn.cursor()
    
    logging.debug(f'POST /musica - payload: {payload}')
    
    ##########################################################
    ## token stuff for later to make sure it's an artist
    ##########################################################
    
    #Validação de argumentos
    
    if 'titulo' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'titulo value not in payload'}
        return flask.jsonify(response)
    if 'duracao' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'duracao value not in payload'}
        return flask.jsonify(response)
    if 'ismn' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'ismn value not in payload'}
        return flask.jsonify(response)
    if 'label' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'label value not in payload'}
        return flask.jsonify(response)
    if 'genero' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'genero value not in payload'}
        return flask.jsonify(response)
    if 'dataLancamento' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'dataLancamento value not in payload'}
        return flask.jsonify(response)
    
    if payload['infoArtista'] == '':
        statement = 'SELECT COUNT (*) FROM musica'
        cur.execute(statement)
        row = cur.fetchone()[0]
        
        statement = 'INSERT INTO musica (id, titulo, duracao, ismn, lable, genero, dataLancamento, infoArtista) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
        values = ((str(int(row) + 1)), payload['titulo'], payload['duracao'], payload['ismn'], payload['label'], payload['genero'], payload['dataLancamento'], '')
    else:
        statement = 'SELECT COUNT (*) FROM musica'
        cur.execute(statement)
        row = cur.fetchone()[0]
        
        statement = 'INSERT INTO musica (id, titulo, duracao, ismn, lable, genero, dataLancamento, infoArtista) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'
        values = ((str(int(row) + 1)), payload['titulo'], payload['duracao'], payload['ismn'], payload['label'], payload['genero'], payload['dataLancamento'], payload['infoArtista'])
    
        
    try:
        cur.execute(statement, values)
        conn.commit()
        response = {'status': statusCodes['success'], 'results': f'Inserted song {payload["song_id"]}'}
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'POST /musica - error: {error}')
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}
        
        #an error occurred, so we rollback
        conn.rollback()
    finally:
        if conn is not None:
            conn.close()

    return flask.jsonify(response)

##########################################################
## add_album - album table: temos de pensar melhor
##########################################################

@app.route('/proj2/musica/<nome>/', methods = ['GET'])
def search_song(nome):
    logging.info('GET /proj2/musica/<nome>')
    payload = flask.request.get_json()

    logging.debug(f'GET /proj2/musica/<nome> - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    try:
        cur.execute('SELECT * FROM musica WHERE nome LIKE %%s% ORDER BY nome;', (nome))
        rows = cur.fetchall()
        
        logging.debug('GET /proj2/musica/<nome> - parse')
        results = []
        for row in rows:
            logging.debug(row)
            content = {'titulo': row[1], 'duracao': row[2], 'ismn': int(row[3]), 'label': row[4], 'genero': row[5], 'dataLancamento': row[6], 'infoArtistas': row[7]}
            results.append(content)
            
        response = {'status': statusCodes['success'], 'results': results}
            
        
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'GET /proj2/musica/<nome> - error: {error}')
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}

        conn.rollback()
        
    finally:
        if conn is not None:
            conn.close()

    return flask.jsonify(response)

@app.route('/proj2/artista/<id>', methods = ['GET'])
def detail_artist(id):
    logging.info('GET /proj2/artista/<id>')
    payload = flask.request.get_json()

    logging.debug(f'GET /proj2/artista/<id> - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    try:
        ##########################################################
        ## too tired to figure out the query right now
        ##########################################################
        print() #este print tem de estar aqui senao funny linhas vermelhas enquanto no other code
        
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'GET /proj2/artista/<id> - error: {error}')
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}

    finally:
        if conn is not None:
            conn.close()

    return flask.jsonify(response)

@app.route('/proj2/subscricao', methods = ['POST'])
def sub_premium(token):
    logging.info('POST /proj2/subscricao')
    payload = flask.request.get_json()

    logging.debug(f'POST /proj2/subscricao - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    
    ##########################################################
    ## token shit here to finish this one (must be cliente)
    ##########################################################
    
    ##########################################################
    ## query needed to change user in token to premium user
    ## and also pre paid card logic that I'm once again too
    ## tired now to figure out
    ##########################################################

@app.route('/proj2/playlist', methods = ['POST'])
def create_playlist(token):
    logging.info('POST /proj2/playlist')
    payload = flask.request.get_json()

    logging.debug(f'POST /proj2/playlist - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    ##########################################################
    ## token shit here to finish this one 
    ## must be cliente AND premium
    ## then just normal query stuff (INSERT INTO stuff, it's simple)
    ##########################################################

@app.route('/proj2/<id>', methods = ['PUT'])
def play(id, token):
    logging.info('PUT /proj2/<id>')
    payload = flask.request.get_json()

    logging.debug(f'PUT /proj2/<id> - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    ##########################################################
    ## some token shit to make sure user and all that
    ##########################################################
    
    if 'id' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'id value not in payload'}
        return flask.jsonify(response)
    
    

@app.route('/proj2/cartao_pre_pago/', methods = ['POST'])
def generate_pre_paid(token):
    logging.info('POST /proj2/cartao_pre_pago/')
    payload = flask.request.get_json()

    logging.debug(f'POST /proj2/cartao_pre_pago/ - payload: {payload}')

    conn = db_connection()
    cur = conn.cursor()
    
    ##########################################################
    ## cena de tokens para make sure admin
    ##########################################################
    
    if 'num' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'num value not in payload'}
        return flask.jsonify(response)
    if 'limitDate' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'limitDate value not in payload'}
        return flask.jsonify(response)
    if 'valor' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'valor value not in payload'}
        return flask.jsonify(response)
    if 'preco' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'preco value not in payload'}
        return flask.jsonify(response)
    
    statement = 'SELECT COUNT (*) FROM cartao_pre_pago;'
    cur.execute(statement)
    row = cur.fetchone()[0]
    
    statements = []
    valuess = []
    for i in range(int(payload['num'])):
        statement = 'INSERT INTO cartao_pre_pago (id, limitDate, valor, preco) VALUES (%s, %s, %s, %s)'
        values = ((str(int(row) + 1)), payload['limitDate'], payload['valor'], payload['preco'])
        
        statements.append(statement)
        valuess.append(values)
    
    try:
        for i in range(int(payload['num'])):
            cur.execute(statements[i], valuess[i])
            
            conn.commit()
        response = {'status': statusCodes['success'], 'results': f'Inserted pre_paid(s)'}
    
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f' POST /proj2/cartao_pre_pago/ - error: {error}')
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}

        #an error occurred, so we rollback
        conn.rollback()

    finally:
        if conn is not None:
            conn.close()

    return flask.jsonify(response)

@app.route('/proj2/comentario/<song_id>', methods = ['POST'])
def comentario():
    logging.info('POST /comentario')
    payload = flask.request.get_json()

    conn = db_connection()
    cur = conn.cursor()

    logging.debug(f'POST /comentario - payload: {payload}')

    if 'conteudo' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'conteudo value not in payload'}
        return flask.jsonify(response)
    if 'song_id' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'song_id value not in payload'}
        return flask.jsonify(response)
    if 'user_id' not in payload:
        response = {'status': statusCodes['api_error'], 'results': 'user_id value not in payload'}
        return flask.jsonify(response)
    
    statement = 'SELECT COUNT (*) FROM musica'
    cur.execute(statement)
    row = cur.fetchone()[0]
    
    statement = 'INSERT INTO comentario (id, conteudo, song_id, user_id) VALUES (%s, %s, %s, %s)'
    values = (str(int(row) + 1), payload['conteudo'], payload['song_id'], payload['user_id'])
    
    try:
        cur.execute(statement, values)
        conn.commit()
        response = {'status': statusCodes['success'], 'results': f'Inserted comment {payload["product_id"]}'}
    
    except (Exception, psycopg2.DatabaseError) as error:
        logging.error(f'POST /comentario - error: {error}')
        response = {'status': statusCodes['internal_error'], 'errors': str(error)}
    
        conn.rollback()
    
    finally:
        if conn is not None:
            conn.close()

    return flask.jsonify(response)