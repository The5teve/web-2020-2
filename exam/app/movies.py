import os
from functools import wraps
import bleach
from flask import Blueprint, render_template, redirect, url_for, request, current_app, flash
from flask_login import login_required, current_user
from tools import  ImageSaver
from models import Movie, Genre, Movie_Genre, Review, Collection, Movie_Collection
from app import db
from config import UPLOAD_FOLDER
import markdown
bp = Blueprint('movies', __name__, url_prefix='/movies')

PERMITTED_PARAMS = ['name','production_year','country','director','screenwriter','actors','duration']
PERMITTED_PARAMS1 = ['user_id', 'movie_id', 'score']

PER_PAGE = 3


def params():
    return { p: request.form.get(p) for p in PERMITTED_PARAMS }

def params1():
    return { p: request.form.get(p) for p in PERMITTED_PARAMS1 }

def check_rights(action):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if not current_user.can(action):
                flash('У вас недостаточно прав для доступа к данной странице', 'danger')
                return redirect(url_for('index'))
            return func(*args, **kwargs)
        return wrapper
    return decorator

@bp.route('/new')
@check_rights('new')
@login_required
def new():
    genres = Genre.query.all()

    return render_template(
        'movies/new.html', 
        genres=genres, 
    )

@bp.route('/create', methods=['POST'])
@check_rights('new')
@login_required
def create():
    f = request.files.get('background_img') 
    img = None
    if f and f.filename:
        img_saver = ImageSaver(f)
        img = img_saver.save()

    description = bleach.clean(request.form.get('description'))    
    movie = Movie(**params(), poster_id=img.id, description=description)
    try:
        db.session.add(movie)
        db.session.commit()
    except:
        flash('Произошла ошибка, попробуйте снова', 'danger')
        return redirect(url_for('movies.new'))
    movie_genre = request.form.getlist('genre_id')

    for genr in movie_genre:
        movie_genres = Movie_Genre(movie_id=movie.id, genre_id=genr)
        db.session.add(movie_genres)
        db.session.commit()
    if img:
        img_saver.bind_to_object(movie)

    flash(f'Фильм {movie.name} был успешно добавлен!', 'success')

    return redirect(url_for('index'))


@bp.route('/<int:movie_id>/show')
@check_rights('show')
@login_required
def show(movie_id):
    movie = Movie.query.get(movie_id)
    reviews = Review.query.filter(Review.movie_id == movie_id )
    own_rev = False
    usr_collection = Collection.query.filter(Collection.user_id == current_user.id)
    for rev in reviews:
        if rev.user_id == current_user.id:
            own_rev = rev
    return render_template(
        'movies/show.html', 
        movie=movie,
        reviews=reviews,
        own_rev=own_rev,
        usr_collection=usr_collection
    )


@bp.route('/<int:movie_id>/edit')
@check_rights('edit')
@login_required
def edit(movie_id):
    genres = Genre.query.all()
    movie_genres = Movie_Genre.query.filter(Movie_Genre.movie_id == movie_id)
    movie = Movie.query.get(movie_id)

    return render_template(
        'movies/edit.html', 
        genres=genres, 
        movie = movie,
        movie_genres=movie_genres,
    )

@bp.route('/<int:movie_id>/delete', methods=['POST'])
@check_rights('delete')
@login_required
def delete(movie_id):
    movie = Movie.query.get(movie_id)
    db.session.delete(movie)
    db.session.commit()
    os.remove(UPLOAD_FOLDER + '/' + str(movie.poster.storage_filename))
    flash('Фильм удален', 'info')
    return redirect(url_for('index'))

@bp.route('/<int:movie_id>/update', methods=['POST'])
@check_rights('edit')
@login_required
def update(movie_id):
    description = bleach.clean(request.form.get('description'))   
    movie = Movie.query.get(movie_id)
    movie.name = request.form.get('name')
    movie.production_year = request.form.get('production_year')
    movie.country = request.form.get('country')
    movie.director = request.form.get('director')
    movie.screenwriter = request.form.get('screenwriter')
    movie.duration = request.form.get('duration')
    movie.actors = request.form.get('actors')
    movie.description = description
    try:
        db.session.add(movie)
        db.session.commit()
    except:
        flash("Произошла ошибка, попробуйте снова", "danger")
        return redirect(url_for('movies.edit', movie_id=movie_id))


    old_movie_genre = Movie_Genre.query.filter(Movie_Genre.movie_id == movie_id)
    for mg in old_movie_genre:
        db.session.delete(mg)
        db.session.commit()
    movie_genre = request.form.getlist('genre_id')
    for genr in movie_genre:
        movie_genres = Movie_Genre(movie_id=movie.id, genre_id=genr)
        db.session.add(movie_genres)
        db.session.commit()
    flash("Фильм успешно отредактирован", "success")
    return redirect(url_for('index'))


@bp.route('/<int:movie_id>/review')
@login_required
def review(movie_id):
    return render_template('movies/review.html', movie_id=movie_id)

@bp.route('/<int:movie_id>/draw_review', methods=['POST'])
@login_required
def draw_review(movie_id):
    text = bleach.clean(request.form.get('text')) 
    review = Review(**params1(),text=text) 
    db.session.add(review)
    db.session.commit() 
    flash("Рецензия успешно оставлена", "success")       
    return redirect(url_for('movies.show',movie_id=movie_id))

@bp.route('/<int:user_id>/collections')
@login_required
def collections(user_id):
    collection = Collection.query.filter(Collection.user_id==user_id)
    return render_template('movies/collections.html', collection=collection)

@bp.route('/add_collection', methods=['POST'])
@login_required
def add_collection():
    name=request.form.get('name') or 'Без названия'
    collection=Collection(name=name,user_id=current_user.id)
    db.session.add(collection)
    db.session.commit() 
    flash('Подборка успешно добавлена','success')
    return redirect(url_for('movies.collections',user_id=current_user.id))

@bp.route('/collection/<int:collection_id>')
@login_required
def collection(collection_id):
    collection = Movie_Collection.query.filter(Movie_Collection.collection_id==collection_id)
    cname = Collection.query.get(collection_id)
    cname = cname.name
    return render_template('movies/collection.html', collection=collection,cname=cname)

@bp.route('/to_collection', methods=['POST'])
@login_required
def to_collection():
    movie_id = request.form.get('movie_id') 
    collection_id = request.form.get('collection_id')
    movie_collection= Movie_Collection(movie_id=movie_id,collection_id=collection_id)
    try:
        db.session.add(movie_collection)
        db.session.commit() 
    except:
        flash('Ошибка, фильм уже в подборке', 'danger')
        return redirect(url_for('movies.show',movie_id=movie_id))
    flash('Фильм добавлен в подборку', 'success')
    return redirect(url_for('movies.show',movie_id=movie_id))