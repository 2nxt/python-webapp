import os
from flask import Flask, render_template
import mariadb

app = Flask(__name__)

@app.route("/")
def main():
    try:
        host = os.environ.get("HOST")
        database = os.environ.get("DATABASE")
        user = os.environ.get("USER")
        password = os.environ.get("PASSWORD")

        cnx = mariadb.connect(host=host, database=database, user=user, password=password)
        cursor = cnx.cursor()

        # Create the 'color' table if it doesn't exist
        cursor.execute("CREATE TABLE IF NOT EXISTS color (color_name VARCHAR(50));")
        cursor.execute("INSERT INTO color (color_name) VALUES ('green');")

        cursor.execute("SELECT color_name FROM color")
        result = cursor.fetchone()
        color = result[0] if result else None
        cursor.close()
        cnx.close()

        if color == "green":
            background_color = "green"
        else:
            background_color = "red"
    except mariadb.Error as error:
        print("Error accessing the database:", error)
        color = None
        background_color = "red"

    return render_template('hello.html', color=color, background_color=background_color)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)