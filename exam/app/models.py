import os
from flask import url_for
import sqlalchemy as sa
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
import markdown
from app import db
from users_policy import UsersPolicy, USER_ROLE_ID
class User(db.Model, UserMixin):
    __tablename__ = 'users5'

    id = db.Column(db.Integer, primary_key=True)
    last_name = db.Column(db.String(100), nullable=False)
    first_name = db.Column(db.String(100), nullable=False)
    middle_name = db.Column(db.String(100))
    login = db.Column(db.String(100), nullable=False, unique=True)
    password_hash = db.Column(db.String(100), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())
    role_id = db.Column(db.Integer, db.ForeignKey('roles5.id'))
  
    role = db.relationship('Role')
    def __repr__(self):
        return '<User %r>' % self.login

    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    def can(self, action):
        policy =  UsersPolicy()
        method = getattr(policy, action, None)
        if method:
            return method()
        return False
    def is_user(self):
        return self.role_id == USER_ROLE_ID

class Role(db.Model):
    __tablename__ = 'roles5'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    desc = db.Column(db.Text())

    def __repr__(self):
        return '<Role %r>' % self.name

class Genre(db.Model):
    __tablename__ = 'genres'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)

    def __repr__(self):
        return '<Genre %r>' % self.name


class Poster(db.Model):
    __tablename__ = 'posters'
    id = db.Column(db.String(36), primary_key=True)
    file_name = db.Column(db.String(100), nullable=False)
    mime_type = db.Column(db.String(45), nullable=False)
    md5_hash = db.Column(db.String(255), nullable=False, unique=True)
    
    def __repr__(self):
        return '<Poster %r>' % self.name


    @property
    def url(self):
        return url_for('image', poster_id=self.id)

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return self.id + ext

class Movie(db.Model):
    __tablename__ = 'movies'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text(), nullable=False)
    production_year = db.Column(db.Integer, nullable=False)
    country =  db.Column(db.String(100), nullable=False)
    director =  db.Column(db.String(100), nullable=False)
    screenwriter = db.Column(db.String(100), nullable=False)
    actors =  db.Column(db.String(255), nullable=False)
    duration = db.Column(db.Integer, nullable=False)
    poster_id = db.Column(db.String(36), db.ForeignKey('posters.id'))
 
    poster = db.relationship('Poster', cascade="all, delete")
    movie_genres = db.relationship('Movie_Genre', cascade="all, delete")
    review = db.relationship('Review', cascade="all, delete")
    movie_collection = db.relationship('Movie_Collection', cascade="all, delete")
    @property
    def html(self):
        return markdown.markdown(self.description)


class Review(db.Model):
    __tablename__ = 'reviews'
    id = db.Column(db.Integer, primary_key=True)
    movie_id = db.Column(db.Integer, db.ForeignKey('movies.id'))
    user_id = db.Column(db.Integer, db.ForeignKey('users5.id'))
    score = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text(), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())
    
    user = db.relationship('User')
    @property
    def html(self):
        return markdown.markdown(self.text)

    def __repr__(self):
        return '<Review %r>' % self.name

class Movie_Genre(db.Model):
    __tablename__ = 'movie_genres'
    movie_id = db.Column(db.Integer, db.ForeignKey('movies.id'), primary_key=True)
    genre_id = db.Column(db.Integer, db.ForeignKey('genres.id'), primary_key=True)
    
    genre = db.relationship('Genre')
    movie = db.relationship('Movie')

class Collection(db.Model):
    __tablename__ = 'collections'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users5.id'))
    movie_collection = db.relationship('Movie_Collection')

class Movie_Collection(db.Model):
    __tablename__ = 'movie_collections'
    collection_id = db.Column(db.Integer, db.ForeignKey('collections.id'), primary_key=True)
    movie_id = db.Column(db.Integer, db.ForeignKey('movies.id'), primary_key=True)
    movie = db.relationship('Movie')
    collection = db.relationship('Collection')