from flask import Flask, redirect, url_for, render_template

app = Flask(__name__)

@app.route('/') #Default domain
def home():
    return render_template('index.html')
 
@app.route('/<name>') #References URL extension
def user(name):
    return render_template('index.html', content=['tim', 'joe', 'mary'])

@app.route('/admin/') #Prevents unauthorised access, extra end slash to intialise new subfolder
def admin():
    return redirect(url_for('user', name='Admin!')) #Name of function that we call to redirect

@app.route('/login')
def login():
    


if __name__ == '__main__':
    app.run(debug=True)