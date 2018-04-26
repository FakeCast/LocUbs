# LocUBS
  Api para calcular qual é a Unidade Basica de Saúde mais próxima do usuário.
  A aplicação que irá consumir esta API deverá fornecer a latitude e a longitude do usuário que está solicitando.


  ## Dependencias
  * Ruby 2.3.3
  * Rails 4.2.9
  * Mysql


  ## Rodando a API
  ```shell
  rails db:create
  rails db:migrate
  bundle install
  rails s
  ```

  ## Testes
  ```shell
  bundle exec rspec
  ```

  ## Recursos/Endpoints
  POST /show
  ```JSON
  {"lat" : -15, "lon" : "-34"}
  ```

  GET /refresh
  Criei este endpoint adicional onde a API vai na url que possuí o arquivo com a localização das UBS's e faz um refresh no Banco de dados


  ## TODO
  Criar tokens de autenticação e validações dos campos de input
  Adicionar API do Google para detectar a localização do usuário
