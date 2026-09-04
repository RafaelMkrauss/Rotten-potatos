Rails.application.routes.draw do
   resources :movies

  # a raiz do site manda o visitante para a lista de filmes
  root to: redirect('/movies')
end