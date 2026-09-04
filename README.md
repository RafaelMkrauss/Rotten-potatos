# RottenPotatoes

Catálogo de filmes em Ruby on Rails. Implementado como a Parte 1 do Homework 2,
seguindo o Capítulo 4 do livro *Engineering Software as a Service: An Agile
Approach Using Cloud Computing*, de Armando Fox e David Patterson.

O app expõe um único recurso — `Movie` — com o CRUD completo sobre rotas RESTful:
listar, ver, criar, editar e apagar filmes.

## Requisitos

- Ruby 3.4.10
- Bundler

O banco é SQLite, embutido na gem `sqlite3` — não é preciso instalar nada à parte.

## Como rodar

```sh
bundle install
bin/rails db:migrate     # cria a tabela movies
bin/rails db:seed        # popula com os filmes do livro
bin/rails server
```

A aplicação sobe em <http://localhost:3000>, que redireciona para `/movies`.

Para zerar o banco e recomeçar do estado inicial:

```sh
bin/rails db:reset
```

## Rotas

Todas geradas por `resources :movies` em `config/routes.rb`.

| Verbo    | Caminho            | Ação             | Para quê                       |
|----------|--------------------|------------------|--------------------------------|
| `GET`    | `/movies`          | `movies#index`   | Lista todos os filmes          |
| `GET`    | `/movies/new`      | `movies#new`     | Formulário de cadastro         |
| `POST`   | `/movies`          | `movies#create`  | Grava o filme novo             |
| `GET`    | `/movies/:id`      | `movies#show`    | Detalhes de um filme           |
| `GET`    | `/movies/:id/edit` | `movies#edit`    | Formulário de edição           |
| `PATCH`  | `/movies/:id`      | `movies#update`  | Grava a edição                 |
| `DELETE` | `/movies/:id`      | `movies#destroy` | Apaga o filme                  |

A raiz (`/`) redireciona para `/movies`.

## O modelo

Um filme tem título, classificação indicativa, descrição e data de estreia, além
dos `created_at`/`updated_at` que o Rails mantém sozinho.

| Coluna         | Tipo       |
|----------------|------------|
| `title`        | `string`   |
| `rating`       | `string`   |
| `description`  | `text`     |
| `release_date` | `datetime` |

As classificações aceitas ficam em `Movie::RATINGS` (`G`, `PG`, `PG-13`, `R`,
`NC-17`) e são a fonte única tanto da validação quanto do menu do formulário.
Título, classificação e data de estreia são obrigatórios.

## Onde está cada coisa

```
app/models/movie.rb                  model e validações
app/controllers/movies_controller.rb as sete ações do CRUD
app/views/movies/                    index, show, new, edit e o partial _form
app/views/layouts/application.html.erb  layout, com as mensagens de flash
app/assets/stylesheets/application.css  estilos
config/routes.rb                     o mapa de URLs
db/migrate/                          a migration da tabela movies
db/seeds.rb                          os filmes iniciais
```

## Banco de dados

O arquivo SQLite fica em `storage/` e **não** é versionado — cada pessoa que
clonar o repositório gera o seu com `db:migrate` e `db:seed`. O que vai para o
git é a migration, que descreve como construir o schema, e o `db/schema.rb`, que
registra o estado atual dele.
