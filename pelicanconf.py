#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Hoily'
SITENAME = 'Hoily'
SITEURL = ''

PATH = 'content'
THEME = "theme"
THEME_STATIC_DIR = "static"
THEME_STATIC_PATHS = ["static/build"]
STATIC_PATHS = ["assets"]
SLUGIFY_SOURCE = 'basename'

TIMEZONE = 'Europe/London'
DEFAULT_LANG = 'en'

# Disable some pages
TAG_URL = False
TAG_SAVE_AS = False
TAGS_SAVE_AS = False
AUTHORS_URL = False
AUTHORS_SAVE_AS = False
CATEGORIES_SAVE_AS = False
ARCHIVES_URL = False
ARCHIVES_SAVE_AS = False
AUTHOR_URL = False
AUTHOR_SAVE_AS = False

# Override page URLs
PAGE_SAVE_AS = "{slug}/index.html"
PAGE_URL = "{slug}/"
ARTICLE_SAVE_AS = "{category}/{slug}/index.html"
ARTICLE_URL = "{category}/{slug}/"
CATEGORY_SAVE_AS = "{slug}/index.html"
CATEGORY_URL = "{slug}/"

# Add ATOM feed
FEED_ATOM = 'feed.atom'
FEED_DOMAIN = SITEURL

DEFAULT_PAGINATION = 10

USE_FOLDER_AS_CATEGORY = True


# Setup markdown extensions
from fontawesome_markdown import FontAwesomeExtension
from pyembed.markdown import PyEmbedMarkdown
from mkdcomments import CommentsExtension
MD_EXTENSIONS = [
    FontAwesomeExtension(),
    PyEmbedMarkdown(),
    CommentsExtension(),
    'codehilite(css_class=highlight)',
    'extra'
]