from flask import render_template, Blueprint

templates_bp = Blueprint('templates', __name__)


@templates_bp.route('/api/template_example')
def template_example():
    """Render a template with some variables"""
    kwargs = {'name': 'David', 'age': '38'}
    return render_template('index.html', **kwargs)
