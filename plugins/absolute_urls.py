from pelican import signals


def absolute_urls(instance):
    if hasattr(instance, 'url') and instance.url:
        setattr(instance, 'absolute_url', '/' + instance.url)


def register():
    signals.content_object_init.connect(absolute_urls)
