from django.views.generic import ListView
from django.views.generic.edit import CreateView
from django.urls import reverse_lazy

from .models import Article
from .forms import articleForm

class ListeArticlesView(ListView):
    model = Article  # Spécifie le modèle à utiliser
    template_name = 'blog/list_articles.html'  # Spécifie le template
    context_object_name = 'articles'  # Le nom utilisé dans le template

    def get_queryset(self):
        query = self.request.GET.get('q')  # Récupère la valeur du paramètre de recherche 'q'
        if query:
            return Article.objects.filter(title__icontains=query)  # Filtre les articles par titre
        return Article.objects.all()  # Retourne tous les articles si aucun paramètre de recherche

class creeeArticleView(CreateView):
    model = Article
    form_class = articleForm
    template_name = 'blog/cree_article.html'
    success_url = reverse_lazy('liste_articles')  # Redirige vers la liste des articles après la création
