import os


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class Settings:
    log_location = os.path.join(BASE_DIR, 'logs')
    database_location = os.path.join(BASE_DIR, 'db', 'instagrambot.db')
    chromedriver_location = os.path.join(BASE_DIR, 'assets', 'chromedriver')
    chromedriver_min_version = 2.36
