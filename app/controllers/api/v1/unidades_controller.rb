module Api
  module V1
    class UnidadesController < ApplicationController
      def show
        params.permit(:lat,:lon)
        unidade = Unidade.new
        render json: unidade.show(params[:lat],params[:lon])
      end
      def refresh
        url = 'http://repositorio.dados.gov.br/saude/unidades-saude/unidade-basica-saude/ubs.csv'
        unidade = Unidade.new
        unidade.refresh(url)
        render json: "Database updated!"
      end
    end
  end
end
