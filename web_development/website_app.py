from flask import Flask, redirect, url_for, render_template, request, session, flash
from datetime import timedelta

import mysql_helper as db
import pandas as pd

app = Flask(__name__)
app.secret_key = 'hello'
app.permanent_session_lifetime = timedelta(minutes=5) #Session persists for defined duration

class User:
    def __init__(self, username, password, email):
        self.username = username
        self.password = password
        self.email = email

def createClassFromDB(df):
    if len(df) == 1:
        row_data = df.iloc[0].to_dict()
        user = User(**row_data)
        return user
    return None


@app.route('/') #Default domain
def home():
    return render_template('homepage.html')
 
@app.route('/user', methods=['POST','GET']) #References URL extension
def user(username=None):
    email = None
    if 'username' in session:
        user = session['username']

        if request.method == 'POST':
            email = request.form['email']
            session['email'] = email
            flash('Email updated!', 'info')
        else:
            if 'email' in session:
                email = session['email']
        return render_template('user.html', user=user, email=email)
    else:
        flash('You have not logged in!')
        return redirect(url_for('login'))

@app.route('/admin/') #Prevents unauthorised access, extra end slash to intialise new subfolder
def admin():
    flash('You do not have the required permissions to enter this site')
    return redirect(url_for('user')) #Name of function that we call to redirect

@app.route('/login', methods=['POST','GET'])
def login():
    if request.method == 'POST': #User submitted something
        session.permanent = True
        username = request.form['nm']
        password = request.form['pw']
        session['username'] = username
        conn = db.connect_to_db()
        found_user = db.get_all_with_filter(conn, [username], 'users', 'username')
        if not found_user.empty:
            user = createClassFromDB(found_user)
            session['email'] = user.email
        else:
            column_names = ('username', 'password', 'email')
            user_info = (username, password, None)
            db.single_insert_into_table(conn, user_info, column_names, 'users')

        flash(f'Login Successful')
        return redirect(url_for('user', username=username))
    else:
        if 'user' in session: #Already logged in
            flash('Already logged in!')
            return redirect(url_for('user', username=username))
        return render_template('login.html')

@app.route('/logout')
def logout():
    if 'user' in session: #Already logged in
        user = session['username']
        flash(f'You have sucessfully logged out {user}', 'info')
    session.pop('user', None)
    session.pop('email', None)
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)
