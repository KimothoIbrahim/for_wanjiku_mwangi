import datetime
import os
from zoneinfo import ZoneInfo

import click
import MySQLdb
import MySQLdb.cursors
from flask import current_app, g

def get_db():
    """Create and reuse a database connection"""
    
    if "db" not in g:
        g.db = MySQLdb.connect(
            host=os.environ.get("DB_HOST", "localhost"),
            user=os.environ.get("DB_USER"),
            passwd=os.environ.get("DB_PASSWD"),
            db=os.environ.get("DB")
        )

    return g.db

def close_db(e=None):
    """Close Database connection"""

    db = g.pop('db', None)

    if db is not None:
        db.close()


def execute(query, args=None, fetch=None):
    """Get a single row from database"""
    db = get_db()

    try:
        cursor = db.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query, args or ())

        result = None
        if fetch == "all":
            result = cursor.fetchall()
        elif fetch == "one":
            result = cursor.fetchone()

        db.commit()
        return result
    except Exception as e:
        raise

def get_one(query, args=None):
    """Retrieve many rows from database"""
    return execute(query, args, "one")

def get_all(query, args=None):
    """Retrieve many rows from database"""
    return execute(query, args, "all")

def init_db():
    """Create database Tables"""
    db = get_db()

    with current_app.open_resource('setup.sql') as f:
        sql = f.read().decode('utf8')

        statements = [s.strip() for s in  sql.split(';') if s.strip()]

        for stmt in statements:
            execute(stmt)


@click.command('init-db')
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')


def init_app(app):
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)
import datetime
import os
from zoneinfo import ZoneInfo

import click
import MySQLdb
import MySQLdb.cursors
from flask import current_app, g

def get_db():
    """Create and reuse a database connection"""
    
    if "db" not in g:
        g.db = MySQLdb.connect(
            host=os.environ.get("DB_HOST", "localhost"),
            user=os.environ.get("DB_USER"),
            passwd=os.environ.get("DB_PASSWD"),
            db=os.environ.get("DB")
        )

    return g.db

def close_db(e=None):
    """Close Database connection"""

    db = g.pop('db', None)

    if db is not None:
        db.close()


def execute(query, args=None, fetch=None):
    """Get a single row from database"""
    db = get_db()

    try:
        cursor = db.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query, args or ())

        result = None
        if fetch == "all":
            result = cursor.fetchall()
        elif fetch == "one":
            result = cursor.fetchone()

        db.commit()
        return result
    except Exception as e:
        raise

def get_one(query, args=None):
    """Retrieve many rows from database"""
    return execute(query, args, "one")

def get_all(query, args=None):
    """Retrieve many rows from database"""
    return execute(query, args, "all")

def init_db():
    """Create database Tables"""
    db = get_db()

    with current_app.open_resource('setup.sql') as f:
        sql = f.read().decode('utf8')

        statements = [s.strip() for s in  sql.split(';') if s.strip()]

        for stmt in statements:
            execute(stmt)


@click.command('init-db')
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')


def init_app(app):
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)
