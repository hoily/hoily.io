import iso8601


def format_datetime(value):
    return iso8601.parse_date(str(value)).strftime("%x")


def category_find(categories, name):
    for category_name, articles in categories:
        if category_name == name:
            return articles
    return []


def limit(line, length):
    if isinstance(line, str):
        if len(line) <= length:
            return line
        return " ".join(line.split(" ")[:length]) + '...'
    elif isinstance(line, list):
        return line[:length]
