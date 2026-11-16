from django.urls import path
from .views import ListeArticlesView, creeeArticleView

urlpatterns = [
    path('', ListeArticlesView.as_view(), name='liste_articles'),  # URL pour la liste des articles
    path('nouveau/', creeeArticleView.as_view(), name='cree_article'),  # URL pour créer un nouvel article
]