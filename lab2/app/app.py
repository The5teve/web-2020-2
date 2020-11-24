from flask import Flask, render_template, request, make_response
import operator as op

app = Flask(__name__)
application = app

app.secret_key = 'some_secret'
operations = ['+','-','*','/']
operations_functions = { '+' : op.add, '-': op.sub, '*': op.mul, '/': op.truediv }
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/args')
def args():
    return render_template('args.html')

@app.route('/headers')
def headers():
    return render_template('headers.html')


@app.route('/cookies')
def cookies():
    resp=make_response(render_template('cookies.html'))
    if 'username' in request.cookies:
        resp.set_cookie('username', 'artem', expires=0)
    else:
        resp.set_cookie('username', 'artem')

    return resp

@app.route('/form', methods=['GET', 'POST'])
def form():
    return render_template('form.html')

@app.route('/calc')
def calc():
    try:
        result = None
        error_msg = None
        if request.args.get('operand1'):
            op1 = float(request.args.get('operand1'))
        if request.args.get('operand2'):
            op2 = float(request.args.get('operand2'))
        f = operations_functions[request.args.get('operation')]
        result = f(op1, op2)
    except ValueError:
        error_msg = 'Пожалуйста, вводите только числа'
    except ZeroDivisionError:
        error_msg = 'На ноль делить нельзя!!!'
    except KeyError:
        error_msg = 'Недопустимая операция'
    return render_template('calc.html',operations=operations, result=result, error_msg=error_msg)


@app.route('/phonecheck', methods=['GET','POST'])
def phonecheck():
    digits=None
    numbers=None
    msg=[]
    if request.method == 'POST':
        result = request.form['phone']
        result = result.replace(')','').replace('.','').replace('(','').replace(' ','').replace('-','').replace('.','').replace('+','')
        digits=True
        for x in list(result):
            if not x.isdigit():
                digits=False
                msg.append('Недопустимый ввод. В номере телефона встречаются недопустимые символы')
                break
        if (result.startswith('7') or result.startswith('8')) and len(result)==11:
            numbers=True
        elif len(result)==10:
            result= "8"+result
            numbers=True
        else:
            numbers=False
            msg.append('Недопустимый ввод. Неверное количество цифр.')
        
    else:
        result = None
    if digits and numbers:
       result = f"{result[0]}-{result[1:4]}-{result[4:7]}-{result[7:9]}-{result[9:11]}"
    return render_template('phonecheck.html', result=result, numbers=numbers,digits=digits,msg=msg)