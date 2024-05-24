import os
import flask
from flask import render_template, request, session
from flask import jsonify
import numpy as np
from flask_mysqldb import MySQL
import MySQLdb.cursors
from flask_session import Session
import pandas as pd
import numpy as np
import pickle
from sklearn.ensemble import RandomForestClassifier

app = flask.Flask(__name__, template_folder='Templates')
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

app.config['MYSQL_HOST'] = 'localhost' #hostname
app.config['MYSQL_USER'] = 'root' #username
app.config['MYSQL_PASSWORD'] = '' #password
app.config['MYSQL_DB'] = 'medilab' #database name

mysql = MySQL(app)


@app.route('/')
@app.route('/main', methods=['GET', 'POST'])
def main():
    if flask.request.method == 'GET':
        return(flask.render_template('index.html'))
    
    

    
@app.route('/services', methods=['GET', 'POST'])
def services():
    if flask.request.method == 'GET':
        return(flask.render_template('services.html'))
    
@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if flask.request.method == 'GET':
        return(flask.render_template('contact.html'))
    
@app.route('/doctorindex', methods=['GET', 'POST'])
def doctorindex():
    if flask.request.method == 'GET':
        return(flask.render_template('doctorindex.html'))  
    
@app.route('/patientindex', methods=['GET', 'POST'])
def patientindex():
    if flask.request.method == 'GET':
        return(flask.render_template('patientindex.html')) 
    
@app.route('/patienthome', methods=['GET', 'POST'])
def patienthome():
    if flask.request.method == 'GET':
        return(flask.render_template('patienthome.html')) 
    
@app.route('/addappointment', methods=['GET', 'POST'])
def addappointment():
    if flask.request.method == 'GET':
        return(flask.render_template('addappointment.html')) 
    
@app.route('/aidiagnosis', methods=['GET', 'POST'])
def aidiagnosis():
    if flask.request.method == 'GET':
        return(flask.render_template('aidiagnosis.html')) 
    
@app.route('/appointmentlist', methods=['GET', 'POST'])
def appointmentlist():
    if flask.request.method == 'GET':
        return(flask.render_template('appointmentlist.html')) 

@app.route('/doctorhome', methods=['GET', 'POST'])
def doctorhome():
    if flask.request.method == 'GET':
        return(flask.render_template('doctorhome.html')) 
    

@app.route('/doctorappointment', methods=['GET', 'POST'])
def doctorappointment():
    if flask.request.method == 'GET':
        return(flask.render_template('doctorappointment.html')) 

def getcursor():
    con = mysql.connect
    con.autocommit(True)
    cursor = con.cursor(MySQLdb.cursors.DictCursor)
    return cursor

@app.route('/login', methods=['GET', 'POST'])
def login():
    if flask.request.method == 'POST':
        phone           = request.form['signphone']
        password        = request.form['signpassword']
        
        cursor = getcursor()
        qry = 'SELECT * FROM patient_detail WHERE phone="'+phone+'" AND password="'+password+'"'
        result = cursor.execute(qry)
        result = cursor.fetchone()
        if result:
            msg = "1"
            session["userid"]   = result["patient_id"]
            session["username"]   = result["patient_name"]
            session["usermail"]   = result["email"]
        else:
           msg = "0"
    return msg

@app.route('/logout', methods=['GET', 'POST'])
def logout():
    if flask.request.method == 'GET':
        session.pop('userid', None)
        session.pop('username', None)
        session.pop('usermail', None)
        
        return(flask.render_template('index.html'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    if flask.request.method == 'POST':
        patientname  = request.form['regusername']
        phone        = request.form['regphone']
        email        = request.form['regemail']
        address      = request.form['regaddress']
        age          = request.form['regage']
        gender       = request.form['reggender']
        password     = request.form['regpassword']
        
        cursor = getcursor()
        
        qry = 'SELECT * FROM patient_detail WHERE phone="'+phone+'" AND password="'+password+'"'
        result = cursor.execute(qry)
        result = cursor.fetchone()
        if result:
            msg = '2'
        else:
            cursor.execute('INSERT INTO patient_detail VALUES (NULL, % s, % s, % s, % s, % s, % s, % s, NULL)', (patientname, phone, email, address, age, gender, password, ))
            mysql.connect.commit()
            msg = '1'
        
        return msg
    
@app.route('/getpatientdetail', methods=['GET', 'POST'])
def getpatientdetail():
    patient = session.get("userid")
    cursor = getcursor()
    qry = 'SELECT * FROM patient_detail WHERE patient_id='+str(patient)
    result = cursor.execute(qry)
    result = cursor.fetchone()
    
    return result

@app.route('/getdoctornames', methods=['GET', 'POST'])
def getdoctornames():
    cursor = getcursor()
    qry = 'SELECT * FROM dr_detail'
    cursor.execute(qry)
    result = cursor.fetchall()
    
    return jsonify(result)

@app.route('/getaidiagnosishistory', methods=['GET', 'POST'])
def getaidiagnosishistory():
    cursor = getcursor()
    qry = 'SELECT * FROM ai_detail'
    cursor.execute(qry)
    result = cursor.fetchall()
    
    return jsonify(result)

@app.route('/getpatientappointments', methods=['GET', 'POST'])
def getpatientappointments():
    cursor = getcursor()
    qry = 'SELECT * FROM appointment'
    cursor.execute(qry)
    result = cursor.fetchall()
    
    return jsonify(result)

@app.route('/updatepatient', methods=['GET', 'POST'])
def updatepatient():
    
    
    patient_id = session.get("userid")
    name = request.form["name"]
    phone = request.form["phone"]
    email = request.form["email"]
    address = request.form["address"]
    age = request.form["age"]
    gender = request.form["gender"]
    nickname = request.form["nickname"]
    role = request.form["role"]
    about = request.form["about"]
    
    cursor = getcursor()
    query = (
    "UPDATE patient_detail SET "
    "patient_name = '" + name + "', "
    "phone = '" + phone + "', "
    "email = '" + email + "', "
    "address = '" + address + "', "
    "age = " + str(age) + ", "
    "gender = '" + gender + "', "
    "nickname = '" + nickname + "', "
    "role = '" + role + "', "
    "about = '" + about + "' "
    "WHERE patient_id = " + str(patient_id)
)

    result = cursor.execute(query)
    result = cursor.fetchone()
    
    return "1"

model = pickle.load(open('Data/rf_disease_model.pkl', 'rb'))

@app.route('/detectdisease', methods=['GET', 'POST'])
def detectdisease():
    if flask.request.method == 'POST':
        symptom1 = request.form['symptom1']
        symptom2 = request.form['symptom2']
        symptom3 = request.form['symptom3']
        symptom4 = request.form['symptom4']
        symptom5 = request.form['symptom5']
        symptom6 = request.form['symptom6']
        symptom7 = request.form['symptom7']
        
        input_variables = [[symptom1, symptom2, symptom3, symptom4, symptom5, symptom6]]
        prediction = model.predict(input_variables)[0]
        userid = session.get("userid")
        cursor = getcursor()
        insert_query = (
            "INSERT INTO ai_detail (""symptom1, symptom2, symptom3, symptom4, symptom5, symptom6, symptom7, prediction, userid"
            ") VALUES ("
            "'" + symptom1 + "', "
            "'" + symptom2 + "', "
            "'" + symptom3 + "', "
            "'" + symptom4 + "', "
            "'" + symptom5 + "', "
            "'" + symptom6 + "', "
            "'" + symptom7 + "', "
            "'" + prediction + "', "
            + str(userid) +
            ");"
            
        )
        result = cursor.execute(insert_query)
    return jsonify(prediction)

@app.route('/addappoint', methods=['GET', 'POST'])
def addappoint():
    if flask.request.method == 'POST':
        userid = session.get("userid")
        mode = request.form["mode"]
        doctor = request.form["doctor"]
        time = request.form["time"]
        reason = request.form["reason"]
        
        cursor = getcursor()
        insert_query = (
            "INSERT INTO appointment (""patient_id, doctor_id, mode, timedata, reason"") VALUES ("
            "'" + str(userid) + "', "
            "'" + str(doctor) + "', "
            "'" + mode + "', "
            "'" + time + "', "
            "'" + reason + "'"
            ");"
            
        )
        result = cursor.execute(insert_query)
        return jsonify(str(result))
        
    
if __name__ == "__main__":
    app.run(debug=True)